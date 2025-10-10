import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:x_express/core/config/constant/api.dart';
import 'package:x_express/core/config/widgets/global_snakbar.dart';
import 'package:x_express/features/auth/data/repository/local_storage.dart';
import 'package:x_express/main.dart';
import 'package:http/http.dart' as http;

class RequestException implements Exception {
  final String message;
  final int? statusCode;
  final dynamic responseBody;

  RequestException(this.message, {this.statusCode, this.responseBody});

  @override
  String toString() => 'RequestException: $message (Status: $statusCode)';
}

class Request {
  static final String _domain = AppUrl.baseURL;
  static late Dio _dio;

  static void _initializeDio() {
    _dio = Dio(BaseOptions(
      baseUrl: _domain,
      connectTimeout: Duration(seconds: 30),
      receiveTimeout: Duration(seconds: 30),
      sendTimeout: Duration(seconds: 30),
    ));

    // Debug: Print the base URL being used
    print('🔧 Dio initialized with baseUrl: $_domain');

    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          _logRequest(options.method, options.path, body: options.data);
          handler.next(options);
        },
        onResponse: (response, handler) {
          _logResponse(response);
          handler.next(response);
        },
        onError: (error, handler) {
          _logError(error);
          handler.next(error);
        },
      ),
    );
  }

  static Dio get dio {
    if (!_isDioInitialized()) {
      _initializeDio();
    }
    return _dio;
  }

  static bool _isDioInitialized() {
    try {
      return _dio.options.baseUrl.isNotEmpty;
    } catch (e) {
      return false;
    }
  }

  static Future<Map<String, String>> _buildHeaders({bool includeContentType = false}) async {
    try {
      final token = await LocalStorage.getToken();
      final headers = <String, String>{
        if (token != null) 'Authorization': 'Bearer $token',
      };

      if (includeContentType) {
        headers['Content-Type'] = 'application/json';
      }

      return headers;
    } catch (e) {
      print('Token error: $e');
      final headers = <String, String>{};
      if (includeContentType) {
        headers['Content-Type'] = 'application/json';
      }
      return headers;
    }
  }

  // Enhanced logging
  static void _logRequest(String method, String route, {dynamic body}) {
    // Show the actual request being made (Dio will handle the base URL)
    print('🌐 $method: $route');
    print('🔧 Full URL will be: $_domain$route');
    if (body != null && body is! FormData) {
      print('📤 Request Body: ${body is String ? body : jsonEncode(body)}');
    } else if (body is FormData) {
      print('📤 Request Body: FormData with ${body.fields.length} fields and ${body.files.length} files');
    }
  }

  static void _logResponse(Response response) {
    print('   Status: ${response.statusCode}');
    print('   Data: ${response.data}');
  }

  static void _logError(DioException error) {
    print('❌ Error for ${error.requestOptions.path}:');
    print('   Type: ${error.type}');
    print('   Message: ${error.message}');
    if (error.response != null) {
      print('   Status: ${error.response?.statusCode}');
      print('   Data: ${error.response?.data}');
    }
  }

  // Enhanced error handling
  static RequestException _handleDioError(DioException error, String route) {
    String errorMessage;

    switch (error.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        errorMessage = 'Request timeout. Please try again.';
        break;

      case DioExceptionType.connectionError:
        errorMessage = 'No internet connection. Please check your network.';
        break;

      case DioExceptionType.badResponse:
        errorMessage =
            error.response?.data?['message'] ?? error.response?.data?['msg'] ?? 'Request failed. Please try again.';
        break;

      case DioExceptionType.cancel:
        errorMessage = 'Request was cancelled.';
        break;

      default:
        errorMessage = 'Something went wrong. Please try again.';
        break;
    }

    // // Show snackbar for the error
    // SnackBarHelper.show(errorMessage);

    return RequestException(
      errorMessage,
      statusCode: error.response?.statusCode,
      responseBody: error.response?.data,
    );
  }

  // Method to handle status -1 responses
  static void _handleStatusMinusOne(dynamic responseData) {
    String message = responseData?['msg'] ?? responseData?['message'] ?? 'Something went wrong';
    // SnackBarHelper.show(message);
  }

  // GET request with Dio
  static Future<dynamic> get(String route, {Map<String, dynamic>? queryParameters}) async {
    try {
      final headers = await _buildHeaders(includeContentType: true);

      final response = await dio.get(
        route,
        queryParameters: queryParameters,
        options: Options(headers: headers),
      );

      // Check for state -1 in response (your API uses 'state' not 'status')
      if (response.data != null && response.data is Map && response.data['state'] == -1) {
        // Fallback: If state: -1 and msg is null, this might indicate success for any operation
        if (response.data['msg'] == null || response.data['msg'].toString().isEmpty) {
          print('✅ GET operation successful (state: -1 with no error message) - treating as success');
          return response.data; // Return success without showing error dialog
        }

        // For other cases, show error dialog and throw exception
        _handleStatusMinusOne(response.data);
        throw RequestException(
          response.data['msg'] ?? 'Request failed',
          statusCode: response.statusCode,
          responseBody: response.data,
        );
      }

      return response.data;
    } on DioException catch (e) {
      throw _handleDioError(e, route);
    } catch (e) {
      if (e is! RequestException) {
        // SnackBarHelper.show('Unexpected error occurred');
      }
      throw e is RequestException ? e : RequestException('Unexpected error for GET $route: $e');
    }
  }

  static Future<dynamic> post(
    String route,
    dynamic body, {
    List<File>? images,
    String imageFieldName = 'images',
    Map<String, dynamic>? additionalFields,
    ProgressCallback? onSendProgress,
    bool forceFormData = false, // Add this parameter
  }) async {
    try {
      final header = await _buildHeaders(includeContentType: true);

      dynamic requestData;
      Map<String, String> headers = header;

      if (images != null && images.isNotEmpty || forceFormData) {
        // Use FormData for both file and non-file requests when forceFormData is true
        final formData = FormData();

        if (body is Map<String, dynamic>) {
          body.forEach((key, value) {
            formData.fields.add(MapEntry(key, value.toString()));
          });
        }

        if (additionalFields != null) {
          additionalFields.forEach((key, value) {
            formData.fields.add(MapEntry(key, value.toString()));
          });
        }

        if (images != null && images.isNotEmpty) {
          for (int i = 0; i < images.length; i++) {
            final file = images[i];
            final fileName = file.path.split('/').last;
            String fieldName = images.length == 1 ? imageFieldName : '${imageFieldName}[$i]';

            formData.files.add(MapEntry(
              fieldName,
              await MultipartFile.fromFile(
                file.path,
                filename: fileName,
              ),
            ));
          }
        }

        requestData = formData;
        headers.remove('Content-Type'); // Let Dio set the correct multipart boundary
      } else {
        requestData = body;
        headers['Content-Type'] = 'application/json';
      }

      final response = await dio.post(
        route,
        data: requestData,
        options: Options(headers: headers),
        onSendProgress: onSendProgress,
      );

      if (response.data != null && response.data is Map && response.data['state'] == -1) {
        print('🔍 Processing state: -1 response for route: "$route"');
        print('🔍 Route contains overtime: ${route.contains('overtime')}');
        print('🔍 Route contains ApplyApproval: ${route.contains('ApplyApproval')}');
        print('🔍 Route contains hr/mypage/overtime: ${route.contains('hr/mypage/overtime')}');
        print('🔍 Route contains hr/mypage/overtime/ApplyApproval: ${route.contains('hr/mypage/overtime/ApplyApproval')}');
        print('🔍 Response msg: ${response.data['msg']}');

        // For overtime approval, state: -1 with no error message indicates success
        // Don't show error dialog for these cases
        bool isOvertimeApproval = (route.toLowerCase().contains('overtime') && route.toLowerCase().contains('applyapproval')) || route.toLowerCase().contains('hr/mypage/overtime/applyapproval') || route.toLowerCase().contains('hr/mypage/overtime/applyapproval/');

        if (isOvertimeApproval && (response.data['msg'] == null || response.data['msg'].toString().isEmpty)) {
          print('✅ Overtime approval successful (state: -1 with no error message)');
          return response.data; // Return success without showing error dialog
        }

        // Fallback: If state: -1 and msg is null, this might indicate success for any approval operation
        // Check if this looks like a successful approval response
        if (response.data['msg'] == null || response.data['msg'].toString().isEmpty) {
          print('✅ Approval operation successful (state: -1 with no error message) - treating as success');
          return response.data; // Return success without showing error dialog
        }

        // For other cases, show error dialog and throw exception
        _handleStatusMinusOne(response.data);
        throw RequestException(
          response.data['msg'] ?? 'Request failed',
          statusCode: response.statusCode,
          responseBody: response.data,
        );
      }

      return response.data;
    } on DioException catch (e) {
      throw _handleDioError(e, route);
    } catch (e) {
      if (e is! RequestException) {
        print('Unexpected POST error: $e');
        // SnackBarHelper.show('Unexpected error occurred');
      }
      throw e is RequestException ? e : RequestException('Unexpected error for POST $route: $e');
    }
  }

  static Future<dynamic> put(
      String route,
      dynamic body, {
        List<File>? images,
        String imageFieldName = 'images',
        Map<String, dynamic>? additionalFields,
        ProgressCallback? onSendProgress,
        bool forceFormData = false,
      }) async {
    try {
      // print('📡 PUT request to: $route');

      final header = await _buildHeaders(includeContentType: true);
      Map<String, String> headers = Map.from(header); // Make a copy to modify

      dynamic requestData;

      final isMultipart = (images != null && images.isNotEmpty) || forceFormData;

      if (isMultipart) {
        final formData = FormData();

        if (body is Map<String, dynamic>) {
          body.forEach((key, value) {
            if (value != null && _isSimpleType(value)) {
              formData.fields.add(MapEntry(key, value.toString()));
            }
          });
        }

        if (additionalFields != null) {
          additionalFields.forEach((key, value) {
            if (value != null && _isSimpleType(value)) {
              formData.fields.add(MapEntry(key, value.toString()));
            }
          });
        }

        if (images != null && images.isNotEmpty) {
          for (int i = 0; i < images.length; i++) {
            final file = images[i];
            final fileName = file.path.split('/').last;
            final fieldName = images.length == 1 ? imageFieldName : '$imageFieldName[$i]';

            formData.files.add(MapEntry(
              fieldName,
              await MultipartFile.fromFile(file.path, filename: fileName),
            ));
          }
        }

        requestData = formData;
        headers.remove('Content-Type'); // Let Dio set it with boundary
      } else {
        requestData = body;
        headers['Content-Type'] = 'application/json';
      }

      final response = await dio.put(
        route,
        data: requestData,
        options: Options(headers: headers),
        onSendProgress: onSendProgress,
      );

      if (response.data != null &&
          response.data is Map &&
          response.data['state'] == -1) {
        // For travel tracking, state: -1 with no error message indicates success
        if (route.contains('travel') && route.contains('track') && (response.data['msg'] == null || response.data['msg'].toString().isEmpty)) {
          print('✅ Travel tracking successful (state: -1 with no error message)');
          return response.data; // Return success without showing error dialog
        }

        // Fallback: If state: -1 and msg is null, this might indicate success for any operation
        if (response.data['msg'] == null || response.data['msg'].toString().isEmpty) {
          print('✅ Operation successful (state: -1 with no error message) - treating as success');
          return response.data; // Return success without showing error dialog
        }

        // For other cases, show error dialog and throw exception
        _handleStatusMinusOne(response.data);
        throw RequestException(
          response.data['msg'] ?? 'Request failed',
          statusCode: response.statusCode,
          responseBody: response.data,
        );
      }

      return response.data;
    } on DioException catch (e) {
      throw _handleDioError(e, route);
    } catch (e) {
      if (e is! RequestException) {
        print('Unexpected PUT error: $e');
        // SnackBarHelper.show('Unexpected error occurred');
      }
      throw e is RequestException
          ? e
          : RequestException('Unexpected error for PUT $route: $e');
    }
  }

  /// Helper to check if a value is simple (String, num, bool)
  static bool _isSimpleType(dynamic value) {
    return value is String || value is num || value is bool;
  }

  // static Future<dynamic> post(
  //   String route,
  //   dynamic body, {
  //   List<File>? images,
  //   String imageFieldName = 'images',
  //   Map<String, dynamic>? additionalFields,
  //   ProgressCallback? onSendProgress,
  // }) async {
  //   try {
  //     final header = await _buildHeaders(includeContentType: true);
  //
  //     dynamic requestData;
  //     Map<String, String> headers = header;
  //
  //     if (images != null && images.isNotEmpty) {
  //       final formData = FormData();
  //
  //       if (body is Map<String, dynamic>) {
  //         body.forEach((key, value) {
  //           formData.fields.add(MapEntry(key, value.toString()));
  //         });
  //       }
  //
  //       if (additionalFields != null) {
  //         additionalFields.forEach((key, value) {
  //           formData.fields.add(MapEntry(key, value.toString()));
  //         });
  //       }
  //
  //       for (int i = 0; i < images.length; i++) {
  //         final file = images[i];
  //         final fileName = file.path.split('/').last;
  //
  //         String fieldName = images.length == 1 ? imageFieldName : '${imageFieldName}[$i]';
  //
  //         formData.files.add(MapEntry(
  //           fieldName,
  //           await MultipartFile.fromFile(
  //             file.path,
  //             filename: fileName,
  //           ),
  //         ));
  //       }
  //
  //       requestData = formData;
  //       headers.remove('Content-Type');
  //     } else {
  //       requestData = body;
  //       headers['Content-Type'] = 'application/json';
  //     }
  //     final response = await dio.post(
  //       route,
  //       data: requestData,
  //       options: Options(headers: headers),
  //       onSendProgress: onSendProgress,
  //     );
  //     print("check for response is: $response");
  //
  //     if (response.data != null && response.data is Map && response.data['state'] == -1) {
  //       _handleStatusMinusOne(response.data);
  //       throw RequestException(
  //         response.data['msg'] ?? 'Request failed',
  //         statusCode: response.statusCode,
  //         responseBody: response.data,
  //       );
  //     }
  //
  //     return response.data;
  //   } on DioException catch (e) {
  //     throw _handleDioError(e, route);
  //   } catch (e) {
  //     if (e is! RequestException) {
  //       print('Unexpected POST error: $e');
  //       SnackBarHelper.show('Unexpected error occurred');
  //     }
  //     throw e is RequestException ? e : RequestException('Unexpected error for POST $route: $e');
  //   }
  // }

  // Convenience method for single image upload
  static Future<dynamic> postWithSingleImage(
    String route,
    dynamic body,
    File image, {
    String imageFieldName = 'image',
    Map<String, dynamic>? additionalFields,
    ProgressCallback? onSendProgress,
  }) async {
    return post(
      route,
      body,
      images: [image],
      imageFieldName: imageFieldName,
      additionalFields: additionalFields,
      onSendProgress: onSendProgress,
    );
  }

  // Convenience method for multiple images upload
  static Future<dynamic> postWithMultipleImages(
    String route,
    dynamic body,
    List<File> images, {
    String imageFieldName = 'images',
    Map<String, dynamic>? additionalFields,
    ProgressCallback? onSendProgress,
  }) async {
    return post(
      route,
      body,
      images: images,
      imageFieldName: imageFieldName,
      additionalFields: additionalFields,
      onSendProgress: onSendProgress,
    );
  }

  static Future<dynamic> postJson(String route, dynamic body) async {
    return post(route, body);
  }
}

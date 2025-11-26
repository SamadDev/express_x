import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:x_express/core/config/constant/api.dart';
import 'package:x_express/features/Auth/data/repository/local_storage.dart';
import 'package:x_express/features/Home/data/model/order_detail_model.dart';
import 'package:x_express/features/Order/data/model/payment_method_model.dart';

class OrderRepository {
  // Get order details
  Future<OrderDetailModel> getOrderDetails(String orderId) async {
    try {
      final token = await LocalStorage.getToken();
      
      if (token == null) {
        throw Exception('No authentication token found');
      }

      final response = await http.get(
        Uri.parse('${AppUrl.baseURL}orders/$orderId'),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      );

      print('Order Details Response Status: ${response.statusCode}');
      print('Order Details Response Body: ${response.body}');

      if (response.statusCode == 200 || response.statusCode == 201) {
        final jsonResponse = json.decode(response.body);
        return OrderDetailModel.fromJson(jsonResponse);
      } else {
        throw Exception('Failed to load order details: ${response.body}');
      }
    } catch (e) {
      print('Order Details Repository Error: $e');
      throw Exception('Failed to load order details: $e');
    }
  }

  // Get payment methods
  Future<List<PaymentMethod>> getPaymentMethods() async {
    try {
      final token = await LocalStorage.getToken();
      
      if (token == null) {
        throw Exception('No authentication token found');
      }

      final response = await http.get(
        Uri.parse('${AppUrl.baseURL}payment-methods'),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      );

      print('Payment Methods Response Status: ${response.statusCode}');
      print('Payment Methods Response Body: ${response.body}');

      if (response.statusCode == 200 || response.statusCode == 201) {
        final jsonResponse = json.decode(response.body);
        final data = jsonResponse['data'] as List<dynamic>? ?? [];
        return data.map((item) => PaymentMethod.fromJson(item)).toList();
      } else {
        throw Exception('Failed to load payment methods: ${response.body}');
      }
    } catch (e) {
      print('Payment Methods Repository Error: $e');
      throw Exception('Failed to load payment methods: $e');
    }
  }

  // Change order status - Approved
  Future<void> approveOrder({
    required String orderId,
    required String paymentMethodId,
  }) async {
    try {
      final token = await LocalStorage.getToken();
      
      if (token == null) {
        throw Exception('No authentication token found');
      }

      final url = '${AppUrl.baseURL}orders/$orderId/change-status?status=approved&payment_method=$paymentMethodId';
      
      final response = await http.get(
        Uri.parse(url),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      );

      print('Approve Order Response Status: ${response.statusCode}');
      print('Approve Order Response Body: ${response.body}');

      if (response.statusCode != 200 && response.statusCode != 201) {
        throw Exception('Failed to approve order: ${response.body}');
      }
    } catch (e) {
      print('Approve Order Repository Error: $e');
      throw Exception('Failed to approve order: $e');
    }
  }

  // Change order status - Rejected
  Future<void> rejectOrder({
    required String orderId,
    required String rejectedReason,
  }) async {
    try {
      final token = await LocalStorage.getToken();
      
      if (token == null) {
        throw Exception('No authentication token found');
      }

      final url = '${AppUrl.baseURL}orders/$orderId/change-status?status=rejected&rejected_reason=$rejectedReason';
      
      final response = await http.get(
        Uri.parse(url),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      );

      print('Reject Order Response Status: ${response.statusCode}');
      print('Reject Order Response Body: ${response.body}');

      if (response.statusCode != 200 && response.statusCode != 201) {
        throw Exception('Failed to reject order: ${response.body}');
      }
    } catch (e) {
      print('Reject Order Repository Error: $e');
      throw Exception('Failed to reject order: $e');
    }
  }
}



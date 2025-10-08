import 'package:x_express/Utils/exports.dart';
import 'package:http/http.dart';

String domain = dotenv.env['DOMAIN']!;

class Request {
  static Future reqGet(String route) async {
    final language = Provider.of<Language>(navigatorKey.currentContext!, listen: false);
    final response = await get(
      Uri.parse('$domain$route'),
      headers: {"Authorization": "Bearer ${Auth.token}", "userType": Auth.userType, "language": language.languageCode},
    );

    print('$domain$route');
    print(response.statusCode);
    print("response body is: ${response.body}");
    final ress = jsonDecode(response.body);
    print("response is for route $route is:  $ress");
    print(ress);
    return jsonDecode(response.body);
  }

  static Future reqPost(String route, body) async {
    final language = Provider.of<Language>(navigatorKey.currentContext!, listen: false);

    final response = await post(
      Uri.parse('$domain$route'),
      body: jsonEncode(body),
      headers: {
        "Content-Type": "application/json",
        "userType": Auth.userType,
        "language": language.languageCode,
        "Authorization": "Bearer ${Auth.token}",
      },
    );
    print(response);
    final decodedBody = jsonDecode(response.body);
    if (response.statusCode != 200) {
      return {
        'statusCode': response.statusCode,
        'body': decodedBody,
      };

    }

    print(jsonDecode(response.body));
    return {
      'statusCode': response.statusCode,
      'body': decodedBody,
    };
  }

  static Future requestUpdate(String route, dynamic body) async {
    final language = Provider.of<Language>(navigatorKey.currentContext!, listen: false);

    final response = await post(
      body: jsonEncode(body),
      Uri.parse('$domain$route'),
      headers: {"Authorization": "Bearer ${Auth.token}", "userType": Auth.userType, "language": language.languageCode},
    );

    if (response.statusCode != 200) {
      return jsonDecode(response.body);
    }
    print(jsonDecode(response.body));
    final decodedBody = jsonDecode(response.body);
    return {
      'statusCode': response.statusCode,
      'body': decodedBody,
    };
    ;
  }

  static Future requestDelete(String route) async {
    final response = await delete(
      Uri.parse('$domain$route'),
      headers: {"Authorization": "Bearer ${Auth.token}", "userType": Auth.userType},
    );

    if (response.statusCode != 200) return null;
    return jsonDecode(response.body);
  }
}

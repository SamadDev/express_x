import 'dart:convert';

import 'package:x_express/Utils/exports.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class AddressService with ChangeNotifier {
  var address;
  var data;
  String status = '';
  String response_type = '';

  Future<void> getAddress(context) async {
    try {
      print("check if status code is false");
      var res ;
      data = res;
      if (res['status'].toString() == 'true') {
        if (res['data'][0]['address'].toString().isEmpty) {
          response_type = res['data'][0]['response_type'];
        } else {
          response_type = res['data'][0]['response_type'];
          address = jsonDecode(res['data'][0]['address']);
        }
      } else {
        print("check if status code is false");
        status = "false";
      }
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }

  Future<void> setAddress({context}) async {
    print("check if status code is false");
    try {
      LoadingDialog(context);
      LoadingDialog(context);
      final language = Provider.of<Language>(context, listen: false);
      final response = await http.post(
        Uri.parse('https://system.eagleexpress.us.com/new_api_v1.1/api/new_request?customer_id=${Auth.customer_id}'),
        headers: {"Content-Type": "application/json", "x-api-key": Auth.token},
      );
      Navigator.of(context).pop();
      Navigator.of(context).pop();
      jsonEncode(response.body);
      if (response.statusCode == 200) {
        successMessage(context: context, content: "Your request sent successfully", title: "Successful");
        await getAddress(context);
      } else {
        dialogWarning(context: context, content: "Please try again", title: language.getWords['error']);
      }
      notifyListeners();
    } catch (e) {
      print("error $e");
    }
  }
}

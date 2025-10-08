import 'package:x_express/Language/language.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

class FormValidator {
  static String? isEmpty(String? value) {
    if (value!.isEmpty) {
      return Language().getWords['required_field'];
    }
    return null;
  }

  static String? isNothing(String? value) {
    return null;
  }




  static String? isUrlEmpty(String? value) {
    {
      String pattern = r"https?://[A-Za-z0-9.-]+(/[A-Za-z0-9\-._~:/?#[\]@!$&'()*+,;=%]*)?";
      RegExp regExp = RegExp(
        pattern,
        caseSensitive: false,
        multiLine: false,
      );
      if (!(regExp.hasMatch(value!)) && value.isNotEmpty) {
        return "Please enter right website URL";
      } else {
        return null;
      }
    }
  }

  static String? isText(String? value) {
    print(value);
    RegExp regExp = new RegExp(
      r"^[a-zA-Z]*$",
      caseSensitive: false,
      multiLine: false,
    );
    if (value!.isEmpty) {
      return 'field required';
    }
    if (!regExp.hasMatch(value)) {
      return 'Just Text allowed';
    }
    return null;
  }

  static String? isPhone(String? value) {
    RegExp regExp = new RegExp(
      r"^[0-9.]*$",
      caseSensitive: false,
      multiLine: false,
    );
    if (!regExp.hasMatch(value!)) {
      return 'Just Number';
    }
    if (value.isEmpty) {
      return 'Field required';
    }
    return null;
  }

  static String? passwordMatch({value1, value2}) {

    if (value2.isEmpty|| value1.isEmpty) {
      return 'Field required';
    } else if (value1 != value2) {
      print("value1:$value1 ----- value2: $value2");
      return 'password don\'t match';
    }
    return null;
  }

  static String? isDropDown(dynamic value) {
    if (value == null) {
      return '';
    }
    return null;
  }

  static String? isNotShortAndNotEmpty(String? value) {
    if (value!.isEmpty) {
      return 'field required';
    }
    if (value.length < 5) {
      return 'should be longer that 5 letter';
    }
    return null;
  }

  static String? isPassword(String? value) {
    if (value!.isEmpty) {
      return "Field is required";
    }
    if (value.length < 6) {
      return 'password should be longer than 5 character';
    }
    return null;
  }
}

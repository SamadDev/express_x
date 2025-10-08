import 'dart:js_interop';

import 'package:x_express/Utils/exports.dart';

class FormValidator {
  final language=Provider.of<Language>(navigatorKey.currentContext!,listen:false).getWords;
  static String? isNothing(String? value) {
    return null;
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
      return 'Please inter the right phone number';
    }
    if (value.isEmpty) {
      return 'Field required';
    }
    if (value.length != 10) {
      return 'phone number should be 10 number';
    }

    return null;
  }

  static String? passwordMatch({value1, value2}) {
    if (value2.isEmpty) {
      return "Field required";
    } else if (value1 != value2) {
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

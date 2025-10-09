

class FormValidator {

  static String? isEmpty(String? value) {
    if (value!.isEmpty) {
      // return Language().getWords['required_field'];
      return "Required Field";
    }
    return null;
  }

  static String? isNothing(String? value) {
    return null;
  }

  // static String? isUrl(String? value) {
  //   {
  //     String pattern =
  //         r'^((?:.|\n)*?)((http:\/\/www\.|https:\/\/www\.|http:\/\/|https:\/\/)?[a-z0-9]+([\-\.]{1}[a-z0-9]+)([-A-Z0-9.]+)(/[-A-Z0-9+&@#/%=~_|!:,.;]*)?(\?[A-Z0-9+&@#/%=~_|!:‌​,.;]*)?)';
  //     RegExp regExp = RegExp(
  //       pattern,
  //       caseSensitive: false,
  //       multiLine: false,
  //     );
  //     if (value!.isEmpty) {
  //       return "required field";
  //     } else if (!(regExp.hasMatch(value))) {
  //       return "Please enter right website URL";
  //     } else {
  //       return null;
  //     }
  //   }
  // }

  static String? isUrl(String? value) {
    {
      var urlPattern =r"https?://[A-Za-z0-9.-]+(/[A-Za-z0-9\-._~:/?#[\]@!$&'()*+,;=%]*)?";
      // r"(https?|http)://(.[A-Z0-9.-]+\.[A-Z]{2,63})(/[-A-Z0-9+&@#/%=~_|!:,.;]*)?(\?[A-Z0-9+&@#/%=~_|!:,.;]*)?";
      var match = RegExp(urlPattern, caseSensitive: false).firstMatch(value!);
      if (value.isEmpty) {
        return "required field";
      } else if (match == null) {
        return "Please enter right website URL";
      } else {
        return null;
      }
    }
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


  static String? isNumber(String? value) {
    if (value == null || value.isEmpty) return null;

    if (value.isEmpty) {
      // return Language().getWords['required_field'];
      return "Required Field";
    }

    if (!RegExp(r"^[0-9]*$").hasMatch(value)) {
      return "Please enter numbers only";
    }
    return null;
  }

  static String? isPrice(String? value) {
    if (value == null || value.isEmpty) return null;

    if (value.isEmpty) {
      // return Language().getWords['required_field'];
      return "Required Field";
    }
    if (!RegExp(r"^[0-9]*\.?[0-9]*$").hasMatch(value)) {
      return "Please enter valid price";
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
      return 'Field required';
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

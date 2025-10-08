import 'package:x_express/Utils/exports.dart';

class Auth with ChangeNotifier {
  Map? data;
  Map? checkLogin;
  static String isSuccess = 'true';
  static String customer_name = '';

  static String firebase_token = '';
  static bool skip = false;
  String message = '';
  String verification_id = '';
  static bool isSave = true;
  static String savePassword = '';
  static String savePhone = '';

  static String token = '';
  static String refreshToken = '';
  static String customer_id = '';

  static String userType = '';
  static String customerCode = '';

  Future<void> logIn({phone, password, context}) async {
    try {
      print(phone);
      LoadingDialog(context);
      removeToken();

      final response = await Request.reqPost('/login', {'phone_number': "07502748575", 'password': password});

      if (response['statusCode'] == 200) {
        await localDate(response['body'], 'set');
        navigator_route_remove(context: context, page: NavigationButtonScreen());
      } else {
        Navigator.of(context).pop();
        dialogWarning(context: context, content: response['body']['message'], title: 'Error Occurred');
      }
    } catch (e) {
      print('error is: $e');
      Navigator.of(context).pop();
      dialogWarning(context: context, content: e.toString(), title: 'Error Occurred');
    }
    notifyListeners();
  }

  Future<void> register({phone, password, context}) async {
    LoadingDialog(context);

    Future.delayed(const Duration(seconds: 2), () {
      Navigator.of(context).pop();
      dialogWarning(context: context, content: "Please wait until we review your account ", title: 'Error Occurred');
    });

    notifyListeners();
  }

  Future<void> resetPassword({oldPassword, newPassword, context}) async {
    try {
      LoadingDialog(context);
      final response = await Request.reqPost(
          'security/users/change-password', {'currentPassword': oldPassword, 'newPassword': newPassword});
      if (response!['success'].toString() == 'true') {
        Navigator.of(context).pop();
        successMessage(
            context: context,
            title: "Reset Password",
            content: "Your Password update successfully",
            isDismissible: false);
      } else {
        Navigator.of(context).pop();
        dialogWarning(context: context, content: response['message'], title: 'Error Occurred');
      }
    } catch (e) {
      print('change password error is: $e');
      Navigator.of(context).pop();
      dialogWarning(context: context, content: e.toString(), title: 'Error Occurred');
    }
    notifyListeners();
  }

  Future<void> localDate(data, type) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    if (type == "set") {
      await preferences.setString('token', data['token']);
    }
    token = await preferences.getString('token') ?? '';
    notifyListeners();
  }

  Future<void> getUserOut(context) async {
    Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => LoginPage()), (route) => false);
  }

  Future<void> deleteAccount({context, userId}) async {
    try {
      final res = await Request.reqPost("security/users/$userId/update-status", "false");
      print(res);
      removeToken();
      navigator_route_remove(context: context, page: LoginPage());
    } catch (e) {
      print(e);
    }
  }

  Future<void> fetchToken() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    token = await preferences.getString('deviceToken') ?? '';
    notifyListeners();
  }

  removeToken() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    token = '';
    userType = '';
    await preferences.clear();
    notifyListeners();
  }

  bool isShowPassword = true;
  void setPasswordShow() {
    isShowPassword = !isShowPassword;
    notifyListeners();
  }

  List isShowPasswordList = [false, false, false];
  void setPasswordShowList(index) {
    isShowPasswordList[index] = !isShowPasswordList[index];
    notifyListeners();
  }

  /// Button disable timer
  bool isButtonDisabled = false;
  void disableButton() {
    isButtonDisabled = true;
    resetTimer();
    startTimer();
    notifyListeners();
    Timer(Duration(seconds: 120), () {
      isButtonDisabled = false;
      print('run after 120 second');
      notifyListeners();
    });
  }

  Timer? countdownTimer;
  Duration myDuration = Duration(minutes: 2);
  void startTimer() {
    countdownTimer = Timer.periodic(Duration(seconds: 1), (_) => setCountDown());
  }

  void resetTimer() {
    myDuration = Duration(minutes: 2);
    notifyListeners();
  }

  void setCountDown() {
    final reduceSecondsBy = 1;
    final seconds = myDuration.inSeconds - reduceSecondsBy;
    if (seconds < 0) {
      countdownTimer!.cancel();
    } else {
      myDuration = Duration(seconds: seconds);
    }
    notifyListeners();
  }

  String getFormattedDuration() {
    String strDigits(int n) => n.toString().padLeft(2, '0');
    final minutes = strDigits(myDuration.inMinutes.remainder(60));
    final seconds = strDigits(myDuration.inSeconds.remainder(60));
    return '$minutes:$seconds';
  }

  setCheckBox(value) {
    isSave = value;
    notifyListeners();
  }
}

import 'package:x_express/Utils/exports.dart';

class OtpScreen extends StatefulWidget {
  OtpScreen({this.data});
  final data;

  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  late TextEditingController otpController = TextEditingController();
  // final FirebaseAuth auth = FirebaseAuth.instance;
  bool hasError = false;
  String currentText = "";
  final formKey = GlobalKey<FormState>();

  Widget build(BuildContext context) {
    final height = Responsive.sH(context);
    final language = Provider.of<Language>(context, listen: false);
    final authService = Provider.of<Auth>(context, listen: false);
    final resetPassword = Provider.of<ReSetPasswordService>(context, listen: false);
    final loading = Provider.of<Auth>(context);
    return Scaffold(
      extendBody: true,
      extendBodyBehindAppBar: true,
      appBar: AppBar(backgroundColor: AppTheme.transparent, iconTheme: IconThemeData(color: AppTheme.primary)),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: Form(
          key: formKey,
          child: Padding(
            padding: EdgeInsets.only(right: 45, left: 45),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: height * 0.1,
                  ),
                  GlobalText(text:
                    language.getWords['OTP_verification'],
                    color: AppTheme.primary,
                    fontWeight: FontWeight.w700,
                    fontSize: 40,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  GlobalText(text:
                    language.getWords['please_provide_the_OTP_code_that_we_sent_to_your_phone_number'],
                    color: AppTheme.grey,fontSize: 18,
                  ),
                  SizedBox(
                    height: 60,
                  ),
                  Image.asset(
                    'assets/images/otp.png',
                    width: 280,
                    height: height * 0.23,
                  ),
                  SizedBox(
                    height: 80,
                  ),
                  Padding(
                      padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 20),
                      child: Pinput(
                        length: 6,
                        validator: (v) {
                          if (v!.length < 6) {
                            return language.getWords["please_enter_complete_SMS_code"];
                          } else {
                            return null;
                          }
                        },
                        controller: otpController,
                        keyboardType: TextInputType.number,
                        onCompleted: (v) async {
                          // try {
                          //  //  LoadingDialog(context);
                          //  //  PhoneAuthCredential credential = PhoneAuthProvider.credential(
                          //  //      verificationId: authService.verification_id, smsCode: otpController.text);
                          //  //  await auth.signInWithCredential(credential);
                          //  // if (auth.currentUser != null && widget.data['type'] == "forget") {
                          //  //    await resetPassword.reset_password(context: context, data: widget.data);
                          //  //  }
                          // } on FirebaseAuthException catch (e) {
                          //   Navigator.of(context).pop();
                          //   handleOTPCodeVerification(e, context);
                          // }
                        },
                        onChanged: (value) {
                          setState(() {
                            currentText = value;
                          });
                        },
                      )),
                  SizedBox(
                    height: 30,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GlobalText(text:
                        language.getWords['did_not_receive_the_code?'],
                        color: Colors.black54, fontSize: 15,
                      ),
                      loading.isButtonDisabled
                          ? Padding(
                              padding: EdgeInsets.only(bottom: 12.0),
                              child: Consumer<Auth>(
                                builder: (context, timerModel, child) => GlobalText(text:
                                  timerModel.getFormattedDuration(),
                                  decoration: TextDecoration.underline, color: AppTheme.primary,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 15,
                                ),
                              ),
                            )
                          : TextButton(
                              onPressed: () async {
                                LoadingDialog(context);
                                otpController.clear();
                              },
                              child: GlobalText(text:
                                language.getWords["resend"],
                               decoration: TextDecoration.underline, color: AppTheme.primary,
                                fontWeight: FontWeight.w500,
                                fontSize: 15,
                              ),
                            ),
                    ],
                  ),
                  Customer_Button(
                      text: language.getWords["submit"],
                      onPress: () async {
                        // try {
                        // //   LoadingDialog(context);
                        // //   PhoneAuthCredential credential = PhoneAuthProvider.credential(
                        // //       verificationId: authService.verification_id, smsCode: otpController.text);
                        // //   await auth.signInWithCredential(credential);
                        // // if (auth.currentUser != null && widget.data['type'] == "forget") {
                        // //     await resetPassword.reset_password(context: context, data: widget.data);
                        // //   }
                        // } on FirebaseAuthException catch (e) {
                        //   Navigator.of(context).pop();
                        //   handleOTPCodeVerification(e, context);
                        // }
                      }),
                  SizedBox(
                    height: 10,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

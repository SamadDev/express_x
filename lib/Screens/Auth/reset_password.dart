import 'package:x_express/Utils/exports.dart';

class ResetPasswordPage extends StatefulWidget {
  const ResetPasswordPage({Key? key}) : super(key: key);

  @override
  State<ResetPasswordPage> createState() => _ResetPasswordPageState();
}

class _ResetPasswordPageState extends State<ResetPasswordPage> {
  late TextEditingController otpController = TextEditingController();
  // final FirebaseAuth auth = FirebaseAuth.instance;
  bool hasError = false;
  String currentText = "";
  final formKey = GlobalKey<FormState>();
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 20,
            ),
        GlobalText(text:
              "Please enter code sent",


                color: AppTheme.black,
                fontSize: 30,
              ),

            SizedBox(
              height: 4,
            ),
        GlobalText(text:
              "to your number",

                fontFamily: "sf_med",
                color: AppTheme.black,
                fontSize: 30,
              ),

            SizedBox(
              height: 18,
            ),
        GlobalText(text:
              "6-digit sent to +964 781 052 0687 ",
              fontSize: 16, color: AppTheme.black,
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 30.0, horizontal: 20),
              child: Pinput(
                length: 6,
                validator: (v) {
                  if (v!.length < 6) {
                    return 'please enter complete SMS code';
                  } else {
                    return null;
                  }
                },
                controller: otpController,
                keyboardType: TextInputType.number,
                onCompleted: (v) async {
                  navigator_route(context: context, page: NavigationButtonScreen());
                },
                onChanged: (value) {
                  setState(() {
                    currentText = value;
                  });
                },
              ),
            ),
            GlobalText(text:
              'resend code in 00:52',
              fontSize: 15, fontFamily: 'nrt-reg',fontWeight: FontWeight.w500, color: AppTheme.black.withOpacity(0.5),
            )
          ],
        ),
      ),
    );
  }
}

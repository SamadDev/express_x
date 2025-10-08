import 'package:x_express/Utils/exports.dart';

class ResetPasswordScreen extends StatefulWidget {
  final phone;
  ResetPasswordScreen({this.phone});
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final password = TextEditingController();
  final confirmPassword = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  Widget build(BuildContext context) {
    final language = Provider.of<Language>(context, listen: false);
    final resetPassword = Provider.of<ReSetPasswordService>(context, listen: false);
    final height = Responsive.sH(context);
    final provider = Provider.of<Auth>(context, listen: false);
    final auth_w_context = Provider.of<Auth>(context);
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Scaffold(
        extendBody: true,
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: AppTheme.transparent,
          iconTheme: IconThemeData(color: AppTheme.primary),
        ),
        body: Padding(
          padding: EdgeInsets.only(
            right: 45,
            left: 45,
          ),
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: height * 0.09,
                  ),
                  GlobalText(
                    text: language.getWords['reset_password'],
                    color: AppTheme.primary,
                    fontWeight: FontWeight.w700,
                    fontFamily: 'inter-bold',
                    fontSize: 40,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  GlobalText(
                    text: language.getWords['please_provide_your_phone_number_bellow_to_reset_your_password'],
                    fontWeight: FontWeight.w600,
                    fontSize: 18,
                    color: AppTheme.grey,
                  ),
                  SizedBox(
                    height: 60,
                  ),
                  Image.asset(
                    'assets/images/reset_password.png',
                    width: 280,
                    height: height * 0.23,
                  ),
                  SizedBox(
                    height: 65,
                  ),
                  TextFormFieldWidget(
                    buttonPrefix: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 14.0),
                        child: Icon(Icons.lock, color: AppTheme.primary)),
                    controller: password,
                    hintText: language.getWords["new_password"],
                    textInputType: TextInputType.text,
                    textInputAction: TextInputAction.next,
                    obscureText: auth_w_context.isShowPassword,
                    formValidator: FormValidator.isPassword,
                    buttonPostfix: IconButton(
                        onPressed: () => provider.setPasswordShow(),
                        icon: Icon(auth_w_context.isShowPassword ? Icons.visibility_off : Icons.visibility),
                        color: AppTheme.grey),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextFormFieldWidget(
                    buttonPrefix: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 14.0),
                        child: Icon(Icons.lock, color: AppTheme.primary)),
                    controller: confirmPassword,
                    hintText: language.getWords["confirm_password"],
                    textInputType: TextInputType.text,
                    textInputAction: TextInputAction.done,
                    obscureText: auth_w_context.isShowPassword,
                    formValidator: (value) {
                      if (value!.isEmpty) {
                        return "field is required";
                      } else if (value != password.text) {
                        return "password not matched";
                      }
                      return null;
                    },
                    buttonPostfix: IconButton(
                      onPressed: () => auth_w_context.setPasswordShow(),
                      icon: Icon(auth_w_context.isShowPassword ? Icons.visibility_off : Icons.visibility),
                      color: AppTheme.grey,
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  auth_w_context.isButtonDisabled
                      ? Consumer<Auth>(
                          builder: (context, timerModel, child) => Customer_Button(
                            color: AppTheme.primary.withOpacity(0.8),
                            fontSize: 16.0,
                            onPress: () {
                              navigator_route(
                                  context: context,
                                  page: OtpScreen(
                                    data: {
                                      "new_re_password": password.text,
                                      "new_password": confirmPassword.text,
                                      "phone_no": widget.phone,
                                      "type": "forget"
                                    },
                                  ));
                            },
                            text: timerModel.getFormattedDuration(),
                          ),
                        )
                      : Customer_Button(
                          text: language.getWords["reset_password"],
                          onPress: () async {
                            if (!_formKey.currentState!.validate()) {
                              return;
                            }
                            _formKey.currentState!.save();
                            LoadingDialog(context);
                            if (widget.phone.toString().startsWith('+96477')) {
                              await resetPassword.reset_password(context: context, data: {
                                "new_re_password": password.text,
                                "new_password": confirmPassword.text,
                                "phone_no": widget.phone,
                              });
                            } else {
                            }
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

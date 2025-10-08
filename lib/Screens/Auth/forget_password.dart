import 'package:x_express/Theme/theme.dart';
import 'package:x_express/Utils/exports.dart';

class ForgetPasswordPage extends StatefulWidget {
  @override
  State<ForgetPasswordPage> createState() => _ForgetPasswordPageState();
}

class _ForgetPasswordPageState extends State<ForgetPasswordPage> {
  TextEditingController oldPasswordController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  final _key = GlobalKey<FormState>();

  Widget build(BuildContext context) {
    final auth = Provider.of<Auth>(context, listen: false);
    final language = Provider.of<Language>(context, listen: false).getWords;
    return GestureDetector(
      onTap: () {
        SystemChannels.textInput.invokeMethod<void>('TextInput.hide');
      },
      child: Scaffold(
          appBar: AppBar(),
          backgroundColor: theme.colorScheme.onErrorContainer.withOpacity(1),
          body: Container(
              width: double.maxFinite,
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 43),
              child: Form(
                key: _key,
                child: SingleChildScrollView(
                  child: Column(children: [
                    Align(
                      alignment: Alignment.bottomLeft,
                      child: Container(
                        margin: EdgeInsets.only(right: 0),
                        child: GlobalText(text:
                          language['PleaseEnterYourPreviousAndNewPasswordToResetYourPassword'],
                          fontSize: 16, fontFamily: "nrt-reg", color: AppTheme.black,
                        ),
                      ),
                    ),
                    SizedBox(height: 41),
                    Consumer<Auth>(
                      builder: (ctx, password, _) => Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                      GlobalText(text:language["previousPassword"],

                                  fontSize: 14,
                                  fontFamily: 'nrt-reg',
                                  fontWeight: FontWeight.w500,
                                  color: AppTheme.black,),
                          SizedBox(height: 5),
                          CustomTextFormField(
                              validator: FormValidator.isEmpty,
                              obscureText: password.isShowPasswordList[0],
                              fillColor: AppTheme.grey,
                              controller: oldPasswordController,
                              hintText: "*** *** ***",
                              textInputAction: TextInputAction.done,
                              suffix: GestureDetector(
                                onTap: () {
                                  password.setPasswordShowList(0);
                                },
                                child: Icon(
                                  password.isShowPasswordList[0] ? Icons.visibility_off : Icons.visibility,
                                  color: AppTheme.primary,
                                ),
                              )),
                          SizedBox(height: 8),
                        GlobalText(text:language["newPassword"],

                                  fontSize: 14,
                                  fontFamily: 'nrt-reg',
                                  fontWeight: FontWeight.w500,
                                  color: AppTheme.black,),
                          SizedBox(height: 5),
                          CustomTextFormField(
                              validator: FormValidator.isEmpty,
                              obscureText: password.isShowPasswordList[1],
                              fillColor: AppTheme.grey,
                              controller: newPasswordController,
                              hintText: "*** *** ***",
                              textInputAction: TextInputAction.done,
                              suffix: GestureDetector(
                                onTap: () {
                                  password.setPasswordShowList(1);
                                },
                                child: Icon(
                                  password.isShowPasswordList[1] ? Icons.visibility_off : Icons.visibility,
                                  color: AppTheme.primary,
                                ),
                              )),
                          SizedBox(height: 8),
                        GlobalText(text:language['confirmPassword'],

                                  fontSize: 14,
                                  fontFamily: 'nrt-reg',
                                  fontWeight: FontWeight.w500,
                                  color: AppTheme.black,),
                          SizedBox(height: 5),
                          CustomTextFormField(
                              validator: (value) => FormValidator.passwordMatch(
                                  value1: value, value2: newPasswordController.text),
                              obscureText: password.isShowPasswordList[2],
                              fillColor: AppTheme.grey,
                              controller: confirmPasswordController,
                              hintText: "*** *** ***",
                              textInputAction: TextInputAction.done,
                              onFieldSubmit: (value) {
                                SystemChannels.textInput.invokeMethod<void>('TextInput.hide');
                                if (confirmPasswordController.text.isEmpty || confirmPasswordController.text.isEmpty) {
                                  var snackBar = SnackBar(content: Text(language['pleaseFillAllFields']));
                                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                                } else {
                                  auth.logIn(
                                      context: context,
                                      password: confirmPasswordController.text,
                                      phone: confirmPasswordController.text);
                                }
                              },
                              suffix: GestureDetector(
                                onTap: () {
                                  password.setPasswordShowList(2);
                                },
                                child: Icon(
                                  password.isShowPasswordList[2] ? Icons.visibility_off : Icons.visibility,
                                  color: AppTheme.primary,
                                ),
                              )),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    SizedBox(height: 25),
                    Customer_Button(
                        text: language['reset_password'],
                        onPress: () {
                          if (!_key.currentState!.validate()) {
                            return;
                          }
                          _key.currentState!.save();
                          auth.resetPassword(
                              context: context,
                              oldPassword: oldPasswordController.text,
                              newPassword: newPasswordController.text);
                        }),
                    SizedBox(height: 28),
                  ]),
                ),
              ))),
    );
  }
}

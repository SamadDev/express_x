import 'package:x_express/Screens/Auth/register_screen.dart';
import 'package:x_express/Utils/exports.dart';
import 'package:phone_form_field/phone_form_field.dart';
import 'package:x_express/pages/home/home.dart';

class LoginPage extends StatefulWidget {
  @override
  State<LoginPage> createState() => _LoginPageState();
}


class _LoginPageState extends State<LoginPage> {
  TextEditingController passwordController = TextEditingController();
  PhoneController phoneController = PhoneController(
    PhoneNumber.parse('+964'),
  );


  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<Auth>(context, listen: false);
    final language = Provider.of<Language>(context, listen: false).getWords;
//test
    return GestureDetector(
      onTap: () {
        SystemChannels.textInput.invokeMethod<void>('TextInput.hide');
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 60),
                Image.asset(
                  "assets/images/${dotenv.env['LOGO']}",
                  height: 60,
                  width: 200,
                ),
                SizedBox(height: 20),
                GlobalText(
                  text: ' ${dotenv.env['NAME']}',
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
                SizedBox(height: 100),
                CustomPhoneFormField(
                  title: language['phoneNumber'],
                  controller: phoneController,
                  hintText: language['phoneNumber'],
                  borderType: true,
                ),
                SizedBox(height: 20),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    language["password"],
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                  ),
                ),
                SizedBox(height: 8),
                Consumer<Auth>(
                  builder: (ctx, password, _) => CustomTextFormField(
                    borderType: true,
                    controller: passwordController,
                    obscureText: password.isShowPassword,
                    hintText: language['password'],
                    suffix: IconButton(
                      icon: Icon(password.isShowPassword ? Icons.visibility_off : Icons.visibility),
                      onPressed: () => password.setPasswordShow(),
                    ),
                    onFieldSubmitted: (_) => _submitLogin(auth, language),
                  ),
                ),
                SizedBox(height: 30),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppTheme.primary,
                    minimumSize: Size(double.infinity, 50),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  onPressed: () => _submitLogin(auth, language),
                  child: Text(language['login'], style: TextStyle(color: Colors.white, fontSize: 16)),
                ),
                SizedBox(height: 25),
                GestureDetector(
                  onTap: () {
                    navigator_route_remove(context: context, page: RegisterPage());
                  },
                  child: RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                            text: language['do_not_have_account?'],
                            style: TextStyle(color: Colors.black, fontSize: 14)),
                        TextSpan(text: " "),
                        TextSpan(
                            text: language["create_account"], style: TextStyle(fontSize: 15, color: AppTheme.primary)),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _submitLogin(Auth auth, language) {
    // if (passwordController.text.isEmpty || phoneController.value!.international.isEmpty) {
    //   var snackBar = SnackBar(content: Text(language['pleaseFillAllFields']));
    //   ScaffoldMessenger.of(context).showSnackBar(snackBar);
    //   return;
    // }
    navigator_route_remove(context: context, page: HomePageNew());
    // auth.logIn(
    //   context: context,
    //   //todo remove replace
    //   phone: phoneController.value?.international,
    //   password: passwordController.text,
    // );
  }
}

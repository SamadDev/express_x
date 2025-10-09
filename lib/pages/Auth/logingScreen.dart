import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:phone_form_field/phone_form_field.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:x_express/core/config/theme/color.dart';
import 'package:x_express/core/config/theme/theme.dart';
import 'package:x_express/core/config/widgets/globalText.dart';
import 'package:x_express/custom_text_form_field.dart';
import 'package:x_express/Language/language.dart';
import 'package:x_express/pages/Auth/data/service/auth_service.dart';

class LoginPage extends StatefulWidget {
  @override
  State<LoginPage> createState() => _LoginPageState();
}


class _LoginPageState extends State<LoginPage> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context, listen: false);
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
                   ' ${dotenv.env['NAME']}',
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
                SizedBox(height: 100),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    language['phoneNumber'] ?? 'Phone Number',
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                  ),
                ),
                SizedBox(height: 8),
                CustomTextFormField(
                  borderType: true,
                  controller: usernameController,
                  hintText: language['phoneNumber'] ?? 'Phone Number',
                  textInputType: TextInputType.phone,
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
                Consumer<AuthService>(
                  builder: (ctx, authService, _) => CustomTextFormField(
                    borderType: true,
                    controller: passwordController,
                    obscureText: authService.isObscure,
                    hintText: language['password'] ?? 'Password',
                    suffix: IconButton(
                      icon: Icon(authService.isObscure ? Icons.visibility_off : Icons.visibility),
                      onPressed: () => authService.setObscure(),
                    ),
                  ),
                ),
                SizedBox(height: 30),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: kLightPrimary,
                    minimumSize: Size(double.infinity, 50),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  onPressed: () => _submitLogin(authService, language),
                  child: Text(language['login'], style: TextStyle(color: Colors.white, fontSize: 16)),
                ),
                SizedBox(height: 25),
                // Register link - commented out until register page is created
                // GestureDetector(
                //   onTap: () {
                //     Navigator.pushNamed(context, '/register');
                //   },
                //   child: RichText(
                //     text: TextSpan(
                //       children: [
                //         TextSpan(
                //             text: language['do_not_have_account?'] ?? "Don't have an account?",
                //             style: TextStyle(color: Colors.black, fontSize: 14)),
                //         TextSpan(text: " "),
                //         TextSpan(
                //             text: language["create_account"] ?? "Create Account", 
                //             style: TextStyle(fontSize: 15, color: kLightPrimary)),
                //       ],
                //     ),
                //   ),
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _submitLogin(AuthService authService, language) async {
    // Validate fields
    if (usernameController.text.isEmpty || passwordController.text.isEmpty) {
      var snackBar = SnackBar(
        content: Text(language['pleaseFillAllFields'] ?? 'Please fill all fields'),
        backgroundColor: Colors.orange,
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      return;
    }

    // Attempt login
    final success = await authService.login(
      username: usernameController.text.trim(),
      password: passwordController.text,
      rememberMe: false, // or add a checkbox for remember me
    );

    if (success) {
      // Navigate to home screen - adjust route as needed
      Navigator.pushReplacementNamed(context, '/home');
    } else {
      // Show error
      var snackBar = SnackBar(
        content: Text(authService.error ?? 'Login failed'),
        backgroundColor: Colors.red,
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }
  
  @override
  void dispose() {
    usernameController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}

import 'package:x_express/Utils/exports.dart';
import 'package:phone_form_field/phone_form_field.dart';

class RegisterPage extends StatefulWidget {
  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  TextEditingController passwordController = TextEditingController();
  PhoneController phoneController = PhoneController(
    PhoneNumber.parse('+964'),
  );

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<Auth>(context, listen: false);
    final language = Provider.of<Language>(context, listen: false).getWords;

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
                SizedBox(height: 80),
                CustomTextFormField(
                  title: language['user_name'],
                  borderType: true,
                  controller: passwordController,
                  hintText: language['user_name'],
                ),
                SizedBox(height: 20),
                CustomPhoneFormField(
                  title: language['phoneNumber'],
                  controller: phoneController,
                  hintText: language['phoneNumber'],
                  borderType: true,
                ),
                SizedBox(height: 20),
                Consumer<Auth>(
                  builder: (ctx, password, _) => CustomTextFormField(
                    title: language['password'],
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
                  child: Text(language['create_account'], style: TextStyle(color: Colors.white, fontSize: 16)),
                ),
                SizedBox(height: 25),
                GestureDetector(
                  onTap: () {
                    navigator_route_remove(context: context, page: LoginPage());
                  },
                  child: RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                            text: language['you_have_account?'], style: TextStyle(color: Colors.black, fontSize: 14)),
                        TextSpan(text: " "),
                        TextSpan(text: language["login"], style: TextStyle(fontSize: 15, color: AppTheme.primary)),
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
    if (passwordController.text.isEmpty || phoneController.value!.international.isEmpty) {
      var snackBar = SnackBar(content: Text(language['pleaseFillAllFields']));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      return;
    }

    auth.register(
      context: context,
      phone: phoneController.value?.international,
      password: passwordController.text,
    );
  }
}

import 'package:flutter/material.dart';
import 'package:x_express/core/config/routes/routes.dart';
import 'package:x_express/core/config/theme/color.dart';
import 'package:x_express/core/config/widgets/globalText.dart';
import 'package:x_express/core/config/widgets/userTextformfeild.dart';
import 'package:x_express/core/config/widgets/phone_input_field.dart';
import 'package:provider/provider.dart';
import 'package:x_express/core/config/language/language.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isObscurePassword = true;

  bool _isLoading = false;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _setObscurePassword() {
    setState(() {
      _isObscurePassword = !_isObscurePassword;
    });
  }

  bool _isValidEmail(String email) {
    return RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email);
  }

  bool _isValidPhone(String phone) {
    return RegExp(r'^\+?[1-9]\d{1,14}$').hasMatch(phone.replaceAll(' ', ''));
  }

  Future<void> _register() async {
    // Name validation
    if (_nameController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter your name')),
      );
      return;
    }
    
    if (_nameController.text.length < 2) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Name must be at least 2 characters')),
      );
      return;
    }

    // Phone validation
    if (_emailController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter your phone number')),
      );
      return;
    }
    
    if (!_isValidPhone(_emailController.text)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter a valid phone number')),
      );
      return;
    }

    // Password validation
    if (_passwordController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter your password')),
      );
      return;
    }
    
    if (_passwordController.text.length < 8) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Password must be at least 8 characters')),
      );
      return;
    }
    
    if (!RegExp(r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)').hasMatch(_passwordController.text)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Password must contain uppercase, lowercase, and number')),
      );
      return;
    }

    setState(() {
      _isLoading = true;
    });

    await Future.delayed(Duration(seconds: 2));

    setState(() {
      _isLoading = false;
    });
    
    // Show success screen
    Navigator.pushNamed(
      context, 
      AppRoute.success,
      arguments: {
        'title': 'Congratulations!',
        'message': 'You successfully created your account.\nNow you are good to go',
        'buttonText': 'Go to Log In',
        'nextRoute': AppRoute.login,
        'isPasswordReset': false,
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final language = Provider.of<Language>(context, listen: false).getWords;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 80),
                      Center(
                        child: Column(
                          children: [
                            GlobalText(
                              "Getting Started",
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                              color: kLightTitle,
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 12),
                            GlobalText(
                              "Create an account to continue!",
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                              color: kLightPlatinum300,
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 48),
                      PhoneInputField(
                        label: "phone_number",
                        hintText: "enter_your_phone_number",
                        onChanged: (phone, countryCode) {
                          _emailController.text = phone;
                        },
                      ),
                      const SizedBox(height: 20),
                      CustomUserTextFormField(
                        title: "User name",
                        hintText: "Enter user name",
                        controller: _nameController,
                      ),
                      const SizedBox(height: 20),
                      CustomUserTextFormField(
                        title: "password",
                        hintText: "Enter your password",
                        obscureText: _isObscurePassword,
                        controller: _passwordController,
                        suffix: IconButton(
                          icon: Icon(
                            _isObscurePassword ? Icons.visibility_off : Icons.visibility,
                          ),
                          onPressed: _setObscurePassword,
                          color: kLightPasswordEyeIcon,
                        ),
                      ),
                      const SizedBox(height: 32),
                      Container(
                        width: double.infinity,
                        height: 56,
                        decoration: BoxDecoration(
                          color: kLightPrimary,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            elevation: 0,
                            backgroundColor: kLightPrimary,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          onPressed: _isLoading ? null : _register,
                          child: _isLoading
                              ? const SizedBox(
                                  height: 20,
                                  width: 20,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                    valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                                  ),
                                )
                              : GlobalText(
                                  "sign_up",
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                        ),
                      ),
                      const SizedBox(height: 24),
                      Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            GlobalText(
                              "dont_have_account",
                              fontSize: 16,
                              color: kLightGrayText,
                              fontWeight: FontWeight.w400,
                            ),
                            const SizedBox(width: 4),
                            GestureDetector(
                              onTap: () {
                                Navigator.pushReplacementNamed(context, AppRoute.login);
                              },
                              child: GlobalText(
                                "sign_in",
                                fontSize: 16,
                                color: kLightAuthText,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

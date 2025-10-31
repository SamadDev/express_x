import 'package:flutter/material.dart';
import 'package:x_express/core/config/routes/routes.dart';
import 'package:x_express/core/config/theme/color.dart';
import 'package:x_express/core/config/widgets/globalText.dart';
import 'package:x_express/core/config/widgets/userTextformfeild.dart';
import 'package:x_express/core/config/widgets/phone_input_field.dart';
import 'package:provider/provider.dart';
import 'package:x_express/features/Auth/data/service/auth_service.dart';

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
    final authService = Provider.of<AuthService>(context, listen: false);

    // Name validation
    if (_nameController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter your name'), backgroundColor: Colors.red),
      );
      return;
    }
    
    if (_nameController.text.length < 2) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Name must be at least 2 characters'), backgroundColor: Colors.red),
      );
      return;
    }

    // Phone validation
    if (_emailController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter your phone number'), backgroundColor: Colors.red),
      );
      return;
    }
    
    if (!_isValidPhone(_emailController.text)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter a valid phone number'), backgroundColor: Colors.red),
      );
      return;
    }

    // Password validation
    if (_passwordController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter your password'), backgroundColor: Colors.red),
      );
      return;
    }
    
    if (_passwordController.text.length < 8) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Password must be at least 8 characters'), backgroundColor: Colors.red),
      );
      return;
    }
    
    if (!RegExp(r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)').hasMatch(_passwordController.text)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Password must contain uppercase, lowercase, and number'), backgroundColor: Colors.red),
      );
      return;
    }

    setState(() {
      _isLoading = true;
    });

    // Call API to register
    final success = await authService.register(
      username: _nameController.text,
      phoneNumber: _emailController.text,
      password: _passwordController.text,
    );

    setState(() {
      _isLoading = false;
    });

    if (success) {
      // Show success screen
      Navigator.pushNamed(
        context, 
        AppRoute.success,
        arguments: {
          'title': 'Congratulations!',
          'message': 'You successfully created your account.\nNow you are good to go',
          'buttonText': 'Go to Home',
          'nextRoute': AppRoute.navigationBar,
          'isPasswordReset': false,
        },
      );
    } else {
      // Show error message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(authService.error ?? 'Registration failed. Please try again.'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kLightBackground,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
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
                        color: kLightText,
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 12),
                      GlobalText(
                        "Create an account to continue!",
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                        color: kLightGrayText,
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 48),
                
                // Registration Form
                Container(
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: kLightSurface,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        spreadRadius: 0,
                        blurRadius: 20,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const GlobalText(
                        "Phone Number",
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: kLightText,
                      ),
                      const SizedBox(height: 12),
                      PhoneInputField(
                        label: null,
                        hintText: "Enter your phone number",
                        onChanged: (phone, countryCode) {
                          // Remove spaces from phone number
                          String cleanPhone = phone.replaceAll(' ', '');
                          _emailController.text = cleanPhone;
                        },
                      ),
                      const SizedBox(height: 24),
                      CustomUserTextFormField(
                        title: "User name",
                        hintText: "Enter user name",
                        controller: _nameController,
                      ),
                      const SizedBox(height: 24),
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
                    ],
                  ),
                ),
                const SizedBox(height: 32),
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
                
                const SizedBox(height: 40),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

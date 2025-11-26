import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:x_express/features/Auth/data/service/auth_service.dart';
import 'package:x_express/core/config/widgets/phone_input_field.dart';
import 'package:x_express/core/config/widgets/userTextformfeild.dart';
import 'package:x_express/core/config/widgets/globalText.dart';
import 'package:x_express/core/config/theme/color.dart';
import 'package:x_express/features/Auth/view/register/register.dart';
import 'package:x_express/features/Auth/view/forgot_password/forgot_password_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _hasLoadedCredentials = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    try {
      final authService = Provider.of<AuthService>(context, listen: true);

      // Load saved credentials only once when the widget first builds
      if (!_hasLoadedCredentials) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (mounted) {
            authService.loadSavedCredentials();
            setState(() {
              _hasLoadedCredentials = true;
            });
          }
        });
      }

      return Scaffold(
        backgroundColor: kLightBackground,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Skip Button
                  Align(
                    alignment: Alignment.topRight,
                    child: TextButton(
                      onPressed: () {
                        // Navigate to home screen without login
                        Navigator.of(context).pushNamedAndRemoveUntil(
                          '/',
                          (Route<dynamic> route) => false,
                        );
                      },
                      child: Text(
                        'Skip',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: kLightPrimary,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Logo and Welcome Section
                  Center(
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 40.0,
                          ),
                          child: Image.asset(
                            'assets/images/logo.png',
                            height: 120,
                            fit: BoxFit.contain,
                          ),
                        ),
                        // const SizedBox(height: 32),
                        // const GlobalText(
                        //   "Welcome Back!",
                        //   fontSize: 28,
                        //   fontWeight: FontWeight.bold,
                        //   color: kLightText,
                        // ),
                        // const SizedBox(height: 8),
                        const GlobalText(
                          "Sign in to continue your shopping journey",
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          color: kLightGrayText,
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 48),

                  // Login Form
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
                            // Remove spaces from phone number before storing
                            String cleanPhone = phone.replaceAll(' ', '');
                            authService.usernameController.text =
                                '$countryCode$cleanPhone';
                          },
                        ),
                        const SizedBox(height: 24),

                        CustomUserTextFormField(
                          title: "Password",
                          hintText: "Enter your password",
                          obscureText: authService.isObscure,
                          controller: authService.passwordController,
                          suffix: IconButton(
                            icon: Icon(
                              authService.isObscure
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                              color: kLightGrayText,
                            ),
                            onPressed: () => authService.setObscure(),
                          ),
                        ),
                        const SizedBox(height: 16),

                        // Remember Me & Forgot Password
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                SizedBox(
                                    height: 20,
                                    width: 20,
                                    child: Checkbox(
                                      value: authService.rememberMe,
                                      activeColor: kLightPrimary,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(4),
                                      ),
                                      onChanged: (value) {
                                        authService.setRememberMe(value);
                                      },
                                    )),
                                const SizedBox(width: 8),
                                const GlobalText(
                                  "Remember me",
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: kLightGrayText,
                                ),
                              ],
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        const ForgotPasswordPage(),
                                  ),
                                );
                              },
                              child: GlobalText(
                                "Forgot Password?",
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: kLightPrimary,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 32),

                        // Login Button
                        Container(
                          width: double.infinity,
                          height: 56,
                          decoration: BoxDecoration(
                            color: kLightPrimary,
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: [
                              BoxShadow(
                                color: kLightPrimary.withOpacity(0.3),
                                spreadRadius: 0,
                                blurRadius: 12,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.transparent,
                              shadowColor: Colors.transparent,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            onPressed: authService.isLoading
                                ? null
                                : () async {
                                    if (authService
                                        .usernameController.text.isEmpty) {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        const SnackBar(
                                          content: Text(
                                              'Please enter your phone number'),
                                          backgroundColor: Colors.red,
                                        ),
                                      );
                                      return;
                                    }

                                    if (authService
                                        .passwordController.text.isEmpty) {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        const SnackBar(
                                          content: Text(
                                              'Please enter your password'),
                                          backgroundColor: Colors.red,
                                        ),
                                      );
                                      return;
                                    }

                                    if (authService
                                            .passwordController.text.length <
                                        6) {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        const SnackBar(
                                          content: Text(
                                              'Password must be at least 6 characters'),
                                          backgroundColor: Colors.red,
                                        ),
                                      );
                                      return;
                                    }

                                    // Clean the phone number before sending to API
                                    String cleanUsername = authService
                                        .usernameController.text
                                        .replaceAll(' ', '');

                                    bool success = await authService.login(
                                      username: cleanUsername,
                                      password:
                                          authService.passwordController.text,
                                      rememberMe: authService.rememberMe,
                                    );

                                    if (success) {
                                      // Clear post-login redirect after successful login
                                      authService.clearPostLoginRedirect();
                                      
                                      // Navigate back with success result
                                      // This will trigger the auth check to re-evaluate
                                      Navigator.pop(context, true);
                                    } else {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        SnackBar(
                                          content: Text(authService.error ??
                                              'Login failed'),
                                          backgroundColor: Colors.red,
                                        ),
                                      );
                                    }
                                  },
                            child: authService.isLoading
                                ? const SizedBox(
                                    height: 20,
                                    width: 20,
                                    child: CircularProgressIndicator(
                                      strokeWidth: 2,
                                      valueColor: AlwaysStoppedAnimation<Color>(
                                          Colors.white),
                                    ),
                                  )
                                : const GlobalText(
                                    "Sign In",
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

                  // Sign Up Link
                  Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const GlobalText(
                          "Don't have an account? ",
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          color: kLightGrayText,
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const RegisterPage(),
                              ),
                            );
                          },
                          child: GlobalText(
                            "Sign Up",
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: kLightPrimary,
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
    } catch (e) {
      print('Error accessing AuthService in LoginPage: $e');
      return Scaffold(
        backgroundColor: Colors.grey.shade50,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.error_outline,
                color: kLightPrimary,
                size: 64,
              ),
              const SizedBox(height: 16),
              const GlobalText(
                'Error loading login page',
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Color(0xFF2D2D2D),
              ),
              const SizedBox(height: 8),
              GlobalText(
                '$e',
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: const Color(0xFF666666),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      );
    }
  }
}

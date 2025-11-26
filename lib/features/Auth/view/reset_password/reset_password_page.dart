import 'package:flutter/material.dart';
import 'package:x_express/core/config/theme/color.dart';
import 'package:x_express/core/config/widgets/globalText.dart';
import 'package:x_express/core/config/widgets/userTextformfeild.dart';
import 'package:x_express/core/config/routes/routes.dart';
import 'package:x_express/features/Auth/data/service/auth_service.dart';
import 'package:provider/provider.dart';

class ResetPasswordPage extends StatefulWidget {
  final String email;

  const ResetPasswordPage({super.key, required this.email});

  @override
  State<ResetPasswordPage> createState() => _ResetPasswordPageState();
}

class _ResetPasswordPageState extends State<ResetPasswordPage> {
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  bool _isLoading = false;
  bool _isObscurePassword = true;
  bool _isObscureConfirmPassword = true;
  bool _passwordsMatch = false;

  @override
  void initState() {
    super.initState();
    _passwordController.addListener(_checkPasswordMatch);
    _confirmPasswordController.addListener(_checkPasswordMatch);
  }

  void _checkPasswordMatch() {
    setState(() {
      _passwordsMatch = _passwordController.text.isNotEmpty &&
          _confirmPasswordController.text.isNotEmpty &&
          _passwordController.text == _confirmPasswordController.text;
    });
  }

  void _togglePasswordVisibility() {
    setState(() {
      _isObscurePassword = !_isObscurePassword;
    });
  }

  void _toggleConfirmPasswordVisibility() {
    setState(() {
      _isObscureConfirmPassword = !_isObscureConfirmPassword;
    });
  }

  bool _isValidPassword(String password) {
    if (password.length < 9) return false;
    if (!password.contains(RegExp(r'[A-Z]'))) return false;
    if (!password.contains(RegExp(r'[a-z]'))) return false;
    return true;
  }

  Future<void> _resetPassword() async {
    if (_passwordController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter your new password')),
      );
      return;
    }

    if (_confirmPasswordController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please confirm your password')),
      );
      return;
    }

    if (!_isValidPassword(_passwordController.text)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text(
                'Password must be at least 9 characters with uppercase and lowercase letters')),
      );
      return;
    }

    if (_passwordController.text != _confirmPasswordController.text) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Passwords do not match')),
      );
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      final authService = Provider.of<AuthService>(context, listen: false);
      bool success = await authService.resetPassword(
        email: widget.email,
        newPassword: _passwordController.text,
        confirmPassword: _confirmPasswordController.text,
      );

      setState(() {
        _isLoading = false;
      });

      if (success) {
        Navigator.pushNamed(
          context,
          AppRoute.success,
          arguments: {
            'title': 'Congratulations!',
            'message':
                'You successfully reset your password.\nNow you are good to go',
            'buttonText': 'Go to Log In',
            'nextRoute': AppRoute.login,
            'isPasswordReset': true,
          },
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              content: Text('Failed to reset password. Please try again.')),
        );
      }
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: ${e.toString()}')),
      );
    }
  }

  @override
  void dispose() {
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
      ),
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
                      const SizedBox(height: 40),

                      Center(
                        child: GlobalText(
                          "Reset Your Password",
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          textAlign: TextAlign.center,
                        ),
                      ),

                      const SizedBox(height: 12),

                      // Password requirements
                      Center(
                        child: GlobalText(
                          "At least 9 characters, with uppercase and lowercase letters",
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: kLightPlatinum300,
                          textAlign: TextAlign.center,
                        ),
                      ),

                      const SizedBox(height: 48),

                      CustomUserTextFormField(
                        title: "Password",
                        hintText: "Enter your new password",
                        controller: _passwordController,
                        obscureText: _isObscurePassword,
                        suffix: IconButton(
                          icon: Icon(
                            _isObscurePassword
                                ? Icons.visibility_off
                                : Icons.visibility,
                          ),
                          onPressed: _togglePasswordVisibility,
                          color: kLightPasswordEyeIcon,
                        ),
                      ),

                      const SizedBox(height: 20),

                      // Confirm Password input field with validation indicator
                      Row(
                        children: [
                          Expanded(
                            child: CustomUserTextFormField(
                              title: "Confirm Password",
                              hintText: "Confirm your new password",
                              controller: _confirmPasswordController,
                              obscureText: _isObscureConfirmPassword,
                              suffix: IconButton(
                                icon: Icon(
                                  _isObscureConfirmPassword
                                      ? Icons.visibility_off
                                      : Icons.visibility,
                                ),
                                onPressed: _toggleConfirmPasswordVisibility,
                                color: kLightPasswordEyeIcon,
                              ),
                            ),
                          ),
                          if (_passwordsMatch &&
                              _confirmPasswordController.text.isNotEmpty)
                            Container(
                              margin: const EdgeInsets.only(left: 12, top: 32),
                              child: Container(
                                width: 24,
                                height: 24,
                                decoration: BoxDecoration(
                                  color: Colors.green,
                                  shape: BoxShape.circle,
                                ),
                                child: Icon(
                                  Icons.check,
                                  color: Colors.white,
                                  size: 16,
                                ),
                              ),
                            ),
                        ],
                      ),

                      const SizedBox(height: 32),

                      // Reset Password button
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
                          onPressed: _isLoading ? null : _resetPassword,
                          child: _isLoading
                              ? const SizedBox(
                                  height: 20,
                                  width: 20,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                    valueColor: AlwaysStoppedAnimation<Color>(
                                        Colors.white),
                                  ),
                                )
                              : GlobalText(
                                  "Reset Password",
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
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

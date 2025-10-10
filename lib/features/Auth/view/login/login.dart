import 'package:flutter/material.dart';
import 'package:x_express/core/config/routes/routes.dart';
import 'package:x_express/core/config/theme/color.dart';
import 'package:x_express/core/config/widgets/globalText.dart';
import 'package:x_express/core/config/widgets/userTextformfeild.dart';
import 'package:x_express/core/config/widgets/phone_input_field.dart';
import 'package:x_express/features/auth/data/service/auth_service.dart';
import 'package:provider/provider.dart';
import 'package:x_express/core/config/language/language.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  void initState() {
    final state = Provider.of<AuthService>(context, listen: false);
    state.loadSavedCredentials();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final language = Provider.of<Language>(context, listen: false).getWords;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Consumer<AuthService>(
            builder: (context, state, child) {
              return Column(
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
                                  "Let’s Sign You In",
                                  fontSize: 25,
                                  fontWeight: FontWeight.bold,
                                  color: kLightTitle,
                                  textAlign: TextAlign.center,
                                ),
                                const SizedBox(height: 12),
                                GlobalText(
                                  "Welcome back, you’ve been missed!",
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500,
                                  color: kLightPlatinum300,
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 70),
                          PhoneInputField(
                            label: "Phone Number",
                            hintText: "Enter your phone number",
                            onChanged: (phone, countryCode) {
                              state.usernameController.text = phone;
                            },
                          ),
                          const SizedBox(height: 28),
                          CustomUserTextFormField(
                            title: "password",
                            hintText: "Enter your password",
                            obscureText: state.isObscure,
                            controller: state.passwordController,
                            suffix: IconButton(
                              icon: Icon(
                                state.isObscure ? Icons.visibility_off : Icons.visibility,
                              ),
                              onPressed: () => state.setObscure(),
                              color: kLightPasswordEyeIcon,
                            ),
                          ),
                          const SizedBox(height: 16),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  SizedBox(
                                    height: 20,
                                    width: 20,
                                    child: Checkbox(
                                      value: state.rememberMe,
                                      activeColor: kLightPrimary,
                                      shape: const CircleBorder(),
                                      onChanged: (value) {
                                        state.setRememberMe(value);
                                      },
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  GlobalText(
                                    "save_me",
                                    fontSize: 14,
                                    color: kLightGrayText,
                                  ),
                                ],
                              ),
                              GestureDetector(
                                onTap: () {
                                  Navigator.pushNamed(context, AppRoute.passwordRecovery);
                                },
                                child: GlobalText(
                                  "forgot_password",
                                  fontSize: 14,
                                  color: kLightGrayText,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 40),
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
                              onPressed: state.isLoading
                                  ? null
                                  : () async {
                                      if (state.usernameController.text.isEmpty) {
                                        ScaffoldMessenger.of(context).showSnackBar(
                                          const SnackBar(content: Text('Please enter your phone number')),
                                        );
                                        return;
                                      }

                                      if (state.passwordController.text.isEmpty) {
                                        ScaffoldMessenger.of(context).showSnackBar(
                                          const SnackBar(content: Text('Please enter your password')),
                                        );
                                        return;
                                      }

                                      if (state.passwordController.text.length < 6) {
                                        ScaffoldMessenger.of(context).showSnackBar(
                                          const SnackBar(content: Text('Password must be at least 6 characters')),
                                        );
                                        return;
                                      }

                                      Navigator.pushReplacementNamed(context, AppRoute.navigationBar);
                                      bool success = await state.login(
                                        username: state.usernameController.text,
                                        password: state.passwordController.text,
                                        rememberMe: state.rememberMe,
                                      );
                                      if (success) {
                                        Navigator.pushReplacementNamed(context, AppRoute.navigationBar);
                                      } else {
                                        ScaffoldMessenger.of(context).showSnackBar(
                                          SnackBar(content: Text(state.error ?? 'Login failed')),
                                        );
                                      }
                                    },
                              child: state.isLoading
                                  ? const SizedBox(
                                      height: 20,
                                      width: 20,
                                      child: CircularProgressIndicator(
                                        strokeWidth: 2,
                                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                                      ),
                                    )
                                  : GlobalText(
                                      "sign_in",
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
                                    Navigator.pushNamed(context, AppRoute.register);
                                  },
                                  child: GlobalText(
                                    "sign_up",
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
              );
            },
          ),
        ),
      ),
    );
  }
}

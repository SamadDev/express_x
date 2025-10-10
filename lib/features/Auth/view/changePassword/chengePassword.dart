import 'package:flutter/material.dart';
import 'package:x_express/core/config/assets/app_images.dart';
import 'package:x_express/core/config/constant/size.dart';
import 'package:x_express/core/config/custome_image_view.dart';
import 'package:x_express/core/config/theme/color.dart';
import 'package:x_express/core/config/widgets/customButton.dart';
import 'package:x_express/core/config/widgets/globalText.dart';
import 'package:x_express/core/config/widgets/loading.dart';
import 'package:x_express/core/config/widgets/success_dialog.dart';
import 'package:x_express/core/config/widgets/userTextformfeild.dart';
import 'package:x_express/features/auth/data/repository/local_storage.dart';
import 'package:x_express/features/auth/data/service/auth_service.dart';
import 'package:provider/provider.dart';

class ChangePasswordPage extends StatefulWidget {
  const ChangePasswordPage({super.key});

  @override
  State<ChangePasswordPage> createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {
  bool rememberMe = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: Consumer<AuthService>(
        builder: (context, state, child) {
          return SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: SizeAsset.spacing),
              child: Column(
                children: [
                  SizedBox(height: SizeAsset.spacing * 2),
                  Center(
                    child: CustomImageView(
                      imagePath: AppImages.loginLogo,
                      color: kLightPrimary,
                      height: 32,
                    ),
                  ),
                  SizedBox(height: SizeAsset.spacing * 5),
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(SizeAsset.spacing * 0.75),
                    decoration: BoxDecoration(
                      color: kLightSurfacePrimary,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.05),
                          blurRadius: 10,
                          spreadRadius: 1,
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        GlobalText(
                          'Change your password',
                          fontWeight: FontWeight.bold,
                          fontSize: 28,
                          color: kLightPrimary,
                        ),
                        SizedBox(height: SizeAsset.spacing * 0.4),
                        GlobalText(
                          'set a new password to secure your account',
                        ),
                        const SizedBox(height: SizeAsset.spacing * 2),
                        CustomUserTextFormField(
                          title: 'Old Password',
                          hintText: "Enter old password",
                          controller: state.currentPasswordController,
                          obscureText: state.isObscure,
                          suffix: IconButton(
                            icon: Icon(
                              state.isObscure ? Icons.visibility_off : Icons.visibility,
                            ),
                            onPressed: () => state.setObscure(),
                            color: kLightPasswordEyeIcon,
                          ),
                        ),
                        const SizedBox(height: 20),
                        CustomUserTextFormField(
                          title: 'New Password',
                          hintText: "Enter new password",
                          controller: state.newPasswordController,
                          obscureText: state.isObscureConfirm,
                          suffix: IconButton(
                            icon: Icon(
                              state.isObscureConfirm ? Icons.visibility_off : Icons.visibility,
                            ),
                            onPressed: () => state.setObscureConfirm(),
                            color: kLightPasswordEyeIcon,
                          ),
                        ),
                        const SizedBox(height: 20),
                        CustomUserTextFormField(
                          title: 'Password',
                          hintText: "Confirm  your password",
                          controller: state.confirmPasswordController,
                          obscureText: state.isObscureConfirm,
                          suffix: IconButton(
                            icon: Icon(
                              state.isObscureConfirm ? Icons.visibility_off : Icons.visibility,
                            ),
                            onPressed: () => state.setObscureConfirm(),
                            color: kLightPasswordEyeIcon,
                          ),
                        ),
                        const SizedBox(height: 24),
                        state.isLoading
                            ? Loading()
                            : CustomerButton(
                                text: "Change Password",
                                onPress: () async {
                                  bool success = await state.changePassword(
                                    currentPassword: state.currentPasswordController.text,
                                    newPassword: state.newPasswordController.text,
                                    confirmPassword: state.confirmPasswordController.text,
                                  );
                                  if (success) {
                                    LocalStorage.clear();
                                    showSuccessDialog(context,message: "password has been updated successfully");
                                  }
                                },
                              )
                      ],
                    ),
                  ),
                  const Spacer(),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GlobalText(
                          'Agree with All ',
                          color: kLightPlatinum500,
                        ),
                        GestureDetector(
                          onTap: () {},
                          child: GlobalText(
                            'Privacy',
                            color: kLightPrimary,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        GlobalText(
                          ' and ',
                          color: kLightPlatinum500,
                        ),
                        GestureDetector(
                          onTap: () {},
                          child: GlobalText(
                            'Policy',
                            color: kLightPrimary,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        GlobalText(
                          ' Terms',
                          color: kLightPlatinum500,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

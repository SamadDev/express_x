import 'package:flutter/material.dart';
import 'package:x_express/core/config/theme/color.dart';
import 'package:x_express/core/config/widgets/globalText.dart';
import 'package:x_express/core/config/widgets/phone_input_field.dart';
import 'package:x_express/core/config/widgets/userTextformfeild.dart';
import 'package:x_express/core/config/routes/routes.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  int _currentStep = 0;
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _otpController = TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  bool _isLoading = false;
  bool _isObscureNewPassword = true;
  bool _isObscureConfirmPassword = true;

  void _setObscureNewPassword() {
    setState(() {
      _isObscureNewPassword = !_isObscureNewPassword;
    });
  }

  void _setObscureConfirmPassword() {
    setState(() {
      _isObscureConfirmPassword = !_isObscureConfirmPassword;
    });
  }

  void _nextStep() {
    if (_currentStep < 2) {
      setState(() {
        _currentStep++;
      });
    }
  }

  void _previousStep() {
    if (_currentStep > 0) {
      setState(() {
        _currentStep--;
      });
    }
  }

  Future<void> _sendOTP() async {
    if (_phoneController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter your phone number')),
      );
      return;
    }

    setState(() {
      _isLoading = true;
    });

    // TODO: Implement OTP sending logic
    await Future.delayed(const Duration(seconds: 2));

    setState(() {
      _isLoading = false;
    });

    _nextStep();
  }

  Future<void> _verifyOTP() async {
    if (_otpController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter the OTP')),
      );
      return;
    }

    setState(() {
      _isLoading = true;
    });

    // TODO: Implement OTP verification logic
    await Future.delayed(const Duration(seconds: 2));

    setState(() {
      _isLoading = false;
    });

    _nextStep();
  }

  Future<void> _resetPassword() async {
    if (_newPasswordController.text.isEmpty ||
        _confirmPasswordController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill all password fields')),
      );
      return;
    }

    if (_newPasswordController.text != _confirmPasswordController.text) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Passwords do not match')),
      );
      return;
    }

    setState(() {
      _isLoading = true;
    });

    // TODO: Implement password reset logic
    await Future.delayed(const Duration(seconds: 2));

    setState(() {
      _isLoading = false;
    });

    // Navigate back to login
    Navigator.pop(context);
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Password reset successfully')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: kLightTitle,
            size: 20,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        title: GlobalText(
          "Reset Password",
          fontSize: 18,
          fontWeight: FontWeight.w600,
          color: kLightTitle,
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            children: [
              // Progress indicator
              Container(
                margin: const EdgeInsets.symmetric(vertical: 20),
                child: Row(
                  children: List.generate(3, (index) {
                    return Expanded(
                      child: Container(
                        margin: EdgeInsets.only(right: index < 2 ? 8 : 0),
                        height: 4,
                        decoration: BoxDecoration(
                          color: index <= _currentStep
                              ? kLightPrimary
                              : kLightPlatinum300,
                          borderRadius: BorderRadius.circular(2),
                        ),
                      ),
                    );
                  }),
                ),
              ),

              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 20),
                      if (_currentStep == 0) _buildPhoneStep(),
                      if (_currentStep == 1) _buildOTPStep(),
                      if (_currentStep == 2) _buildPasswordStep(),
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

  Widget _buildPhoneStep() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GlobalText(
          "Enter Phone Number",
          fontSize: 28,
          fontWeight: FontWeight.w700,
          color: kLightTitle,
        ),
        const SizedBox(height: 8),
        GlobalText(
          "We'll send you a verification code to reset your password",
          fontSize: 16,
          color: kLightPlatinum500,
        ),
        const SizedBox(height: 48),
        PhoneInputField(
          label: "phone_number",
          hintText: "enter_your_phone_number",
          onChanged: (phone, countryCode) {
            // Remove spaces from phone number
            String cleanPhone = phone.replaceAll(' ', '');
            _phoneController.text = cleanPhone;
          },
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
            onPressed: _isLoading ? null : _sendOTP,
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
                    "Send Code",
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
          ),
        ),
      ],
    );
  }

  Widget _buildOTPStep() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GlobalText(
          "Enter Verification Code",
          fontSize: 28,
          fontWeight: FontWeight.w700,
          color: kLightTitle,
        ),
        const SizedBox(height: 8),
        GlobalText(
          "Enter the 6-digit code sent to ${_phoneController.text}",
          fontSize: 16,
          color: kLightPlatinum500,
        ),
        const SizedBox(height: 48),
        CustomUserTextFormField(
          title: "Verification Code",
          hintText: "Enter 6-digit code",
          controller: _otpController,
          keyboard: TextInputType.number,
        ),
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GlobalText(
              "Didn't receive the code? ",
              fontSize: 14,
              color: kLightPlatinum500,
            ),
            GestureDetector(
              onTap: () {
                // Resend OTP logic
              },
              child: GlobalText(
                "Resend",
                fontSize: 14,
                color: kLightPrimary,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
        const SizedBox(height: 32),
        Row(
          children: [
            Expanded(
              child: Container(
                height: 56,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: kLightPlatinum300),
                ),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    elevation: 0,
                    backgroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: _previousStep,
                  child: GlobalText(
                    "Back",
                    color: kLightPlatinum700,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Container(
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
                  onPressed: _isLoading ? null : _verifyOTP,
                  child: _isLoading
                      ? const SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            valueColor:
                                AlwaysStoppedAnimation<Color>(Colors.white),
                          ),
                        )
                      : GlobalText(
                          "Verify",
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildPasswordStep() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GlobalText(
          "Create New Password",
          fontSize: 28,
          fontWeight: FontWeight.w700,
          color: kLightTitle,
        ),
        const SizedBox(height: 8),
        GlobalText(
          "Enter your new password below",
          fontSize: 16,
          color: kLightPlatinum500,
        ),
        const SizedBox(height: 48),
        CustomUserTextFormField(
          title: "new_password",
          hintText: "enter_new_password",
          obscureText: _isObscureNewPassword,
          controller: _newPasswordController,
          suffix: IconButton(
            icon: Icon(
              _isObscureNewPassword ? Icons.visibility_off : Icons.visibility,
            ),
            onPressed: _setObscureNewPassword,
            color: kLightPasswordEyeIcon,
          ),
        ),
        const SizedBox(height: 20),
        CustomUserTextFormField(
          title: "confirm_password",
          hintText: "enter_confirm_password",
          obscureText: _isObscureConfirmPassword,
          controller: _confirmPasswordController,
          suffix: IconButton(
            icon: Icon(
              _isObscureConfirmPassword
                  ? Icons.visibility_off
                  : Icons.visibility,
            ),
            onPressed: _setObscureConfirmPassword,
            color: kLightPasswordEyeIcon,
          ),
        ),
        const SizedBox(height: 32),
        Row(
          children: [
            Expanded(
              child: Container(
                height: 56,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: kLightPlatinum300),
                ),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    elevation: 0,
                    backgroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: _previousStep,
                  child: GlobalText(
                    "Back",
                    color: kLightPlatinum700,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Container(
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
                            valueColor:
                                AlwaysStoppedAnimation<Color>(Colors.white),
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
            ),
          ],
        ),
      ],
    );
  }

  @override
  void dispose() {
    _phoneController.dispose();
    _otpController.dispose();
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }
}

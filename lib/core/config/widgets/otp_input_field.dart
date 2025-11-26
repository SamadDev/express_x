import 'dart:async';
import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:x_express/core/config/theme/color.dart';
import 'package:x_express/core/config/widgets/globalText.dart';

/// OTP Input Field Widget with countdown timer and resend functionality
class OtpInputField extends StatefulWidget {
  final String title;
  final String message;
  final String emailOrPhone;
  final int otpLength;
  final int countdownDuration; // in seconds
  final Function(String otp)? onCompleted;
  final Function()? onResend;
  final VoidCallback? onContinue;
  final String? Function(String?)? validator;
  final bool autoFocus;

  const OtpInputField({
    super.key,
    required this.title,
    required this.message,
    required this.emailOrPhone,
    this.otpLength = 4,
    this.countdownDuration = 60,
    this.onCompleted,
    this.onResend,
    this.onContinue,
    this.validator,
    this.autoFocus = true,
  });

  @override
  State<OtpInputField> createState() => _OtpInputFieldState();
}

class _OtpInputFieldState extends State<OtpInputField> {
  final TextEditingController _otpController = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  Timer? _timer;
  int _countdown = 0;
  bool _canResend = false;
  bool _isOtpComplete = false;
  String _currentOtp = '';

  @override
  void initState() {
    super.initState();
    _countdown = widget.countdownDuration;
    _startCountdown();
  }

  void _startCountdown() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_countdown > 0) {
        setState(() {
          _countdown--;
          _canResend = false;
        });
      } else {
        setState(() {
          _canResend = true;
        });
        _timer?.cancel();
      }
    });
  }

  void _onOtpChanged(String value) {
    setState(() {
      _currentOtp = value;
      _isOtpComplete = value.length == widget.otpLength;
    });
    widget.onCompleted?.call(value);
  }

  void _onResend() {
    if (_canResend) {
      setState(() {
        _countdown = widget.countdownDuration;
        _canResend = false;
        _currentOtp = '';
        _isOtpComplete = false;
        _otpController.clear();
      });
      _startCountdown();
      widget.onResend?.call();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 40),
              GlobalText(
                widget.title,
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: kLightTitle,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  style: TextStyle(
                    color: kLightPlatinum400,
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                  ),
                  children: [
                    TextSpan(text: widget.message),
                    TextSpan(
                      text: widget.emailOrPhone,
                      style: TextStyle(
                        color: kLightTitle,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 40),

              PinCodeTextField(
                appContext: context,
                length: widget.otpLength,
                controller: _otpController,
                focusNode: _focusNode,
                autoFocus: widget.autoFocus,
                keyboardType: TextInputType.number,
                animationType: AnimationType.fade,
                animationDuration: const Duration(milliseconds: 300),
                enableActiveFill: true,
                onChanged: _onOtpChanged,
                onCompleted: (value) {
                  setState(() {
                    _isOtpComplete = true;
                  });
                  widget.onCompleted?.call(value);
                },
                pinTheme: PinTheme(
                  shape: PinCodeFieldShape.box,
                  borderRadius: BorderRadius.circular(12),
                  fieldHeight: 60,
                  fieldWidth: 60,
                  borderWidth: 1,
                  activeFillColor: Colors.white,
                  inactiveFillColor: Colors.white,
                  selectedFillColor: Colors.white,
                  activeColor: kLightPrimary,
                  inactiveColor: kLightPlatinum300,
                  selectedColor: kLightPrimary,
                  errorBorderColor: kLightError,
                ),
                textStyle: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w600,
                  color: kLightTitle,
                ),
                cursorColor: kLightPrimary,
                enablePinAutofill: true,
                hapticFeedbackTypes: HapticFeedbackTypes.light,
                textInputAction: TextInputAction.done,
              ),
              const SizedBox(height: 32),

              // Resend Section
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GlobalText(
                    "Didn't receive code. ",
                    fontSize: 14,
                    color: kLightTitle,
                    fontWeight: FontWeight.w400,
                  ),
                  GestureDetector(
                    onTap: _canResend ? _onResend : null,
                    child: GlobalText(
                      _canResend ? "Resend" : "Resend (${_countdown}s)",
                      fontSize: 14,
                      color: _canResend ? kLightPrimary : kLightPlatinum400,
                      fontWeight: FontWeight.w500,
                      decoration: _canResend
                          ? TextDecoration.underline
                          : TextDecoration.none,
                    ),
                  ),
                ],
              ),

              const Spacer(),

              // Continue Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _isOtpComplete ? widget.onContinue : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        _isOtpComplete ? kLightPrimary : kLightPlatinum300,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 0,
                  ),
                  child: GlobalText(
                    "Continue",
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ),
              const SizedBox(height: 24),

              // Terms and Conditions
              RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  style: TextStyle(
                    color: kLightPlatinum400,
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                  ),
                  children: [
                    const TextSpan(text: "By Signing up, you agree to our. "),
                    TextSpan(
                      text: "Term and Conditions",
                      style: TextStyle(
                        color: kLightTitle,
                        fontWeight: FontWeight.w500,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _timer?.cancel();
    _otpController.dispose();
    _focusNode.dispose();
    super.dispose();
  }
}

/// Simple OTP Input Field without full page layout
class SimpleOtpInputField extends StatelessWidget {
  final int length;
  final Function(String)? onChanged;
  final Function(String)? onCompleted;
  final String? Function(String?)? validator;
  final bool autoFocus;
  final TextEditingController? controller;
  final FocusNode? focusNode;

  const SimpleOtpInputField({
    super.key,
    this.length = 4,
    this.onChanged,
    this.onCompleted,
    this.validator,
    this.autoFocus = true,
    this.controller,
    this.focusNode,
  });

  @override
  Widget build(BuildContext context) {
    return PinCodeTextField(
      appContext: context,
      length: length,
      controller: controller,
      focusNode: focusNode,
      autoFocus: autoFocus,
      keyboardType: TextInputType.number,
      animationType: AnimationType.fade,
      animationDuration: const Duration(milliseconds: 300),
      enableActiveFill: true,
      onChanged: onChanged,
      onCompleted: onCompleted,
      pinTheme: PinTheme(
        shape: PinCodeFieldShape.box,
        borderRadius: BorderRadius.circular(12),
        fieldHeight: 60,
        fieldWidth: 60,
        borderWidth: 1,
        activeFillColor: Colors.white,
        inactiveFillColor: Colors.white,
        selectedFillColor: Colors.white,
        activeColor: kLightPrimary,
        inactiveColor: kLightPlatinum300,
        selectedColor: kLightPrimary,
        errorBorderColor: kLightError,
      ),
      textStyle: TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.w600,
        color: kLightTitle,
      ),
      cursorColor: kLightPrimary,
      enablePinAutofill: true,
      hapticFeedbackTypes: HapticFeedbackTypes.light,
      textInputAction: TextInputAction.done,
    );
  }
}

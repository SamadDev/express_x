import 'package:flutter/material.dart';
import 'package:x_express/features/Auth/view/changePassword/chengePassword.dart';
import 'package:x_express/features/Auth/view/login/login.dart';
import 'package:x_express/features/Auth/view/register/register.dart';
import 'package:x_express/features/Auth/view/forgot_password/forgot_password_page.dart';
import 'package:x_express/features/Auth/view/password_recovery/password_recovery_page.dart';
import 'package:x_express/features/Auth/view/reset_password/reset_password_page.dart';
import 'package:x_express/features/Auth/view/success/success_page.dart';
import 'package:x_express/features/Auth/view/otp_verification/otp_verification_page.dart';
import 'package:x_express/features/wellcom/splash.dart';

class AppRoute {
  static const String splash = '/';
  static const String onboarding = 'onboarding';
  static const String login = 'login';
  static const String register = 'register';
  static const String forgotPassword = 'forgotPassword';
  static const String passwordRecovery = 'passwordRecovery';
  static const String resetPassword = 'resetPassword';
  static const String otpVerification = 'otpVerification';
  static const String success = 'success';
  static const String initialLanguageSelection = 'initialLanguageSelection';
  static const String locationSelection = 'locationSelection';
  static const String navigationBar = 'navigationBar';
  static const String navigationBarManager = 'navigationBarManager';
  static const String changePassword = 'changePassword';
  static const String home = 'home';
  static const String leave = 'leave';
  static const String businessLeave = 'businessLeave';
  static const String epr = 'epr';
  static const String complainPage = 'complain.dart';
  static const String leaveFormPage = 'leaveFormPage';
  static const String metingFormPage = 'metingFormPage';
  static const String leaveDetailPage = 'leaveDetailPage';
  static const String metingPage = 'metingPage';
  static const String metingDetailPage = 'metingDetailPage';
  static const String jDPagePage = 'jDPagePage';
  static const String salaryPage = 'salaryPage';
  static const String policyPage = 'policyPage';
  static const String overtimePage = 'overtimePage';
  static const String attendancePage = 'attendancePage';
  static const String overtimeFormPage = 'overtimeFormPage';
  static const String notification = 'notification';
  static const String notificationDetail = 'notificationDetail';
  static const String language = 'language';
  static const String organization = 'organizationPage';
  static const String employeeDetailPage = 'employeeDetailPage';
  static const String profileDetailPage = 'profileDetailPage';
  static const String employeePage = 'employeePage';
  static const String chatHomePage = 'chatHomePage';
  static const String chatPage = 'chatPage';
  static const String announcement = ' announcement';
  static const String announcementDetail = ' announcementDetail';
  static const String policyDetailPage = ' policyDetailPage';
  static const String tutorialPage = ' tutorialPage';
  static const String eprList = 'eprList';
  static const String leaveBusinessFormPage = 'leaveBusinessFormPage';
  static const String travelDetailPage = 'travelDetailPage';
  static const String managerOvertimePage = 'managerOvertimePage';
  static const String managerOvertimeDetailPage = 'managerOvertimeDetailPage';
  static const String managerEprListPage = 'managerEprListPage';
  static const String managerLeaveBalanceListPage = 'managerLeaveBalanceListPage';
  static const String managerLeaveBalanceDetailPage = 'managerLeaveBalanceDetailPage';

  AppRoute._();

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case splash:
        return MaterialPageRoute(builder: (_) =>  SplashScreen());

      case login:
        return MaterialPageRoute(builder: (_) => const LoginPage());
      case register:
        return MaterialPageRoute(builder: (_) => const RegisterPage());
      case forgotPassword:
        return MaterialPageRoute(builder: (_) => const ForgotPasswordPage());
      case passwordRecovery:
        return MaterialPageRoute(builder: (_) => const PasswordRecoveryPage());
      case resetPassword:
        final email = settings.arguments as String? ?? '';
        return MaterialPageRoute(builder: (_) => ResetPasswordPage(email: email));
      case otpVerification:
        final phoneNumber = settings.arguments as String? ?? '';
        return MaterialPageRoute(builder: (_) => OtpVerificationPage(phoneNumber: phoneNumber));
      case success:
        final args = settings.arguments as Map<String, dynamic>? ?? {};
        return MaterialPageRoute(
          builder: (_) => SuccessPage(
            title: args['title'] ?? 'Congratulations!',
            message: args['message'] ?? 'Operation completed successfully!',
            buttonText: args['buttonText'] ?? 'Continue',
            nextRoute: args['nextRoute'] ?? AppRoute.login,
            isPasswordReset: args['isPasswordReset'] ?? false,
          ),
        );

      case changePassword:
        return MaterialPageRoute(builder: (_) => const ChangePasswordPage());



      default:
        throw const Scaffold();
    }
  }
}

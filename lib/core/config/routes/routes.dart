import 'package:flutter/material.dart';
class AppRoute {
  static const String splash = '/';
  static const String login = 'login';
  static const String register = 'register';
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

      default:
        throw const Scaffold();
    }
  }
}

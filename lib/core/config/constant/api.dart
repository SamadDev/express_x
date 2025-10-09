import 'package:flutter_dotenv/flutter_dotenv.dart';

class AppUrl {
  static var baseURL = dotenv.env['DOMAIN']!;
  static var uploadURL = dotenv.env['UPLOADURL']!;

  // Ensure base URL ends with a slash
  static String get _formattedBaseURL {
    if (baseURL.endsWith('/')) {
      return baseURL;
    } else {
      return '$baseURL/';
    }
  }

  static String login = '${_formattedBaseURL}Authentication';
  static String checkUserType = '${_formattedBaseURL}hr/mypage/employee/self-direct-reports';
  static String profile = '${_formattedBaseURL}hr/mypage/employee/profile';
  static String attendance = '${_formattedBaseURL}hr/mypage/attendance/self';
  static String announcement = '${_formattedBaseURL}hr/mypage/announcement/self-announcements';
  static String upComingHoliday = '${_formattedBaseURL}hr/mypage/dashboard/upcoming-holidays';
  static String policy = '${_formattedBaseURL}hr/mypage/company-policy/self';
  static String complain = '${_formattedBaseURL}hr/complaints';
  static String tutorial = '${_formattedBaseURL}hr/mypage/tutorial';
  static String meting = '${_formattedBaseURL}hr/mypage/meetings/all';

  static String leave = '${_formattedBaseURL}hr/mypage/leave/self';
  static String whatsHappening = '${_formattedBaseURL}hr/mypage/dashboard/whats-happening';
  static String leaveDetail = '${_formattedBaseURL}HR/EmployeeLeaves/EmployeeLeaveResult/';
  static String businessLeave = '${_formattedBaseURL}hr/travel/all';
  static String businessLeaveDetail = '${_formattedBaseURL}hr/travel/detail/';
  static String businessLeaveType = '${_formattedBaseURL}hr/travel/type';
  static String businessLeaveCity = '${_formattedBaseURL}hr/travel/city';
  static String businessLeaveDestination = '${_formattedBaseURL}hr/travel/destination';
  static String businessLeaveTransportation = '${_formattedBaseURL}hr/travel/transportation';
  static String businessLeavePurpose = '${_formattedBaseURL}hr/travel/purpose';
  static String leaveBusinessExpenseType = '${_formattedBaseURL}hr/travel/expense-type';
  static String leaveBusinessCountry = '${_formattedBaseURL}hr/country';
  static String leaveBusinessEmployee = '${_formattedBaseURL}hr/travel/employees';
  static String businessLeavePost = '${_formattedBaseURL}hr/travel';
  static String trackTravel = '${_formattedBaseURL}hr/travel/track/';
  static String trackLeave = '${_formattedBaseURL}hr/mypage/leave/approval/';
  static String trackTravelGet = '${_formattedBaseURL}hr/travel/track/';
  static String trackTravelTracks = '${_formattedBaseURL}hr/travel/track/tracks/';

  static String leaveType = '${_formattedBaseURL}hr/mypage/leave/self-leave-types';
  static String leaveBalance = '${_formattedBaseURL}hr/mypage/leave/self-leave-balance/?';
  static String leaveDelegate = '${_formattedBaseURL}hr/mypage/employee/delegate/';
  static String leavePost = '${_formattedBaseURL}hr/mypage/leave';

  static String overtime = '${_formattedBaseURL}HR/EmployeeOvertimes/self';
  static String overtimeCalculate = '${_formattedBaseURL}HR/EmployeeOvertimes/calculate-overtime';
  static String overtimePost = '${_formattedBaseURL}HR/EmployeeOvertimes';
  static String overtimeDetail = '${_formattedBaseURL}HR/EmployeeOvertimes/';

  static String jobDescription = '${_formattedBaseURL}hr/job-description/self-detail';
  static String attendanceLog = '${_formattedBaseURL}hr/mypage/dashboard/attendance';
  static String employees = '${_formattedBaseURL}hr/mypage/employee/self-contacts';
  static String epr = '${_formattedBaseURL}hr/employee-review/self-detail/';
  static String eprList = '${_formattedBaseURL}hr/employee-review/self';
  static String notification = '${_formattedBaseURL}app/mypage/notification/unread';
  static String employeeDetail = '${_formattedBaseURL}HR/Employees/profile-detail/';
  static String employeeDelegate = '${_formattedBaseURL}HR/EmployeeOvertimes/self-delegation';
  static String profileDetail = '${_formattedBaseURL}hr/mypage/employee/detail';
  static String changePassword = '${_formattedBaseURL}Security/Users/ChangePassword';
  static String isEligible = '${_formattedBaseURL}hr/mypage/overtime/is-eligible';

  // New approval endpoints
  static String overtimeApproval = '${_formattedBaseURL}hr/mypage/overtime/ApplyApproval/';
  static String rewardApproval = '${_formattedBaseURL}hr/reward';
  static String statusChangeApproval = '${_formattedBaseURL}hr/status-change';

  // Manager-specific endpoints
  static String managerAttendance = '${_formattedBaseURL}hr/mypage/attendance/self-report/';
  static String managerLeave = '${_formattedBaseURL}hr/mypage/leave/approvals';
  static String managerOvertime = '${_formattedBaseURL}hr/mypage/overtime/approvals';
  static String managerOvertimeDetail = '${_formattedBaseURL}hr/mypage/overtime/approval/';
  static String managerOvertimeApproval = '${_formattedBaseURL}hr/mypage/overtime/approval/';
  static String managerErp = '${_formattedBaseURL}hr/employee-review/self-report';
  static String managerJdList = '${_formattedBaseURL}hr/job-description/self';
  static String managerJdDetail = '${_formattedBaseURL}hr/job-description/detail/';
  static String managerLeaveBalance = '${_formattedBaseURL}hr/mypage/leave/self-reporting-leave-balance';
}

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import "package:shared_preferences/shared_preferences.dart";

Map<String, dynamic> words(BuildContext context) {
  return Provider.of<Language>(context).getWords;
}

class Language with ChangeNotifier {
  String languageDirection = 'ltr';
  String languageCode = 'en';
  Map<String, dynamic> _jsonWords = {};

  Language() {
    _loadLanguageData();
  }

  void setLanguage(code, direction) async {
    languageCode = code;
    languageDirection = direction;
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString('languageCode', languageCode);
    sharedPreferences.setString('languageDirection', direction);
    notifyListeners();
  }

  Future<void> getLanguageDataInLocal() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    languageCode = sharedPreferences.getString('languageCode') ?? languageCode;
    languageDirection =
        sharedPreferences.getString('languageDirection') ?? languageDirection;
    notifyListeners();
  }

  Map<String, dynamic> get getWords {
    // Try to use JSON data first, fallback to hardcoded data
    if (_jsonWords.isNotEmpty) {
      return _jsonWords;
    }
    return words[languageCode];
  }

  Future<void> _loadLanguageData() async {
    try {
      final String jsonString =
          await rootBundle.loadString('lib/core/config/language/en.json');
      final Map<String, dynamic> jsonData = json.decode(jsonString);
      _jsonWords = jsonData;
      notifyListeners();
    } catch (e) {
      print('Error loading language data from JSON: $e');
      // Keep using hardcoded data if JSON loading fails
    }
  }

  final Map<String, dynamic> words = {
    "en": {
      "approve": "Approve",
      "cancel": "Cancel",
      "retry": "Retry",
      "logout": "Logout",
      "search": "Search",
      "from": "From",
      "to": "To",
      "duration": "Duration",
      "start_date": "Start Date",
      "end_date": "End Date",
      "sequence": "Sequence",
      "check_in": "Check In",
      "department": "Department",
      "employee": "Employee",
      "attendees": "Attendees",
      "topic": "Topic",
      "time": "Time",
      "job_position": "Job Position",
      "unknown": "Unknown",
      "unknown_employee": "Unknown Employee",
      "unknown_position": "Unknown Position",
      "unknown_department": "Unknown Department",
      "na": "N/A",
      "business_travel_list": "Business Travel List",
      "no_travel_requests_found": "No travel requests found",
      "view_details": "View Details",
      "approve_travel_request": "Approve Travel Request",
      "travel_request_approved": "Travel request approved!",
      "purpose": "Purpose",
      "error_loading_travel_details": "Error loading travel details",
      "business_leave": "BusinessLeave",
      "request_business_leave": "Request BusinessLeave",
      "login": "Login",
      "remember_me": "Remember me",
      "forgot_password": "Forgot password ?",
      "send": "Send",
      "delete": "Delete",
      "submit": "Submit",
      "welcome_sign_in_to_continue": "Welcome! Sign in to continue",
      "agree_with_all": "Agree with All ",
      "privacy": "Privacy",
      "policy": "Policy",
      "terms": "Terms",
      "email_or_username": "Email or username",
      "enter_your_email_or_username": "Enter your email or username",
      "password": "Password",
      "enter_your_password": "Enter your password",
      "old_password": "Old Password",
      "enter_old_password": "Enter old password",
      "new_password": "New Password",
      "enter_new_password": "Enter new password",
      "confirm_your_password": "Confirm  your password",
      "upload_attachment": "Upload  Attachment",
      "write_letter_to_show_delegate": "Write letter to show Delegate",
      "search_employee": "Search Employee",
      "select_employees": "Select Employees",
      "type_employee_name": "Type employee name",
      "reason": "Reason",
      "comment_placeholder": "Comment.......",
      "message": "Message",
      "input_placeholder": "Input Placeholder",
      "write_your_suggestion_detail": "Write your Suggestion detail",
      "selected_on_employee": "Selected On Employee",
      "enter_your_topic": "Enter your topic",
      "select_time": "Select Time",
      "selected_your_department": "Selected Your Department",
      "select_your_job": "Select your job",
      "select_on_employ": "Select on Employ",
      "select_date_range": "Select Date Range",
      "please_select_both_start_and_end_dates":
          "Please select both start and end dates",
      "form_submitted": "Form submitted!",
      "you_do_not_have_permission": "You do not have permission",
      "preferences": "Preferences",
      "account": "Account",
      "language": "Language",
      "notification": "Notification",
      "dark_mode": "Dark mode",
      "logout_from_your_account": "Logout from your account",
      "please_make_sure_you_want_logout": "Please make sure you want logout",
      "leave": "Leave",
      "leaves": "Leaves",
      "request_leave": "Request Leave",
      "epr_list": "EPR List",
      "result": "Result",
      "see_all": "See All",
      "chat_history": "Chat history",
      "explore_topic": "Explore topic",
      "new_chat": "New Chat",
      "programming": "Programming",
      "coding": "Coding",
      "content": "Content",
      "writing": "Writing",
      "strategy": "Strategy",
      "planning": "Planning",
      "tutorial": "Tutorial",
      "tutorial_video": "Tutorial Video",
      "video_url": "Video URL:",
      "open_video": "Open Video",
      "close": "Close",
      "failed_to_load_video": "Failed to load video",
      "video_not_available": "Video not available",
      "salary": "Salary",
      "new": "New",
      "recent": "Recent",
      "no_new_notifications": "No new notifications",
      "no_recent_notifications": "No recent notifications",
      "marketing_department": "Marketing department",
      "policy_document": "Policy Document",
      "participants": "Participants",
      "no_delegate_found": "No delegate found.",
      "no_data_found": "No data found.",
      "type": "Type",
      "delegate": "Delegate",
      "request_date": "Request Date",
      "total_duration": "Total Duration",
      "attachment": "Attachment",
      "employee_name": "Employee Name",
      "employee_id": "Employee ID:",
      "status": "Status",
      "work_essentials": "Work Essentials",
      "attendance": "Attendance",
      "announcement": "Announcement",
      "my_portal": "My Portal",
      "organization": "Organization",
      "my_jd": "My JD",
      "complain": "Complain",
      "how_to_use": "How to use",
      "policies": "Polices",
      "team": "Team",
      "travel": "Travel",
      "my_epr": "My EPR",
      "business_leave_label": "Business Leave",
      "request_meeting": "Request Meeting",
      "call_by": "Call By",
      "overtime_request_success": "Overtime requested successfully done",
      "please_select_an_employee": "Please select an employee",
      "please_select_a_date_first": "Please select a date first",
      "from_time_cannot_be_in_the_past": "From time cannot be in the past",
      "from_time_cannot_be_before_shift_end":
          "From time cannot be before shift end",
      "please_select_from_time_first": "Please select 'From time' first",
      "to_time_must_be_after_from_time": "To time must be after From time",
      "duration_must_be_at_least_30_minutes":
          "Duration must be at least 30 minutes",
      "to_time_should_be_after_last_punch":
          "To time should be after last punch",
      "from_time": "From time",
      "to_time": "To time",
      "shift_end": "Shift end",
      "last_punch": "Last punch",
      "no_dates_selected": "No dates selected",
      "remaining": "Remaining:",
      "taken": "Taken:",
      "salary_deposit_msg":
          "Your salary for has been deposited. You can now collect it or check your account for details",
      "balance": "Balance",
      "my_team_jd": "My Team JD",
      "erp": "ERP",
      "request": "Request",
      "home": "Home",
      "service": "Service",
      "approval": "Approval",
      "setting": "Setting",
      "travel_transportation": "Travel Transportation",
      "rental_vehicle_price": "Rental Vehicle Price (IQD)",
      "travel_type": "Travel Type",
      "hotel_accommodation": "Hotel Accommodation",
      "passport": "Passport",
      "passport_or_national_id": "Passport or National ID",
      "visa_required": "Visa Required",
      "who_are_you_traveling_with": "Who are you Traveling with",
      "alone": "Alone",
      "group": "Group",
      "personal_travel_combine_business":
          "Personal travel combine Business Travel?",
      "days_on_personal_expense": "Days on personal expense",
      "travel_departure_date": "Travel Departure Date",
      "travel_return_date": "Travel Return Date",
      "travel_purpose": "Travel Purpose",
      "required_meals": "Required Meals",
      "country": "Country",
      "from_city": "From City",
      "to_city": "To City",
      "multiple_destinations": "Multiple Destinations?",
      "return_date": "Return Date:",
      "hotel": "Hotel:",
      "check_out": "Check Out",
      "and": "and",
      "confirm_rejection": "Confirm Rejection",
      "reject": "Reject",
      "travel_request_rejected_successfully":
          "Travel request rejected successfully",
      "overtime_request_rejected_successfully":
          "Overtime request rejected successfully",
      "reward_request_rejected_successfully":
          "Reward request rejected successfully",
      "status_change_request_rejected_successfully":
          "Status change request rejected successfully",
      "leave_request_rejected_successfully":
          "Leave request rejected successfully",
      "request_rejected_successfully": "Request rejected successfully",
      "confirm_approval": "Confirm Approval",
      "travel_request_approved_successfully":
          "Travel request approved successfully",
      "overtime_request_approved_successfully":
          "Overtime request approved successfully",
      "reward_request_approved_successfully":
          "Reward request approved successfully",
      "status_change_request_approved_successfully":
          "Status change request approved successfully",
      "leave_request_approved_successfully":
          "Leave request approved successfully",
      "request_approved_successfully": "Request approved successfully",
      "confirm_reject_request": "Are you sure you want to reject this request?",
      "confirm_approve_request":
          "Are you sure you want to approve this request?",
      "please_select_a_country": "Please select a country",
      "please_select_a_city": "Please select a city",
      "please_select_a_city_from_list": "Please select a city from the list",
      "delegate_is_required": "Delegate is required",
      "travel_details": "Travel Details",
      "basic_information": "Basic Information",
      "branch": "Branch",
      "primary_location": "Primary Location",
      "invoice_number": "Invoice Number",
      "transportation": "Transportation",
      "travel_method": "Travel Method",
      "delegation": "Delegation",
      "travel_employees": "Travel Employees",
      "personal_travel": "Personal Travel",
      "traveling_alone": "Traveling Alone",
      "number_of_nights": "Number of Nights",
      "itineraries": "Itineraries",
      "travel_date": "Travel Date",
      "expenses": "Expenses",
      "ticket_details": "Ticket Details",
      "hotel_details": "Hotel Details",
      "cost_information": "Cost Information",
      "visa_cost": "Visa Cost",
      "confirmed_visa_cost": "Confirmed Visa Cost",
      "airport_transfer_cost": "Airport Transfer Cost",
      "confirmed_airport_transfer_cost": "Confirmed Airport Transfer Cost",
      "transportation_cost": "Transportation Cost",
      "total_flight_accommodation": "Total Flight Accommodation",
      "total_cost": "Total Cost",
      "daily_per_diem": "Daily Per Diem",
      "total_per_diem": "Total Per Diem",
      "personal_expense_days": "Personal Expense Days",
      "approval_information": "Approval Information",
      "travel_step": "Travel Step",
      "travel_step_id": "Travel Step ID",
      "passport_file": "Passport File",
      "meal": "Meal",
      "travel_hotel": "Travel Hotel",
      "approval_timeline": "Approval Timeline",
    },
  };
}

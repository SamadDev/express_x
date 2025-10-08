import 'package:intl/intl.dart';

import 'package:intl/intl.dart';

String formatDate(String? dateString) {
  if (dateString == null || dateString.isEmpty) {
    return ""; // Handle null or empty
  }

  try {
    // Parse the ISO 8601 string
    DateTime date = DateTime.parse(dateString);
    // Format the date
    return DateFormat("dd/MM/yyyy").format(date.toLocal()); // Adjusts to local timezone
  } catch (e) {
    return ""; // Handle invalid format
  }
}
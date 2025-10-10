import 'package:intl/intl.dart';

class DateFormatter {
  static String dayMonthYear(String? dateString) {
    final date = parse(dateString);
    if (date == null) return '';
    return DateFormat('dd MMM yyyy').format(date);
  }

  static String dashDate(String? dateString) {
    final date = parse(dateString);
    if (date == null) return '';
    return DateFormat('dd-MM-yyyy').format(date);
  }

  static String dashDateTime(String? dateString) {
    final date = parse(dateString);
    if (date == null) return '';
    return DateFormat('dd-MM-yyyy-HH:mm').format(date);
  }

  static String time(String? dateString) {
    final date = parse(dateString);
    if (date == null) return '';
    return DateFormat('HH:mm').format(date);
  }

  static DateTime? parse(String? dateString) {
    if (dateString == null || dateString.isEmpty) return null;
    try {
      return DateTime.parse(dateString);
    } catch (e) {
      return null;
    }
  }
}

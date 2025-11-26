class DateRange {
  static String get defaultFromDate =>
      "${DateTime.now().year}-${DateTime.now().month.toString().padLeft(2, '0')}-01";
  static String get defaultToDate =>
      "${DateTime(DateTime.now().year, DateTime.now().month + 1, 0).toString().split(' ')[0]}";
}

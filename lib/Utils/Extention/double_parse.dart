double parseDouble(dynamic value) {
  if (value == null || value == '') {
    return 0.0;
  } else {
    return double.tryParse(value.toString()) ?? 0.0;
  }
}
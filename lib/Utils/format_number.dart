// String formatQuantity(double v) {
//   String stringValue = v.toString();
//   List<String> parts = stringValue.split('.');
//
//   if (parts.length == 1) {
//     return '${parts[0]}.00';
//   }
//
//   String decimal = parts[1];
//   if (decimal.length >= 2) {
//     return '${parts[0]}.${decimal.substring(0, 2)}';
//   } else {
//     return '${parts[0]}.${decimal.padRight(2, '0')}';
//   }
// }
//

import 'package:intl/intl.dart';

String formatQuantity(double v) {
  final formatter = NumberFormat("#,##0.00", "en_US");
  return formatter.format(v);
}
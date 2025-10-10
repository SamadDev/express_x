// import "package:flutter/material.dart";
// import "package:x_express/core/config/theme/color.dart";
//
// Future<void> selectTime({
//   required BuildContext context,
//   required TextEditingController controller,
// }) async {
//   final TimeOfDay? picked = await showTimePicker(
//     context: context,
//     initialTime: TimeOfDay.now(),
//     builder: (context, child) {
//       return Theme(
//         data: Theme.of(context).copyWith(
//           colorScheme: Theme.of(context).colorScheme.copyWith(
//             primary: kLightPrimary,
//           ),
//         ),
//         child: child!,
//       );
//     },
//   );
//
//   if (picked != null) {
//     controller.text =
//     "${picked.hour.toString().padLeft(2, '0')}:${picked.minute.toString().padLeft(2, '0')}";
//   }
// }
//
// Future<void> selectDate({
//   required BuildContext context,
//   required TextEditingController controller,
//   DateTime? firstDate,
//   DateTime? initialDate,
// }) async {
//   final DateTime? picked = await showDatePicker(
//     context: context,
//     initialDate: initialDate ?? DateTime.now(),
//     firstDate: firstDate ?? DateTime.now(), // Changed this line
//     lastDate: DateTime(2100),
//     builder: (context, child) {
//       return Theme(
//         data: Theme.of(context).copyWith(
//           colorScheme: Theme.of(context).colorScheme.copyWith(
//             primary: kLightPrimary,
//           ),
//         ),
//         child: child!,
//       );
//     },
//   );
//
//   if (picked != null) {
//     controller.text = picked.toIso8601String().split('T').first;
//   }
// }

import "package:flutter/material.dart";
import "package:x_express/core/config/theme/color.dart";

Future<void> selectTime({
  required BuildContext context,
  required TextEditingController controller,
}) async {
  final TimeOfDay? picked = await showTimePicker(
    context: context,
    initialTime: TimeOfDay.now(),
    builder: (context, child) {
      return Theme(
        data: Theme.of(context).copyWith(
          colorScheme: Theme.of(context).colorScheme.copyWith(
            primary: kLightPrimary,
          ),
        ),
        child: child!,
      );
    },
  );

  if (picked != null) {
    controller.text =
    "${picked.hour.toString().padLeft(2, '0')}:${picked.minute.toString().padLeft(2, '0')}";
  }
}

Future<void> selectDate({
  required BuildContext context,
  required TextEditingController controller,
  DateTime? firstDate,
  DateTime? initialDate,
  bool allowPastDates = true,
}) async {
  final DateTime? picked = await showDatePicker(
    context: context,
    initialDate: initialDate ?? DateTime.now(),
    firstDate: firstDate ?? (allowPastDates ? DateTime(1900) : DateTime.now()),
    lastDate: DateTime(2100),
    builder: (context, child) {
      return Theme(
        data: Theme.of(context).copyWith(
          colorScheme: Theme.of(context).colorScheme.copyWith(
            primary: kLightPrimary,
          ),
        ),
        child: child!,
      );
    },
  );

  if (picked != null) {
    controller.text = picked.toIso8601String().split('T').first;
  }
}
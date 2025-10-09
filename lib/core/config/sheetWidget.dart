import 'package:flutter/material.dart';

void ButtonSheetWidget({context, child, heightFactor}) {
  showModalBottomSheet(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(13),
        topRight: Radius.circular(13),
      ),
    ),
    context: context,
    isScrollControlled: true,
    builder: (BuildContext context) {
      return FractionallySizedBox(
        heightFactor: heightFactor,
        child: child,
      );
    },
  );
}

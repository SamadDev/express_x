import 'package:flutter/material.dart';

void ShowModuleBottomSheet(context, child) {
  showModalBottomSheet(
    shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10))),
    context: context,
    isScrollControlled: true,
    builder: (BuildContext context) {
      return child;
    },
  );
}
import 'package:flutter/material.dart';
import 'package:x_express/Theme/style.dart';

class TextDropDownWidget extends StatelessWidget {
  TextDropDownWidget({
    this.function,
    this.value,
    this.hintText,
    required this.list,
  });

  final function;
  final value;
  final hintText;
  List list;

  @override
  Widget build(BuildContext context) {
    print(list);
    print(list[0].code);
    return Container(
      alignment: Alignment.center,
      decoration: BoxDecoration(color: AppTheme.grey_thin.withOpacity(0.3), borderRadius: BorderRadius.circular(3)),
      child: DropdownButtonFormField(
        focusNode: FocusNode(canRequestFocus: false),
        value: value,
        onChanged: function,
        items: list.map((e) => DropdownMenuItem(value: e.id, child: Text(e.code.toString()))).toList(),
        decoration: InputDecoration(
          hintText: hintText,
          contentPadding: EdgeInsets.symmetric(horizontal: 12,vertical: 0),
          border: InputBorder.none,
        ),
      ),
    );
  }
}

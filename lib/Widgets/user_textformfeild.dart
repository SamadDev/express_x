import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:x_express/Theme/style.dart';

enum CustomTextFieldValidator { nullCheck, phoneNumber, email, password, maxFifty }

class CustomUserTextFormField extends StatelessWidget {
  final String? hintText;
  final String? type;
  final TextEditingController? controller;
  final int? minLine;
  final int? maxLine;
  final String currency;
  final bool? isReadOnly;
  final List<TextInputFormatter>? formaters;
  final CustomTextFieldValidator? validator;
  final Color? fillColor;
  final Function(dynamic value)? onChange;
  final Widget? prefix;
  final TextInputAction? action;
  final TextInputType? keyboard;
  final Widget? suffix;
  final bool? dense;
  const CustomUserTextFormField({
    Key? key,
    this.hintText,
    this.currency = '',
    this.controller,
    this.minLine,
    this.maxLine,
    this.formaters,
    this.isReadOnly,
    this.validator,
    this.fillColor,
    this.onChange,
    this.prefix,
    this.keyboard,
    this.action,
    this.suffix,
    this.dense,
    this.type,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      inputFormatters:
          currency == "currency" ? [CurrencyTextInputFormatter.currency(symbol: "", decimalDigits: 2)] : formaters,
      textInputAction: action,
      keyboardAppearance: Brightness.light,
      readOnly: isReadOnly ?? false,
      style: TextStyle(fontSize: 22,fontFamily: "nrt-reg"),
      minLines: minLine ?? 1,
      maxLines: maxLine ?? 1,
      onChanged: onChange,
      keyboardType: keyboard,
      decoration: InputDecoration(
          prefix: prefix,
          isDense: dense,
          suffixIcon: suffix,
          hintText: hintText,
          hintStyle: TextStyle(color: AppTheme.black.withOpacity(0.7), fontSize: 22),
          filled: true,
          fillColor: fillColor,
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(width: 1.5, color: AppTheme.primary), borderRadius: BorderRadius.circular(4)),
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(width: 1.5, color: AppTheme.grey), borderRadius: BorderRadius.circular(4)),
          border: OutlineInputBorder(
              borderSide: BorderSide(width: 1.5, color: AppTheme.grey), borderRadius: BorderRadius.circular(4))),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:x_express/core/config/theme/color.dart';
import 'package:x_express/core/config/widgets/globalText.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomDropDownFormField extends StatelessWidget {
  const CustomDropDownFormField({
    super.key,
    this.alignment,
    this.width,
    this.controller,
    this.focusNode,
    this.onChange,
    this.autofocus = true,
    this.textStyle,
    this.obscureText = false,
    this.textInputAction = TextInputAction.next,
    this.textInputType = TextInputType.text,
    this.maxLines,
    this.hintText,
    this.hintStyle,
    this.prefix,
    this.verticalPadding = 0.0,
    this.prefixConstraints,
    this.suffix,
    this.isRequired = false,
    this.suffixConstraints,
    this.contentPadding,
    this.borderDecoration,
    this.fillColor,
    this.filled = true,
    this.borderType = false,
    this.validator,
    this.items,
    this.value,
    this.title,
    this.onFieldSubmit,
    this.enabled = true,
    this.onTap,
  });

  final Alignment? alignment;

  final double? width;

  final onFieldSubmit;
  final onChange;
  final items;

  final TextEditingController? controller;

  final FocusNode? focusNode;

  final double? verticalPadding;
  final bool? autofocus;

  final TextStyle? textStyle;

  final bool? obscureText;

  final TextInputAction? textInputAction;

  final TextInputType? textInputType;

  final int? maxLines;
  final String? title;
  final bool? borderType;

  final bool isRequired;
  final String? hintText;

  final TextStyle? hintStyle;

  final Widget? prefix;
  final value;

  final BoxConstraints? prefixConstraints;

  final Widget? suffix;

  final BoxConstraints? suffixConstraints;

  final EdgeInsets? contentPadding;

  final InputBorder? borderDecoration;

  final Color? fillColor;

  final bool? enabled;
  final onTap;
  final bool? filled;

  final validator;

  @override
  Widget build(BuildContext context) {
    return alignment != null
        ? Align(
            alignment: alignment ?? Alignment.center,
            child: textFormFieldWidget(context),
          )
        : textFormFieldWidget(context);
  }

  Widget textFormFieldWidget(BuildContext context) => Padding(
        padding: EdgeInsets.symmetric(vertical: verticalPadding ?? 0.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (title != null) ...[
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5.0),
                child: Row(
                  children: [
                    GlobalText(
                      title ?? "",
                      fontWeight: FontWeight.w500,
                      color: kLightTitle,
                    ),
                    SizedBox(width: 6),
                    isRequired
                        ? Icon(Icons.star, color: kLightError, size: 10)
                        : SizedBox.shrink()
                  ],
                ),
              ),
              SizedBox(height: 6),
            ],
            SizedBox(
              height: 58,
              child: DropdownButtonFormField(
                validator: validator,
                value: value,
                onChanged: onChange,
                onTap: onTap,
                autofocus: false,
                style: TextTheme.of(context).bodyLarge,
                decoration: decoration,
                items: items,
              ),
            ),
          ],
        ),
      );
  InputDecoration get decoration => InputDecoration(
        prefix: prefix,
        suffixIcon: suffix,
        hintText: hintText,
        hintStyle: GoogleFonts.inter(
          fontSize: 12,
          color: kLightPlatinum300,
          fontWeight: FontWeight.w400,
        ),
        filled: true,
        fillColor: fillColor ?? kLightFill,
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(width: 1, color: kLightPrimary),
          borderRadius: BorderRadius.circular(12),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(width: 1, color: kLightStroke),
          borderRadius: BorderRadius.circular(12),
        ),
        border: OutlineInputBorder(
          borderSide: BorderSide(width: 1, color: kLightStroke),
          borderRadius: BorderRadius.circular(12),
        ),
      );
}

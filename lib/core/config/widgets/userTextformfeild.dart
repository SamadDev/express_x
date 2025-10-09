import 'package:flutter/material.dart';
import 'package:x_express/core/config/theme/color.dart';
import 'package:x_express/core/config/widgets/globalText.dart';
import 'package:google_fonts/google_fonts.dart';


class CustomUserTextFormField extends StatelessWidget {
  final String? hintText;
  final String? type;
  final double? verticalPadding;
  final TextEditingController? controller;
  final int? minLine;
  final String? title;
  final int? maxLine;
  final String currency;
  final bool isRequired;
  final bool obscureText;
  final bool isReadOnly;
  final Function()? onTap;
  final  validator;
  final Color? fillColor;
  final Function(dynamic value)? onChange;
  final Widget? prefix;
  final TextInputAction? action;
  final TextInputType? keyboard;
  final Widget? suffix;
  final bool? dense;
  const CustomUserTextFormField({
    super.key,
    this.hintText,
    this.currency = '',
    this.controller,
    this.minLine,
    this.title = '',
    this.maxLine,
    this.onTap,
    this.isReadOnly=false,
    this.verticalPadding,
    this.validator,
    this.fillColor,
    this.isRequired = false,
    this.obscureText = false,
    this.onChange,
    this.prefix,
    this.keyboard,
    this.action,
    this.suffix,
    this.dense,
    this.type,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
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
                  isRequired ? Icon(Icons.star, color: kLightError, size: 10) : SizedBox.shrink()
                ],
              ),
            ),
            SizedBox(height: 6),
          ],
          TextFormField(
            validator: validator,
            onTap: onTap,
            controller: controller,
            textInputAction: action,
            keyboardAppearance: Brightness.light,
            readOnly: isReadOnly ?? false,
            style: TextTheme.of(context).bodyLarge,
            minLines: minLine ?? 1,
            maxLines: maxLine ?? 1,
            onChanged: onChange,
            keyboardType: keyboard,
            obscureText: obscureText,
            decoration: InputDecoration(
              prefix: prefix,
              isDense: dense,
              suffixIcon: suffix,
              hintText: hintText,
              hintStyle: GoogleFonts.inter(
                fontSize: 12,
                color: kLightPlatinum300,
                fontWeight: FontWeight.w400,
              ),
              filled: true,
              fillColor: fillColor ?? kLightFill,
              focusedBorder:isReadOnly?OutlineInputBorder(
                borderSide: BorderSide(width: 1, color: kLightStroke),
                borderRadius: BorderRadius.circular(12),
              ): OutlineInputBorder(
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
            ),
          ),
        ],
      ),
    );
  }
}

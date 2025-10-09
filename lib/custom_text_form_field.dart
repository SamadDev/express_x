
import 'package:flutter/material.dart';
import 'package:x_express/core/config/widgets/globalText.dart';


class CustomTextFormField extends StatelessWidget {
  CustomTextFormField({
    Key? key,
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
    this.title,
    this.onFieldSubmit,
    this.enabled = true,
    this.onTap,
  }) : super(
          key: key,
        );

  final Alignment? alignment;

  final double? width;

  final onFieldSubmit;
  final onChange;

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

  final BoxConstraints? prefixConstraints;

  final Widget? suffix;

  final BoxConstraints? suffixConstraints;

  final EdgeInsets? contentPadding;

  final InputBorder? borderDecoration;

  final Color? fillColor;

  final bool? enabled;
  final onTap;
  final bool? filled;

  final FormFieldValidator<String>? validator;

  @override
  Widget build(BuildContext context) {
    return alignment != null
        ? Align(
            alignment: alignment ?? Alignment.center,
            child: textFormFieldWidget(context),
          )
        : textFormFieldWidget(context);
  }

  Widget textFormFieldWidget(BuildContext context) => SizedBox(
        width: width ?? double.maxFinite,
        child: Padding(
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
                        maxLines: 1,
                        fontSize: 13,
                        fontFamily: 'nrt-reg',
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
                      ),
                      SizedBox(width: 6),
                      isRequired ? Icon(Icons.star, color: Colors.red, size: 10) : SizedBox.shrink()
                    ],
                  ),
                ),
                SizedBox(height: 5),
              ],
              SizedBox(
                child: TextFormField(
                  onChanged: onChange,
                  onTap: onTap,
                  controller: controller,
                  onFieldSubmitted: onFieldSubmit,
                  // focusNode: focusNode ?? FocusNode(),
                  autofocus: false,
                  autocorrect: false,

                  style: textStyle ??
                      TextStyle(
                        color: Color(0XFF131313),
                        fontSize: 13,
                        fontFamily: 'nrt-reg',
                        fontWeight: FontWeight.w500,
                      ),
                  enabled: enabled,
                  obscureText: obscureText!,
                  textInputAction: textInputAction,
                  keyboardType: textInputType,
                  maxLines: maxLines ?? 1,
                  decoration: decoration,
                  validator: validator,
                ),
              ),
            ],
          ),
        ),
      );
  InputDecoration get decoration => InputDecoration(
        hintText: hintText ?? "",
        hintStyle: hintStyle ??
            TextStyle(
              color: Color(0XFF666666),
              fontSize: 13,
            ),
        prefixIcon: prefix,
        prefixIconConstraints: prefixConstraints,
        suffixIcon: suffix,
        suffixIconConstraints: suffixConstraints,
        // isDense: true,
        contentPadding: contentPadding ??
            EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 14,
            ),
        fillColor: fillColor ?? Colors.white,
        filled: filled,

        border: borderDecoration ??
            OutlineInputBorder(
              borderRadius: BorderRadius.circular(6),
              borderSide: BorderSide(color: Colors.grey.withOpacity(0.5), width: 20),
            ),
        enabledBorder: borderDecoration ??
            OutlineInputBorder(
              borderRadius: BorderRadius.circular(6),
              borderSide: borderType! ? BorderSide(color: Colors.grey.withOpacity(0.5)) : BorderSide.none,
            ),
        focusedBorder: borderDecoration ??
            OutlineInputBorder(
              borderRadius: BorderRadius.circular(6),
              borderSide: borderType! ? BorderSide(color: Colors.deepPurpleAccent.withOpacity(0.5)) : BorderSide.none,
            ),
      );
}

class TextFormFieldWidget extends StatelessWidget {
  final controller;
  final obscureText;
  final hintText;
  final buttonPrefix;
  final buttonPostfix;
  final textInputAction;
  final textInputType;
  final formValidator;
  final inputFormatters;
  final onEditingComplte;

  TextFormFieldWidget({
    this.hintText,
    this.controller,
    this.textInputAction,
    this.textInputType,
    this.obscureText = false,
    this.buttonPostfix,
    this.buttonPrefix,
    this.formValidator,
    this.inputFormatters,
    this.onEditingComplte,
  });

  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.only(right: 10, left: 10),
        margin: EdgeInsets.only(top: 10),
        height: 70,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(3), color: Colors.grey.shade100),
        child: Row(
          children: [
            buttonPrefix ?? SizedBox(),
            Expanded(
              child: TextFormField(
                onEditingComplete: onEditingComplte,
                inputFormatters: inputFormatters,
                controller: controller,
                validator: formValidator,
                textInputAction: textInputAction,
                keyboardType: textInputType,
                style: TextStyle(color: Colors.grey, fontSize: 18, fontFamily: "nrt-reg"),
                maxLines: 1,
                obscureText: obscureText,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.only(top: 5),
                  hintText: hintText,
                  hintStyle: TextStyle(color: Colors.black, fontSize: 18, fontFamily: "nrt-reg"),
                  border: InputBorder.none,
                ),
              ),
            ),
            buttonPostfix ?? SizedBox(),
          ],
        ));
  }
}

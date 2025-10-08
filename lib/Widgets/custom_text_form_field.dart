import 'package:x_express/Utils/exports.dart';
import 'package:phone_form_field/phone_form_field.dart';

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
    void Function(dynamic _)? onFieldSubmitted,
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
                        text: title ?? "",
                        maxLines: 1,
                        fontSize: 13,
                        fontFamily: 'nrt-reg',
                        fontWeight: FontWeight.w500,
                        color: AppTheme.black,
                      ),
                      SizedBox(width: 6),
                      isRequired ? Icon(Icons.star, color: AppTheme.red, size: 10) : SizedBox.shrink()
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
                  onFieldSubmitted: onFieldSubmit ?? null,
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
        fillColor: fillColor ?? AppTheme.white,
        filled: filled,

        border: borderDecoration ??
            OutlineInputBorder(
              borderRadius: BorderRadius.circular(6),
              borderSide: BorderSide(color: AppTheme.grey_between.withOpacity(0.5), width: 20),
            ),
        enabledBorder: borderDecoration ??
            OutlineInputBorder(
              borderRadius: BorderRadius.circular(6),
              borderSide: borderType! ? BorderSide(color: AppTheme.grey_between.withOpacity(0.5)) : BorderSide.none,
            ),
        focusedBorder: borderDecoration ??
            OutlineInputBorder(
              borderRadius: BorderRadius.circular(6),
              borderSide: borderType! ? BorderSide(color: AppTheme.primary.withOpacity(0.5)) : BorderSide.none,
            ),
      );
}

class CustomPhoneFormField extends StatelessWidget {
  CustomPhoneFormField({
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
    void Function(dynamic _)? onFieldSubmitted,
  }) : super(
          key: key,
        );

  final Alignment? alignment;

  final double? width;

  final onFieldSubmit;
  final onChange;

  final PhoneController? controller;

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
                        text: title ?? "",
                        maxLines: 1,
                        fontSize: 13,
                        fontFamily: 'nrt-reg',
                        fontWeight: FontWeight.w500,
                        color: AppTheme.black,
                      ),
                      SizedBox(width: 6),
                      isRequired ? Icon(Icons.star, color: AppTheme.red, size: 10) : SizedBox.shrink()
                    ],
                  ),
                ),
                SizedBox(height: 5),
              ],
              SizedBox(
                child: PhoneFormField(
                  onChanged: onChange,
                  controller: controller,
                  autofocus: false,
                  autocorrect: false,
                  countryCodeStyle: TextStyle(
                    color: Color(0XFF131313),
                    fontFamily: "nrt-reg",
                    fontWeight: FontWeight.w400,
                    fontSize: 14,
                    letterSpacing: 1.2,
                  ),
                  defaultCountry: IsoCode.IQ,
                  style: textStyle ??
                      TextStyle(
                        color: Color(0XFF131313),
                        fontSize: 14,
                        fontFamily: 'nrt-reg',
                        fontWeight: FontWeight.w500,
                      ),
                  obscureText: obscureText!,
                  textInputAction: textInputAction,
                  decoration: decoration,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  keyboardType: TextInputType.phone,
                  validator: PhoneValidator.validMobile(),
                  showFlagInInput: false,
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
        fillColor: fillColor ?? AppTheme.white,
        filled: filled,

        border: borderDecoration ??
            OutlineInputBorder(
              borderRadius: BorderRadius.circular(6),
              borderSide: BorderSide(color: AppTheme.grey_between.withOpacity(0.5), width: 20),
            ),
        enabledBorder: borderDecoration ??
            OutlineInputBorder(
              borderRadius: BorderRadius.circular(6),
              borderSide: borderType! ? BorderSide(color: AppTheme.grey_between.withOpacity(0.5)) : BorderSide.none,
            ),
        focusedBorder: borderDecoration ??
            OutlineInputBorder(
              borderRadius: BorderRadius.circular(6),
              borderSide: borderType! ? BorderSide(color: AppTheme.primary.withOpacity(0.5)) : BorderSide.none,
            ),
      );
}

class CustomSearchFormField extends StatelessWidget {
  CustomSearchFormField({
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
          child: SizedBox(
            height: 46,
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
                    fontSize: 18,
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
        ),
      );
  InputDecoration get decoration => InputDecoration(
        hintText: hintText ?? "",
        hintStyle: TextStyle(
            color: Color(0xff64748B),
            fontFamily: "nrt-reg",
            fontWeight: FontWeight.w400,
            fontSize: 14,
            letterSpacing: 1.2),

        suffixIcon: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Image.asset(
            'assets/images/search.png',
            width: 22,
            height: 22,
          ),
        ),
        suffixIconConstraints: BoxConstraints(minHeight: 22, minWidth: 22),
        // isDense: true,
        contentPadding: EdgeInsets.symmetric(horizontal: 12),
        fillColor: fillColor ?? AppTheme.white,
        filled: filled,

        border: borderDecoration ??
            OutlineInputBorder(
              borderRadius: BorderRadius.circular(6),
              borderSide: BorderSide(color: AppTheme.white.withOpacity(0.3), width: 20),
            ),
        enabledBorder: borderDecoration ??
            OutlineInputBorder(
              borderRadius: BorderRadius.circular(6),
              borderSide: true ? BorderSide(color: AppTheme.white.withOpacity(0.3)) : BorderSide.none,
            ),
        focusedBorder: borderDecoration ??
            OutlineInputBorder(
              borderRadius: BorderRadius.circular(6),
              borderSide: true ? BorderSide(color: AppTheme.white.withOpacity(0.3)) : BorderSide.none,
            ),
      );
}

class CustomDropDownFormField extends StatelessWidget {
  CustomDropDownFormField({
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
    this.items,
    this.value,
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
                        text: title ?? "",
                        maxLines: 1,
                        fontSize: 13,
                        fontFamily: 'nrt-reg',
                        fontWeight: FontWeight.w500,
                        color: AppTheme.black,
                      ),
                      SizedBox(width: 6),
                      isRequired ? Icon(Icons.star, color: AppTheme.red, size: 10) : SizedBox.shrink()
                    ],
                  ),
                ),
                SizedBox(height: 5),
              ],
              DropdownButtonFormField(
                value: value,
                onChanged: onChange,
                onTap: onTap,
                // focusNode: focusNode ?? FocusNode(),
                autofocus: false,

                style: textStyle ??
                    TextStyle(
                      color: Color(0XFF131313),
                      fontSize: 13,
                      fontFamily: 'nrt-reg',
                      fontWeight: FontWeight.w500,
                    ),
                decoration: decoration,
                items: items,
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
              fontSize: 15,
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
        fillColor: fillColor ?? AppTheme.white,
        filled: filled,

        border: borderDecoration ??
            OutlineInputBorder(
              borderRadius: BorderRadius.circular(6),
              borderSide: BorderSide(color: AppTheme.grey_between.withOpacity(0.5), width: 20),
            ),
        enabledBorder: borderDecoration ??
            OutlineInputBorder(
              borderRadius: BorderRadius.circular(6),
              borderSide: borderType! ? BorderSide(color: AppTheme.grey_between.withOpacity(0.5)) : BorderSide.none,
            ),
        focusedBorder: borderDecoration ??
            OutlineInputBorder(
              borderRadius: BorderRadius.circular(6),
              borderSide: borderType! ? BorderSide(color: AppTheme.primary.withOpacity(0.5)) : BorderSide.none,
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
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(3), color: AppTheme.card),
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
                style: TextStyle(color: AppTheme.grey, fontSize: 18, fontFamily: "nrt-reg"),
                maxLines: 1,
                obscureText: obscureText,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.only(top: 5),
                  hintText: hintText,
                  hintStyle: TextStyle(color: AppTheme.black, fontSize: 18, fontFamily: "nrt-reg"),
                  border: InputBorder.none,
                ),
              ),
            ),
            buttonPostfix ?? SizedBox(),
          ],
        ));
  }
}

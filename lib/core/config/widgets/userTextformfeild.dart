import 'package:flutter/material.dart';
import 'package:x_express/core/config/theme/color.dart';
import 'package:x_express/core/config/widgets/globalText.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomUserTextFormField extends StatefulWidget {
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
  final validator;
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
    this.isReadOnly = false,
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
  State<CustomUserTextFormField> createState() => _CustomUserTextFormFieldState();
}

class _CustomUserTextFormFieldState extends State<CustomUserTextFormField> {
  final FocusNode _focusNode = FocusNode();
  bool _isFocused = false;

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(_onFocusChange);
  }

  void _onFocusChange() {
    setState(() {
      _isFocused = _focusNode.hasFocus;
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: widget.verticalPadding ?? 0.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (widget.title != null) ...[
            GlobalText(
              widget.title ?? "",
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: kLightPlatinum300,
            ),
            const SizedBox(height: 8),
          ],
          TextFormField(
            validator: widget.validator,
            onTap: widget.onTap,
            controller: widget.controller,
            focusNode: _focusNode,
            textInputAction: widget.action,
            keyboardAppearance: Brightness.light,
            readOnly: widget.isReadOnly ?? false,
            style: TextTheme.of(context).bodyLarge,
            minLines: widget.minLine ?? 1,
            maxLines: widget.maxLine ?? 1,
            onChanged: widget.onChange,
            keyboardType: widget.keyboard,
            obscureText: widget.obscureText,
            decoration: InputDecoration(
              prefix: widget.prefix,
              isDense: widget.dense,
              suffixIcon: widget.suffix,
              hintText: widget.hintText,
              hintStyle: TextStyle(color: kLightPlatinum300, fontSize: 14, fontWeight: FontWeight.w400),
              filled: true,
              fillColor: widget.fillColor ?? (_isFocused ? Colors.white : const Color(0xFFF2F5FF)),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(width: 1, color: kLightPrimary),
                borderRadius: BorderRadius.circular(12),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.circular(12),
              ),
              border: OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.circular(12),
              ),
              contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            ),
          ),
        ],
      ),
    );
  }
}

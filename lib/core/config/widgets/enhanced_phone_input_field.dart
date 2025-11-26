import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:x_express/core/config/theme/color.dart';
import 'package:x_express/core/config/widgets/globalText.dart';

/// Enhanced phone input field using intl_phone_field package
/// Provides better formatting, validation, and country selection
class EnhancedPhoneInputField extends StatefulWidget {
  final String? label;
  final String? hintText;
  final String? initialCountryCode;
  final String? initialPhoneNumber;
  final Function(PhoneNumber phoneNumber)? onChanged;
  final String? Function(PhoneNumber?)? validator;
  final bool enabled;
  final bool readOnly;
  final EdgeInsetsGeometry? contentPadding;
  final double? borderRadius;

  const EnhancedPhoneInputField({
    super.key,
    this.label,
    this.hintText,
    this.initialCountryCode,
    this.initialPhoneNumber,
    this.onChanged,
    this.validator,
    this.enabled = true,
    this.readOnly = false,
    this.contentPadding,
    this.borderRadius,
  });

  @override
  State<EnhancedPhoneInputField> createState() =>
      _EnhancedPhoneInputFieldState();
}

class _EnhancedPhoneInputFieldState extends State<EnhancedPhoneInputField> {
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
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.label != null) ...[
          GlobalText(
            widget.label ?? "",
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: kLightPlatinum300,
          ),
          const SizedBox(height: 8),
        ],
        Container(
          decoration: BoxDecoration(
            color: _isFocused ? Colors.white : const Color(0xFFF2F5FF),
            borderRadius: BorderRadius.circular(widget.borderRadius ?? 12),
            border: Border.all(
              color: _isFocused ? kLightPrimary : Colors.transparent,
              width: _isFocused ? 1 : 0,
            ),
          ),
          child: IntlPhoneField(
            focusNode: _focusNode,
            initialCountryCode: widget.initialCountryCode ?? 'IQ',
            initialValue: widget.initialPhoneNumber,
            enabled: widget.enabled,
            readOnly: widget.readOnly,
            decoration: InputDecoration(
              hintText: widget.hintText ?? "Enter phone number",
              hintStyle: TextStyle(
                color: kLightPlatinum300,
                fontSize: 14,
                fontWeight: FontWeight.w400,
              ),
              border: InputBorder.none,
              contentPadding: widget.contentPadding ??
                  const EdgeInsets.fromLTRB(16, 16, 16, 16),
              counterText: '', // Hide character counter
            ),
            style: TextStyle(
              color: kLightTitle,
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
            dropdownTextStyle: TextStyle(
              color: kLightTitle,
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
            dropdownIcon: Icon(
              Icons.keyboard_arrow_down,
              color: kLightPlatinum500,
              size: 20,
            ),
            flagsButtonPadding: const EdgeInsets.only(left: 8),
            onChanged: (phone) {
              final phoneNumber = PhoneNumber(
                countryCode: phone.countryCode,
                countryISOCode: phone.countryISOCode,
                number: phone.number,
                completeNumber: phone.completeNumber,
              );
              widget.onChanged?.call(phoneNumber);
            },
            validator: (phone) {
              if (phone == null || phone.number.isEmpty) {
                return 'Please enter a phone number';
              }
              return null;
            },
            keyboardType: TextInputType.phone,
            inputFormatters: const [],
            disableLengthCheck: false,
            showDropdownIcon: true,
            showCountryFlag: true,
            searchText: "Search countries",
            invalidNumberMessage: "Invalid phone number",
          ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }
}

/// Phone number model class
class PhoneNumber {
  final String countryCode;
  final String countryISOCode;
  final String number;
  final String completeNumber;

  PhoneNumber({
    required this.countryCode,
    required this.countryISOCode,
    required this.number,
    required this.completeNumber,
  });

  @override
  String toString() {
    return completeNumber;
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is PhoneNumber &&
        other.countryCode == countryCode &&
        other.countryISOCode == countryISOCode &&
        other.number == number &&
        other.completeNumber == completeNumber;
  }

  @override
  int get hashCode {
    return countryCode.hashCode ^
        countryISOCode.hashCode ^
        number.hashCode ^
        completeNumber.hashCode;
  }
}

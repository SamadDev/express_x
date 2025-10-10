import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:x_express/core/config/theme/color.dart';
import 'package:x_express/core/config/widgets/globalText.dart';
import 'package:x_express/core/config/utitls/phone_formatter.dart';

class PhoneInputField extends StatefulWidget {
  final String? label;
  final String? hintText;
  final String? initialCountry;
  final String? initialPhone;
  final Function(String phone, String countryCode)? onChanged;
  final String? Function(String?)? validator;

  const PhoneInputField({
    super.key,
    this.label,
    this.hintText,
    this.initialCountry,
    this.initialPhone,
    this.onChanged,
    this.validator,
  });

  @override
  State<PhoneInputField> createState() => _PhoneInputFieldState();
}

class _PhoneInputFieldState extends State<PhoneInputField> {
  final TextEditingController _phoneController = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  String _selectedCountry = 'IQ';
  String _selectedCountryCode = '+964';
  bool _isValid = false;
  bool _isFocused = false;

  final Map<String, Map<String, String>> _countries = {
    'IQ': {'code': '+964', 'name': 'Iraq'},
    'JO': {'code': '+962', 'name': 'Jordan'},
    'LB': {'code': '+961', 'name': 'Lebanon'},
    'SY': {'code': '+963', 'name': 'Syria'},
    'TR': {'code': '+90', 'name': 'Turkey'},
    'IR': {'code': '+98', 'name': 'Iran'},
    'KW': {'code': '+965', 'name': 'Kuwait'},
    'QA': {'code': '+974', 'name': 'Qatar'},
    'BH': {'code': '+973', 'name': 'Bahrain'},
    'OM': {'code': '+968', 'name': 'Oman'},
    'US': {'code': '+1', 'name': 'United States'},
    'UK': {'code': '+44', 'name': 'United Kingdom'},
    'CA': {'code': '+1', 'name': 'Canada'},
    'AU': {'code': '+61', 'name': 'Australia'},
    'DE': {'code': '+49', 'name': 'Germany'},
    'FR': {'code': '+33', 'name': 'France'},
    'IT': {'code': '+39', 'name': 'Italy'},
    'ES': {'code': '+34', 'name': 'Spain'},
    'JP': {'code': '+81', 'name': 'Japan'},
    'KR': {'code': '+82', 'name': 'South Korea'},
    'CN': {'code': '+86', 'name': 'China'},
    'IN': {'code': '+91', 'name': 'India'},
    'BR': {'code': '+55', 'name': 'Brazil'},
    'MX': {'code': '+52', 'name': 'Mexico'},
    'RU': {'code': '+7', 'name': 'Russia'},
    'SA': {'code': '+966', 'name': 'Saudi Arabia'},
    'AE': {'code': '+971', 'name': 'United Arab Emirates'},
    'EG': {'code': '+20', 'name': 'Egypt'},
    'ZA': {'code': '+27', 'name': 'South Africa'},
    'NG': {'code': '+234', 'name': 'Nigeria'},
    'KE': {'code': '+254', 'name': 'Kenya'},
  };

  final Map<String, String> _countryFlags = {
    'US': '🇺🇸',
    'UK': '🇬🇧',
    'CA': '🇨🇦',
    'AU': '🇦🇺',
    'DE': '🇩🇪',
    'FR': '🇫🇷',
    'IT': '🇮🇹',
    'ES': '🇪🇸',
    'JP': '🇯🇵',
    'KR': '🇰🇷',
    'CN': '🇨🇳',
    'IN': '🇮🇳',
    'BR': '🇧🇷',
    'MX': '🇲🇽',
    'RU': '🇷🇺',
    'SA': '🇸🇦',
    'AE': '🇦🇪',
    'EG': '🇪🇬',
    'ZA': '🇿🇦',
    'NG': '🇳🇬',
    'KE': '🇰🇪',
    'IQ': '🇮🇶',
    'JO': '🇯🇴',
    'LB': '🇱🇧',
    'SY': '🇸🇾',
    'TR': '🇹🇷',
    'IR': '🇮🇷',
    'KW': '🇰🇼',
    'QA': '🇶🇦',
    'BH': '🇧🇭',
    'OM': '🇴🇲',
  };

  @override
  void initState() {
    super.initState();
    if (widget.initialCountry != null && _countries.containsKey(widget.initialCountry)) {
      _selectedCountry = widget.initialCountry!;
      _selectedCountryCode = _countries[widget.initialCountry!]!['code']!;
    } else {
      _selectedCountry = 'IQ';
      _selectedCountryCode = _countries['IQ']!['code']!;
    }
    if (widget.initialPhone != null) {
      _phoneController.text = widget.initialPhone!;
    }
    _focusNode.addListener(_onFocusChange);
    _validatePhone();
  }

  void _onFocusChange() {
    setState(() {
      _isFocused = _focusNode.hasFocus;
    });
  }

  void _validatePhone() {
    String phone = _phoneController.text;
    bool isValid = PhoneFormatter.isValidPhoneNumber(phone, _selectedCountryCode);

    if (_isValid != isValid) {
      setState(() {
        _isValid = isValid;
      });
    }

    widget.onChanged?.call(_phoneController.text, _selectedCountryCode);
  }

  String _formatPhoneNumber(String phone) {
    return PhoneFormatter.formatPhoneNumber(phone, _selectedCountryCode);
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
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: _isFocused ? kLightPrimary : Colors.transparent,
              width: _isFocused ? 1 : 0,
            ),
          ),
          child: Row(
            children: [
              GestureDetector(
                onTap: () => _showCountryPicker(context),
                child: Container(
                  padding: const EdgeInsets.fromLTRB(12, 16, 4, 16),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      GlobalText(
                        _selectedCountryCode,
                        fontSize: 14,
                        color: kLightTitle,
                        fontWeight: FontWeight.w500,
                      ),
                      const SizedBox(width: 4),
                      Icon(
                        Icons.keyboard_arrow_down,
                        color: kLightPlatinum500,
                        size: 20,
                      ),
                    ],
                  ),
                ),
              ),

              Expanded(
                child: TextFormField(
                  controller: _phoneController,
                  focusNode: _focusNode,
                  keyboardType: TextInputType.phone,
                  inputFormatters: PhoneFormatter.getInputFormatters(_selectedCountryCode),
                  onChanged: (value) {
                    String formatted = _formatPhoneNumber(value);
                    if (formatted != value) {
                      _phoneController.value = TextEditingValue(
                        text: formatted,
                        selection: TextSelection.collapsed(offset: formatted.length),
                      );
                    }
                    _validatePhone();
                  },
                  decoration: InputDecoration(
                    hintText: "750",
                    hintStyle: TextStyle(color: kLightPlatinum300, fontSize: 14, fontWeight: FontWeight.w400),
                    border: InputBorder.none,
                    contentPadding: const EdgeInsets.fromLTRB(4, 16, 12, 16),
                  ),
                  style: TextStyle(
                    color: kLightTitle,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),

              // Validation icon
              if (_phoneController.text.isNotEmpty)
                Container(
                  padding: const EdgeInsets.only(right: 12),
                  child: Icon(
                    _isValid ? Icons.check_circle : Icons.error,
                    color: _isValid ? kLightPrimary : kLightError,
                    size: 20,
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }

  void _showCountryPicker(BuildContext context) {
    final TextEditingController searchController = TextEditingController();
    List<String> filteredCountries = _countries.keys.toList();

    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => StatefulBuilder(
        builder: (context, setModalState) {
          return Container(
            height: 500,
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                GlobalText(
                  "Select Country",
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: kLightTitle,
                ),
                const SizedBox(height: 16),

                // Search field
                Container(
                  decoration: BoxDecoration(
                    color: const Color(0xFFF2F5FF),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: TextField(
                    controller: searchController,
                    onChanged: (value) {
                      setModalState(() {
                        filteredCountries = _countries.keys
                            .where(
                                (country) => _countries[country]!['name']!.toLowerCase().contains(value.toLowerCase()))
                            .toList();
                      });
                    },
                    decoration: InputDecoration(
                      hintText: "Search countries...",
                      hintStyle: TextStyle(
                        color: kLightPlatinum400,
                        fontSize: 14,
                      ),
                      prefixIcon: Icon(
                        Icons.search,
                        color: kLightPlatinum500,
                        size: 20,
                      ),
                      border: InputBorder.none,
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 12,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 16),

                Expanded(
                  child: ListView.builder(
                    itemCount: filteredCountries.length,
                    itemBuilder: (context, index) {
                      String country = filteredCountries[index];
                      String code = _countries[country]!['code']!;
                      String name = _countries[country]!['name']!;
                      bool isSelected = country == _selectedCountry;

                      return ListTile(
                        leading: Text(
                          _countryFlags[country] ?? '🇺🇸',
                          style: const TextStyle(fontSize: 24),
                        ),
                        title: GlobalText(
                          name,
                          fontSize: 16,
                          color: kLightTitle,
                          fontWeight: FontWeight.w500,
                        ),
                        trailing: GlobalText(
                          code,
                          fontSize: 14,
                          color: kLightPlatinum500,
                        ),
                        selected: isSelected,
                        selectedTileColor: kLightPrimary.withOpacity(0.1),
                        onTap: () {
                          setState(() {
                            _selectedCountry = country;
                            _selectedCountryCode = code;
                          });
                          _validatePhone();
                          Navigator.pop(context);
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    _phoneController.dispose();
    _focusNode.dispose();
    super.dispose();
  }
}

import 'package:flutter/services.dart';

/// A utility class for formatting phone numbers according to different country formats
class PhoneFormatter {
  /// Formats phone number based on country code and local format
  static String formatPhoneNumber(String phoneNumber, String countryCode) {
    // Remove all non-digit characters
    String digits = phoneNumber.replaceAll(RegExp(r'[^\d]'), '');

    // Handle different country formats
    switch (countryCode) {
      case '+1': // US/Canada
        return _formatUSCanada(digits);
      case '+44': // UK
        return _formatUK(digits);
      case '+49': // Germany
        return _formatGermany(digits);
      case '+33': // France
        return _formatFrance(digits);
      case '+39': // Italy
        return _formatItaly(digits);
      case '+34': // Spain
        return _formatSpain(digits);
      case '+81': // Japan
        return _formatJapan(digits);
      case '+82': // South Korea
        return _formatSouthKorea(digits);
      case '+86': // China
        return _formatChina(digits);
      case '+91': // India
        return _formatIndia(digits);
      case '+55': // Brazil
        return _formatBrazil(digits);
      case '+52': // Mexico
        return _formatMexico(digits);
      case '+7': // Russia
        return _formatRussia(digits);
      case '+966': // Saudi Arabia
        return _formatSaudiArabia(digits);
      case '+971': // UAE
        return _formatUAE(digits);
      case '+20': // Egypt
        return _formatEgypt(digits);
      case '+964': // Iraq
        return _formatIraq(digits);
      case '+962': // Jordan
        return _formatJordan(digits);
      case '+961': // Lebanon
        return _formatLebanon(digits);
      case '+963': // Syria
        return _formatSyria(digits);
      case '+90': // Turkey
        return _formatTurkey(digits);
      case '+98': // Iran
        return _formatIran(digits);
      case '+965': // Kuwait
        return _formatKuwait(digits);
      case '+974': // Qatar
        return _formatQatar(digits);
      case '+973': // Bahrain
        return _formatBahrain(digits);
      case '+968': // Oman
        return _formatOman(digits);
      case '+61': // Australia
        return _formatAustralia(digits);
      case '+27': // South Africa
        return _formatSouthAfrica(digits);
      case '+234': // Nigeria
        return _formatNigeria(digits);
      case '+254': // Kenya
        return _formatKenya(digits);
      default:
        return _formatDefault(digits);
    }
  }

  // US/Canada format: (XXX) XXX-XXXX
  static String _formatUSCanada(String digits) {
    if (digits.length <= 3) return digits;
    if (digits.length <= 6) {
      return '(${digits.substring(0, 3)}) ${digits.substring(3)}';
    }
    return '(${digits.substring(0, 3)}) ${digits.substring(3, 6)}-${digits.substring(6, 10)}';
  }

  // UK format: XXXX XXX XXXX
  static String _formatUK(String digits) {
    if (digits.length <= 4) return digits;
    if (digits.length <= 7) {
      return '${digits.substring(0, 4)} ${digits.substring(4)}';
    }
    return '${digits.substring(0, 4)} ${digits.substring(4, 7)} ${digits.substring(7, 11)}';
  }

  // Germany format: XXX XXXXXXX or XXX XXXX XXXX
  static String _formatGermany(String digits) {
    if (digits.length <= 3) return digits;
    if (digits.length <= 8) {
      return '${digits.substring(0, 3)} ${digits.substring(3)}';
    }
    return '${digits.substring(0, 3)} ${digits.substring(3, 7)} ${digits.substring(7, 11)}';
  }

  // France format: X XX XX XX XX
  static String _formatFrance(String digits) {
    if (digits.length <= 1) return digits;
    if (digits.length <= 3)
      return '${digits.substring(0, 1)} ${digits.substring(1)}';
    if (digits.length <= 5)
      return '${digits.substring(0, 1)} ${digits.substring(1, 3)} ${digits.substring(3)}';
    if (digits.length <= 7)
      return '${digits.substring(0, 1)} ${digits.substring(1, 3)} ${digits.substring(3, 5)} ${digits.substring(5)}';
    return '${digits.substring(0, 1)} ${digits.substring(1, 3)} ${digits.substring(3, 5)} ${digits.substring(5, 7)} ${digits.substring(7, 9)}';
  }

  // Italy format: XXX XXX XXXX
  static String _formatItaly(String digits) {
    if (digits.length <= 3) return digits;
    if (digits.length <= 6) {
      return '${digits.substring(0, 3)} ${digits.substring(3)}';
    }
    return '${digits.substring(0, 3)} ${digits.substring(3, 6)} ${digits.substring(6, 10)}';
  }

  // Spain format: XXX XX XX XX
  static String _formatSpain(String digits) {
    if (digits.length <= 3) return digits;
    if (digits.length <= 5) {
      return '${digits.substring(0, 3)} ${digits.substring(3)}';
    }
    if (digits.length <= 7) {
      return '${digits.substring(0, 3)} ${digits.substring(3, 5)} ${digits.substring(5)}';
    }
    return '${digits.substring(0, 3)} ${digits.substring(3, 5)} ${digits.substring(5, 7)} ${digits.substring(7, 9)}';
  }

  // Japan format: XXX-XXXX-XXXX
  static String _formatJapan(String digits) {
    if (digits.length <= 3) return digits;
    if (digits.length <= 7) {
      return '${digits.substring(0, 3)}-${digits.substring(3)}';
    }
    return '${digits.substring(0, 3)}-${digits.substring(3, 7)}-${digits.substring(7, 11)}';
  }

  // South Korea format: XXX-XXXX-XXXX
  static String _formatSouthKorea(String digits) {
    if (digits.length <= 3) return digits;
    if (digits.length <= 7) {
      return '${digits.substring(0, 3)}-${digits.substring(3)}';
    }
    return '${digits.substring(0, 3)}-${digits.substring(3, 7)}-${digits.substring(7, 11)}';
  }

  // China format: XXX XXXX XXXX
  static String _formatChina(String digits) {
    if (digits.length <= 3) return digits;
    if (digits.length <= 7) {
      return '${digits.substring(0, 3)} ${digits.substring(3)}';
    }
    return '${digits.substring(0, 3)} ${digits.substring(3, 7)} ${digits.substring(7, 11)}';
  }

  // India format: XXXXX XXXXX
  static String _formatIndia(String digits) {
    if (digits.length <= 5) return digits;
    return '${digits.substring(0, 5)} ${digits.substring(5, 10)}';
  }

  // Brazil format: (XX) XXXXX-XXXX
  static String _formatBrazil(String digits) {
    if (digits.length <= 2) return digits;
    if (digits.length <= 7) {
      return '(${digits.substring(0, 2)}) ${digits.substring(2)}';
    }
    return '(${digits.substring(0, 2)}) ${digits.substring(2, 7)}-${digits.substring(7, 11)}';
  }

  // Mexico format: XXX XXX XXXX
  static String _formatMexico(String digits) {
    if (digits.length <= 3) return digits;
    if (digits.length <= 6) {
      return '${digits.substring(0, 3)} ${digits.substring(3)}';
    }
    return '${digits.substring(0, 3)} ${digits.substring(3, 6)} ${digits.substring(6, 10)}';
  }

  // Russia format: XXX XXX-XX-XX
  static String _formatRussia(String digits) {
    if (digits.length <= 3) return digits;
    if (digits.length <= 6) {
      return '${digits.substring(0, 3)} ${digits.substring(3)}';
    }
    if (digits.length <= 8) {
      return '${digits.substring(0, 3)} ${digits.substring(3, 6)}-${digits.substring(6)}';
    }
    return '${digits.substring(0, 3)} ${digits.substring(3, 6)}-${digits.substring(6, 8)}-${digits.substring(8, 10)}';
  }

  // Saudi Arabia format: XXX XXX XXXX
  static String _formatSaudiArabia(String digits) {
    if (digits.length <= 3) return digits;
    if (digits.length <= 6) {
      return '${digits.substring(0, 3)} ${digits.substring(3)}';
    }
    return '${digits.substring(0, 3)} ${digits.substring(3, 6)} ${digits.substring(6, 10)}';
  }

  // UAE format: XX XXX XXXX
  static String _formatUAE(String digits) {
    if (digits.length <= 2) return digits;
    if (digits.length <= 5) {
      return '${digits.substring(0, 2)} ${digits.substring(2)}';
    }
    return '${digits.substring(0, 2)} ${digits.substring(2, 5)} ${digits.substring(5, 9)}';
  }

  // Egypt format: XXX XXX XXXX
  static String _formatEgypt(String digits) {
    if (digits.length <= 3) return digits;
    if (digits.length <= 6) {
      return '${digits.substring(0, 3)} ${digits.substring(3)}';
    }
    return '${digits.substring(0, 3)} ${digits.substring(3, 6)} ${digits.substring(6, 10)}';
  }

  // Iraq format: XXX XXX XXXX
  static String _formatIraq(String digits) {
    if (digits.length <= 3) return digits;
    if (digits.length <= 6) {
      return '${digits.substring(0, 3)} ${digits.substring(3)}';
    }
    return '${digits.substring(0, 3)} ${digits.substring(3, 6)} ${digits.substring(6, 10)}';
  }

  // Jordan format: XX XXX XXXX
  static String _formatJordan(String digits) {
    if (digits.length <= 2) return digits;
    if (digits.length <= 5) {
      return '${digits.substring(0, 2)} ${digits.substring(2)}';
    }
    return '${digits.substring(0, 2)} ${digits.substring(2, 5)} ${digits.substring(5, 9)}';
  }

  // Lebanon format: XX XXX XXX
  static String _formatLebanon(String digits) {
    if (digits.length <= 2) return digits;
    if (digits.length <= 5) {
      return '${digits.substring(0, 2)} ${digits.substring(2)}';
    }
    return '${digits.substring(0, 2)} ${digits.substring(2, 5)} ${digits.substring(5, 8)}';
  }

  // Syria format: XXX XXX XXX
  static String _formatSyria(String digits) {
    if (digits.length <= 3) return digits;
    if (digits.length <= 6) {
      return '${digits.substring(0, 3)} ${digits.substring(3)}';
    }
    return '${digits.substring(0, 3)} ${digits.substring(3, 6)} ${digits.substring(6, 9)}';
  }

  // Turkey format: XXX XXX XX XX
  static String _formatTurkey(String digits) {
    if (digits.length <= 3) return digits;
    if (digits.length <= 6) {
      return '${digits.substring(0, 3)} ${digits.substring(3)}';
    }
    if (digits.length <= 8) {
      return '${digits.substring(0, 3)} ${digits.substring(3, 6)} ${digits.substring(6)}';
    }
    return '${digits.substring(0, 3)} ${digits.substring(3, 6)} ${digits.substring(6, 8)} ${digits.substring(8, 10)}';
  }

  // Iran format: XXX XXX XXXX
  static String _formatIran(String digits) {
    if (digits.length <= 3) return digits;
    if (digits.length <= 6) {
      return '${digits.substring(0, 3)} ${digits.substring(3)}';
    }
    return '${digits.substring(0, 3)} ${digits.substring(3, 6)} ${digits.substring(6, 10)}';
  }

  // Kuwait format: XXXX XXXX
  static String _formatKuwait(String digits) {
    if (digits.length <= 4) return digits;
    return '${digits.substring(0, 4)} ${digits.substring(4, 8)}';
  }

  // Qatar format: XXXX XXXX
  static String _formatQatar(String digits) {
    if (digits.length <= 4) return digits;
    return '${digits.substring(0, 4)} ${digits.substring(4, 8)}';
  }

  // Bahrain format: XXXX XXXX
  static String _formatBahrain(String digits) {
    if (digits.length <= 4) return digits;
    return '${digits.substring(0, 4)} ${digits.substring(4, 8)}';
  }

  // Oman format: XXXX XXXX
  static String _formatOman(String digits) {
    if (digits.length <= 4) return digits;
    return '${digits.substring(0, 4)} ${digits.substring(4, 8)}';
  }

  // Australia format: XXXX XXX XXX
  static String _formatAustralia(String digits) {
    if (digits.length <= 4) return digits;
    if (digits.length <= 7) {
      return '${digits.substring(0, 4)} ${digits.substring(4)}';
    }
    return '${digits.substring(0, 4)} ${digits.substring(4, 7)} ${digits.substring(7, 10)}';
  }

  // South Africa format: XX XXX XXXX
  static String _formatSouthAfrica(String digits) {
    if (digits.length <= 2) return digits;
    if (digits.length <= 5) {
      return '${digits.substring(0, 2)} ${digits.substring(2)}';
    }
    return '${digits.substring(0, 2)} ${digits.substring(2, 5)} ${digits.substring(5, 9)}';
  }

  // Nigeria format: XXX XXX XXXX
  static String _formatNigeria(String digits) {
    if (digits.length <= 3) return digits;
    if (digits.length <= 6) {
      return '${digits.substring(0, 3)} ${digits.substring(3)}';
    }
    return '${digits.substring(0, 3)} ${digits.substring(3, 6)} ${digits.substring(6, 10)}';
  }

  // Kenya format: XXX XXX XXX
  static String _formatKenya(String digits) {
    if (digits.length <= 3) return digits;
    if (digits.length <= 6) {
      return '${digits.substring(0, 3)} ${digits.substring(3)}';
    }
    return '${digits.substring(0, 3)} ${digits.substring(3, 6)} ${digits.substring(6, 9)}';
  }

  // Default format for unknown countries
  static String _formatDefault(String digits) {
    if (digits.length <= 4) return digits;
    if (digits.length <= 8) {
      return '${digits.substring(0, 4)} ${digits.substring(4)}';
    }
    return '${digits.substring(0, 4)} ${digits.substring(4, 8)} ${digits.substring(8)}';
  }

  /// Validates phone number based on country-specific rules
  static bool isValidPhoneNumber(String phoneNumber, String countryCode) {
    String digits = phoneNumber.replaceAll(RegExp(r'[^\d]'), '');

    switch (countryCode) {
      case '+1': // US/Canada - 10 digits
        return digits.length == 10;
      case '+44': // UK - 10-11 digits
        return digits.length >= 10 && digits.length <= 11;
      case '+49': // Germany - 10-12 digits
        return digits.length >= 10 && digits.length <= 12;
      case '+33': // France - 9 digits
        return digits.length == 9;
      case '+39': // Italy - 9-10 digits
        return digits.length >= 9 && digits.length <= 10;
      case '+34': // Spain - 9 digits
        return digits.length == 9;
      case '+81': // Japan - 10-11 digits
        return digits.length >= 10 && digits.length <= 11;
      case '+82': // South Korea - 10-11 digits
        return digits.length >= 10 && digits.length <= 11;
      case '+86': // China - 11 digits
        return digits.length == 11;
      case '+91': // India - 10 digits
        return digits.length == 10;
      case '+55': // Brazil - 10-11 digits
        return digits.length >= 10 && digits.length <= 11;
      case '+52': // Mexico - 10 digits
        return digits.length == 10;
      case '+7': // Russia - 10 digits
        return digits.length == 10;
      case '+966': // Saudi Arabia - 9 digits
        return digits.length == 9;
      case '+971': // UAE - 9 digits
        return digits.length == 9;
      case '+20': // Egypt - 10 digits
        return digits.length == 10;
      case '+964': // Iraq - 10 digits
        return digits.length == 10;
      case '+962': // Jordan - 9 digits
        return digits.length == 9;
      case '+961': // Lebanon - 8 digits
        return digits.length == 8;
      case '+963': // Syria - 9 digits
        return digits.length == 9;
      case '+90': // Turkey - 10 digits
        return digits.length == 10;
      case '+98': // Iran - 10 digits
        return digits.length == 10;
      case '+965': // Kuwait - 8 digits
        return digits.length == 8;
      case '+974': // Qatar - 8 digits
        return digits.length == 8;
      case '+973': // Bahrain - 8 digits
        return digits.length == 8;
      case '+968': // Oman - 8 digits
        return digits.length == 8;
      case '+61': // Australia - 9 digits
        return digits.length == 9;
      case '+27': // South Africa - 9 digits
        return digits.length == 9;
      case '+234': // Nigeria - 10 digits
        return digits.length == 10;
      case '+254': // Kenya - 9 digits
        return digits.length == 9;
      default:
        return digits.length >= 7 && digits.length <= 15;
    }
  }

  /// Creates input formatters for phone number input
  static List<TextInputFormatter> getInputFormatters(String countryCode) {
    return [
      FilteringTextInputFormatter.digitsOnly,
      LengthLimitingTextInputFormatter(_getMaxLength(countryCode)),
    ];
  }

  /// Gets maximum length for phone number based on country
  static int _getMaxLength(String countryCode) {
    switch (countryCode) {
      case '+1': // US/Canada
      case '+52': // Mexico
      case '+7': // Russia
      case '+20': // Egypt
      case '+964': // Iraq
      case '+90': // Turkey
      case '+98': // Iran
      case '+234': // Nigeria
        return 10;
      case '+44': // UK
      case '+49': // Germany
      case '+81': // Japan
      case '+82': // South Korea
      case '+86': // China
      case '+91': // India
      case '+55': // Brazil
        return 11;
      case '+33': // France
      case '+34': // Spain
      case '+39': // Italy
      case '+963': // Syria
      case '+966': // Saudi Arabia
      case '+971': // UAE
      case '+962': // Jordan
      case '+61': // Australia
      case '+27': // South Africa
      case '+254': // Kenya
        return 9;
      case '+961': // Lebanon
      case '+965': // Kuwait
      case '+974': // Qatar
      case '+973': // Bahrain
      case '+968': // Oman
        return 8;
      default:
        return 15;
    }
  }
}

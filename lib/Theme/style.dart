import 'package:flutter/material.dart';

import '../Widgets/global_text.dart';

ThemeData colorTheme(BuildContext context) => Theme.of(context);

TextTheme textTheme(BuildContext context) => Theme.of(context).textTheme;

class AppTheme {
  static const Color secondary = Colors.white;

  static const Color primary = Color(0xff1D2089);
  static const Color blue = Color(0xff1D2089);
  static const Color card = Color(0xffF4F7FA);
  static const Color scaffold = Color(0xfff1f5f9);

  static const Color qtyColor = Color(0xff6d28d9);
  static const Color cbmColor = Color(0xffc2410c);
  static const Color weightColor = Color(0xff15803d);

  static const Color white = Colors.white;
  static const Color button = Color(0xff118a3f);
  static const Color green = Color(0xff118a3f);
  static const Color orange = Color(0xfffea41b);
  static const Color black = Color(0xff131313);
  static const Color red = Color(0xffDF0414);
  static const Color transparent = Colors.transparent;
  static const Color grey = Color(0xffF3F3F3);
  static const Color grey_thick = Color(0xffF7F7F7);
  static const Color grey_thin = Color(0xff666666);
  static const Color grey_between = Color(0xffB3B3B3);

  static text({text, font, size, color}) {
    GlobalText(text: text, fontFamily: font, fontSize: size, color: color);
  }

  //light english theme
  static final ThemeData englishTheme = ThemeData(
      useMaterial3: false,
      indicatorColor: primary,
      cardColor: AppTheme.card,
      scaffoldBackgroundColor: scaffold,
      brightness: Brightness.light,
      appBarTheme: AppBarTheme(
        iconTheme: IconThemeData(color: AppTheme.black),
        backgroundColor: scaffold,
        elevation: 0,
        titleSpacing: 0,
        centerTitle: false,
        titleTextStyle:
            TextStyle(fontSize: 20, fontFamily: 'nrt-reg', fontWeight: FontWeight.bold, color: AppTheme.black),
      ));

  static final TextStyle _headline1 = TextStyle(
    color: AppTheme.primary,
    fontWeight: FontWeight.w700,
    fontFamily: 'inter-bold',
    fontSize: 40,
  );

  static final TextStyle _headline2 = TextStyle(
    color: AppTheme.black,
    fontWeight: FontWeight.w700,
    fontFamily: 'inter-bold',
    fontSize: 30,
  );

  static final TextStyle _headline3 = TextStyle(
    color: AppTheme.black,
    fontWeight: FontWeight.w700,
    fontFamily: 'inter-bold',
    fontSize: 24,
  );

  static final TextStyle _headline4 = TextStyle(
    color: AppTheme.black,
    fontWeight: FontWeight.w700,
    fontFamily: 'inter-bold',
    fontSize: 22,
  );

  static final TextStyle _headline5 = TextStyle(
    fontFamily: 'inter-semi-bold',
    color: AppTheme.black,
    fontWeight: FontWeight.w600,
    fontSize: 18,
  );

  static final TextStyle _headline6 = TextStyle(
    fontFamily: 'inter-regular',
    color: AppTheme.black,
    fontWeight: FontWeight.w500,
    fontSize: 15,
  );

  static final TextStyle _button = TextStyle(
    fontFamily: 'inter-bold',
    color: AppTheme.secondary,
    fontWeight: FontWeight.w700,
    fontSize: 20,
  );

  static final TextStyle _subtitle1 = TextStyle(
    fontFamily: 'rudaw-regular',
    color: AppTheme.black,
    fontWeight: FontWeight.w400,
    fontSize: 14,
  );
  static final TextStyle _subtitle2 = TextStyle(
    fontFamily: 'inter-medium',
    color: AppTheme.black,
    fontWeight: FontWeight.w500,
    fontSize: 15,
  );

  static final TextStyle _bodyText1 = TextStyle(
    fontFamily: 'inter-bold',
    color: Color(0xffC6C9CE),
    fontWeight: FontWeight.w700,
    fontSize: 20,
  );

  static final TextStyle _bodyText2 = TextStyle(
    fontFamily: 'inter-bold',
    color: AppTheme.grey,
    fontSize: 15,
  );
}

import 'package:flutter/material.dart';
import 'package:x_express/Utils/exports.dart';

class LanguageTile extends StatelessWidget {
  LanguageTile(
      {required this.image,
      required this.name,
      required this.locale,
      required this.direction,
      required this.onTap,
      this.isLanguage});
  final String image;
  final String name;
  final String locale;
  final String direction;
  final bool? isLanguage;
  final onTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AnimatedContainer(
          duration: Duration(milliseconds: 300),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
          ),
          child: ListTile(
            contentPadding: EdgeInsets.symmetric(horizontal: 13),
            onTap: onTap,
            title: GlobalText(
              text: name,
              fontSize: 17,
              color: Colors.black87,
            ),
            trailing: isLanguage!
                ? Icon(
                    Icons.check,
                    color: AppTheme.primary,
                    size: 20,
                  )
                : SizedBox.shrink(),
          ),
        ),
        Divider(
          height: 0,
          color: AppTheme.black.withOpacity(0.1),
          thickness: 1,
        ),
      ],
    );
  }
}

final List flags = [
  {'id': '1', 'label': 'کوردی', 'asset': "assets/images/kurdish.png", 'code': 'kr', 'direction': 'rtl'},
  {'id': '2', 'label': 'English', 'asset': "assets/images/english.png", 'code': 'en', 'direction': 'ltr'},
  {'id': '3', 'label': 'عربی', 'asset': "assets/images/arabic.png", 'code': 'ar', 'direction': 'rtl'},
];

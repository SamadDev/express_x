import 'package:x_express/Utils/exports.dart';

class TextLanguage extends StatelessWidget {
  final style;
  final titleKr;
  final titleAr;
  final titleEn;

  const TextLanguage({Key? key, this.style, this.titleAr, this.titleEn, this.titleKr}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final language = Provider.of<Language>(context, listen: false);
    return Text(
      language.languageCode == "kr"
          ? titleKr
          : language.languageCode == "ar"
              ? titleAr
              : titleEn,
      style: style,
    );
  }
}

String StringLanguage({titleAr, titleKr, titleEn, context}) {
  final language = Provider.of<Language>(context, listen: false);
  return language.languageCode == "kr"
      ? titleKr
      : language.languageCode == "ar"
          ? titleAr
          : titleEn;
}

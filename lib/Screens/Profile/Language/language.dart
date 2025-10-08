import 'package:x_express/Screens/Profile/Language/Widgets/language_title.dart';
import 'package:x_express/Utils/exports.dart';

class LanguageScreen extends StatelessWidget {
  final index;
  LanguageScreen({this.index});

  Widget build(BuildContext context) {
    final Language language = Provider.of<Language>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppTheme.primary,
        title: Text(language.getWords['language']),
      ),
      body: Padding(
        padding: EdgeInsets.only(
          right: 20,
          left: 20,
          top: 30,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(
              Icons.g_translate,
              color: AppTheme.primary,
              size: 75,
            ),
            SizedBox(height: 15),
            GlobalText(
              text: language.getWords['chooses_your_preferred_language'],
              fontSize: 20,
            ),
            SizedBox(height: 4),
            GlobalText(
              text: language.getWords['please_select_your_language'],
              fontFamily: "inter-medium",
              fontWeight: FontWeight.w500,
              fontSize: 16,
              color: AppTheme.grey,
            ),
            SizedBox(height: 30),
            Column(
              children: flags
                  .map<Widget>((e) => Consumer<Language>(
                      builder: (ctx, language, _) => LanguageTile(
                            name: e['label'],
                            image: e['asset'],
                            locale: e['code'],
                            direction: e['direction'],
                            isLanguage: e['code'] == language.languageCode,
                            onTap: () {
                              language.setLanguage(e['code'], e['direction']);
                              // Navigator.of(context).pop();
                            },
                          )))
                  .toList(),
            ),
          ],
        ),
      ),
    );
  }
}

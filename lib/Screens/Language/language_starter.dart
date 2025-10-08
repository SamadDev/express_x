import 'package:x_express/Screens/Language/Widgets/language_title.dart';
import 'package:x_express/Utils/exports.dart';

class LanguageStarterScreen extends StatelessWidget {
  final String type;
  LanguageStarterScreen({this.type = "start"});
  @override
  Widget build(BuildContext context) {
    final Language language = Provider.of<Language>(context);
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 10,
        elevation: 0.5,
        backgroundColor: Colors.white,
        title: GlobalText(text:
          language.getWords["language"],
          fontSize: 18, color: AppTheme.black,
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
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
                          },
                        )))
                .toList(),
          ),
          Spacer(),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10),
            height: 47,
            width: Responsive.sH(context),
            child: ElevatedButton(
                style: ElevatedButton.styleFrom(elevation: 0, backgroundColor: AppTheme.primary),
                onPressed: () async {
                  type == 'start' ? navigator_route(context: context, page: LoginPage()) : Navigator.of(context).pop();
                },
                child: GlobalText(text:
                  language.getWords['save'],
                  color: AppTheme.white,
                  fontSize: 18,
                )),
          ),
          SizedBox(
            height: 50,
          ),
        ],
      ),
    );
  }
}

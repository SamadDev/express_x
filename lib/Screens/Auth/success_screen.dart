import 'package:x_express/Utils/exports.dart';

class SuccessScreen extends StatelessWidget {
  final type;
  const SuccessScreen({this.type});

  @override
  Widget build(BuildContext context) {
    final language = Provider.of<Language>(context, listen: false);
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(right: 45, left: 45),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 50,
            ),
            Image.asset(
              "assets/images/success.png",
              color: AppTheme.primary,
              height: 120,
              width: 120,
            ),
            SizedBox(
              height: 20,
            ),
            GlobalText(text:language.getWords["Success"] ?? "",
               color: AppTheme.primary,

              fontWeight: FontWeight.w700,
              fontSize: 40,
            ),
            SizedBox(
              height: 8,
            ),
            GlobalText(text:
              type == "registered"
                  ? language.getWords['congratulations_your_phone_number_has_been_successfully_verified']
                  : language.getWords['congratulations_your_password_has_been_successfully_reset'],
              textAlign: TextAlign.center,

                  color: AppTheme.grey, fontFamily: 'inter-regular', fontSize: 18, fontWeight: FontWeight.w500,
            ),
            SizedBox(
              height: 30,
            ),
            Customer_Button(
              text: language.getWords["continue"] ?? "",
              onPress: () {
                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(
                        builder: (context) => type == "registered" ? NavigationButtonScreen() : LoginPage()),
                    (route) => false);
              },
            )
          ],
        ),
      ),
    );
  }
}

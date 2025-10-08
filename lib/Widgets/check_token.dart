import 'package:lottie/lottie.dart';
import 'package:x_express/Utils/exports.dart';

class CheckForUpdate extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final language = Provider.of<Language>(context, listen: false);
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Lottie.asset("assets/images/update.json", width: 300, height: 300),
            SizedBox(
              height: 30,
            ),
            GlobalText(
              text: language.getWords['update_title'],
              color: AppTheme.black.withOpacity(0.7),
              fontWeight: FontWeight.w700,
              fontSize: 24,
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: Text(
                language.getWords['update_description'],
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(
              height: 15,
            ),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  elevation: 0,
                  backgroundColor: AppTheme.primary,
                ),
                onPressed: () {},
                child: GlobalText(
                  text: language.getWords['update'],
                  color: AppTheme.white,
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
      // body: AlertDialog(
      //   alignment: Alignment.center,
      //   elevation: 1,
      // title: Text(
      //   language.getWords['update_title'],
      //   style: textTheme(context).headline5,
      // ),
      //   content: Text(
      //     language.getWords['update_description'],
      //     textAlign: TextAlign.left,
      //     style: textTheme(context).headline6!.copyWith(fontSize: 16),
      //   ),
      //   actions: [
      //     ElevatedButton(
      //       style: ElevatedButton.styleFrom(
      //         elevation: 0,
      //         backgroundColor: AppTheme.primary,
      //       ),
      //       onPressed: () {
      //         LaunchReview.launch(writeReview: false, androidAppId: "com.eagleexpressiq.net", iOSAppId: "6450153753");
      //       },
      //       child: Text(language.getWords['update'], style: textTheme(context).headline6!.copyWith(color: AppTheme.white, fontSize: 17)),
      //     ),
      //   ],
      // ),
    );
  }
}

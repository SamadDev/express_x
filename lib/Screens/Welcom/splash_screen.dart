import 'package:x_express/Utils/exports.dart';

import 'onboarding.dart';

class SplashScreen extends StatelessWidget {
  Widget build(BuildContext context) {
    final auth = Provider.of<Auth>(context, listen: false);
    Future<void> fetch() async {
      await auth.localDate('data', 'get');
      await Provider.of<Language>(context, listen: false).getLanguageDataInLocal();
    }

    return Scaffold(
      backgroundColor: AppTheme.white,
      body: FutureBuilder(
        future: fetch(),
        builder: (ctx, snapshot) => snapshot.connectionState == ConnectionState.waiting
            ? Center(child: SplashWidget())
            : Auth.customer_id.isEmpty || Auth.token.isEmpty
                ? LanguageStarterScreen()
                // OnboardingScreen()
                : Auth.userType == "client"
                    ? NavigationButtonScreen()
                    : Auth.userType == "user"
                        ? NavigationUserScreen()
                        : LoginPage(),
      ),
    );
  }
}

class SplashWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Image.asset(
        'assets/images/${dotenv.env['LOGO']}',
        width: 120,
        height: 120,
        fit: BoxFit.fill,
      ),
    );
  }
}

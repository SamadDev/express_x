import 'package:x_express/Utils/exports.dart';

class MyApps extends StatefulWidget {
  State<MyApps> createState() => _MyAppsState();
}

class _MyAppsState extends State<MyApps> {
  @override
  void didChangeDependencies() async {
    OneSignal.Notifications.addClickListener((event) {
      handleNotification(event.notification.additionalData);
    });
    print("main onesignal is: ${OneSignal.User.pushSubscription.id.toString()}");
    super.didChangeDependencies();
  }

  void handleNotification(var message) {
    debugPrint("message data is: ${message['type']}");

    final data = message;
    final type = data['type'];
    final id = data['id'];

    if (type == 'xxx') {}
  }

  void push(Widget child) {
    Navigator.push(
      navigatorKey.currentState!.context,
      MaterialPageRoute(
        builder: (context) {
          return child;
        },
      ),
    );
  }

  Widget build(BuildContext context) {
    return MultiProvider(
      providers: providers,
      child: MaterialApp(
        navigatorKey: navigatorKey,
        builder: (context, child) {
          return Consumer<Language>(
            builder: (_, language, __) => Directionality(
                textDirection: language.languageDirection == 'ltr' ? TextDirection.ltr : TextDirection.rtl,
                child: child!),
          );
        },
        //
        debugShowCheckedModeBanner: false,
        title: "Futian",
        theme: AppTheme.englishTheme,
        home: SplashScreen(),
      ),
    );
  }
}

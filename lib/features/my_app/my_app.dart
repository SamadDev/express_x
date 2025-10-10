import 'package:flutter/material.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:provider/provider.dart';
import 'package:x_express/core/config/theme/theme.dart';
import 'package:x_express/main.dart';
import 'package:x_express/Language/language.dart';
import 'package:x_express/pages/Auth/data/service/auth_service.dart';
import 'package:x_express/pages/Bag/bag_service.dart';
import 'package:x_express/pages/wellcom/splash.dart';

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
      providers: [
        // ChangeNotifierProvider(create: (_) => Language()),
        ChangeNotifierProvider(create: (_) => AuthService()),
        ChangeNotifierProvider(create: (_) => BagService()),
      ],
      child: MaterialApp(
        navigatorKey: navigatorKey,
        builder: (context, child) {
          return Directionality(
            textDirection:
                TextDirection.ltr,

            child: child!,
          );
        },
        debugShowCheckedModeBanner: false,
        title: "X_Express",
        theme: AppTheme.lightTheme,
        home: SplashScreen(),
      ),
    );
  }
}

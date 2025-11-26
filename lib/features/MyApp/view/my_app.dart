import 'package:flutter/material.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:provider/provider.dart';
import 'package:x_express/core/config/language/language.dart';
import 'package:x_express/core/config/routes/routes.dart';
import 'package:x_express/core/config/theme/theme.dart';
import 'package:x_express/features/Auth/data/service/auth_service.dart';
import 'package:x_express/features/Bag/data/service/bag_service.dart';
import 'package:x_express/features/Home/data/service/order_service.dart';
import 'package:x_express/features/Profile/data/service/profile_service.dart';
import 'package:x_express/features/Wellcom/view/auth_wrapper.dart';
import 'package:x_express/main.dart';

class MyApps extends StatefulWidget {
  State<MyApps> createState() => _MyAppsState();
}

class _MyAppsState extends State<MyApps> {
  @override
  void didChangeDependencies() async {
    OneSignal.Notifications.addClickListener((event) {
      handleNotification(event.notification.additionalData);
    });
    print(
        "main onesignal is: ${OneSignal.User.pushSubscription.id.toString()}");
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
        ChangeNotifierProvider(create: (_) => AuthService()),
        ChangeNotifierProvider(create: (_) => BagService()),
        ChangeNotifierProvider(create: (_) => OrderService()),
        ChangeNotifierProvider(create: (_) => ProfileService()),
        ChangeNotifierProvider(create: (_) => Language()),
      ],
      child: MaterialApp(
        navigatorKey: navigatorKey,
        debugShowCheckedModeBanner: false,
        title: "X_Express",
        theme: AppTheme.lightTheme,
        home: AuthWrapper(),
        onGenerateRoute: AppRoute.generateRoute,
      ),
    );
  }
}

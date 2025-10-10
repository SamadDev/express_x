import "package:device_preview/device_preview.dart";
import "package:flutter/material.dart";
import "package:flutter/services.dart";
import "package:onesignal_flutter/onesignal_flutter.dart";
import "package:flutter_dotenv/flutter_dotenv.dart";
import "package:x_express/features/my_app/my_app.dart";

late GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

Future<void> main() async {
  await dotenv.load(fileName: ".env");
  WidgetsFlutterBinding.ensureInitialized();
  navigatorKey = GlobalKey<NavigatorState>();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(statusBarColor: Colors.transparent),
  );

  OneSignal.Debug.setLogLevel(OSLogLevel.verbose);
  OneSignal.initialize(dotenv.env['APPID']!);
  OneSignal.Notifications.requestPermission(false);

  runApp(
    DevicePreview(
      enabled: false,
      builder: (context) => MyApps(),
    ),
  );
}



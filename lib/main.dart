import 'package:x_express/Utils/exports.dart';
import "package:device_preview/device_preview.dart";

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



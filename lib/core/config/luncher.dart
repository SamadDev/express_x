import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';

class Launcher {
  static Future<void> openTell() async {
    final phoneNumber = "+9647514404290";
    if (await canLaunchUrlString('tel:$phoneNumber')) {
      await launchUrlString('tel:$phoneNumber');
    }
  }

  // static Future<void> openTelegram(String telegram) async {
  //   if (await canLaunchUrlString('whatsapp://send?phone=$phoneNu')) {
  //     await launchUrlString('whatsapp://send?phone=$phoneNu');
  //   }
  //   await launchUrlString("https://t.me/Samad_Shukr");
  // } //  info@dottech.com

  static Future<void> openEmail(String telegram) async {
    const uri = 'mailto:info@dottech.com?subject=Greetings&body=Hello';
    if (await canLaunch(uri)) {
      await launch(uri);
    } else {
      throw 'Could not launch $uri';
    }
  } //  info@dottech.com

  static Future<void> openWhatsApp() async {
    final phoneNumber = "+9647514404290";
    final whatsappUrl = "whatsapp://send?phone=$phoneNumber";

    if (await canLaunch(whatsappUrl)) {
      await launch(whatsappUrl);
    } else {
      throw 'Could not launch $whatsappUrl';
    }
  }

  static Future<void> openBrowser(String url) async {
    if (await canLaunchUrlString(url)) {
      await launchUrlString(url);
    }
  }
}

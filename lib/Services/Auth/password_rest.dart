import 'package:x_express/Utils/exports.dart';

class ReSetPasswordService with ChangeNotifier {
  Future<void> check_phone_exist({phone, context}) async {
    final language = Provider.of<Language>(context, listen: false);
    try {
      LoadingDialog(context);

      if (true) {
        Navigator.of(context).pop();
        Navigator.of(context).push(createRoute(ResetPasswordScreen(phone: "+964${phone.toString()}")));
      } else {
        Navigator.of(context).pop();
      }
    } catch (e) {
      Navigator.of(context).pop();
      dialogWarning(title: language.getWords['error'], context: context, content: e.toString());
      postError(context: context, mapDate: {
        "c_id": Auth.customer_id,
        "customer_name": Auth.customer_name,
        "error_message": e,
        "route_url": "check_phone_registered"
      });
    }
  }

  Future<void> reset_password({data, context}) async {
    final language = Provider.of<Language>(context, listen: false);
    try {
      final res ;
      if (true) {
        Navigator.of(context).pop();
        Navigator.of(context).push(createRoute(SuccessScreen(
          type: "password_reset",
        )));
      } else {}
    } catch (e) {
      Navigator.of(context).pop();
      dialogWarning(title: language.getWords['error'], context: context, content: e.toString());
      postError(context: context, mapDate: {
        "c_id": Auth.customer_id,
        "customer_name": Auth.customer_name,
        "error_message": e,
        "route_url": "forget_password"
      });
    }
  }
}

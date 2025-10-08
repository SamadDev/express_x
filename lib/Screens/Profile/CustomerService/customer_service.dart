import 'package:x_express/Language/language.dart';
import 'package:x_express/Theme/style.dart';
import 'package:x_express/Utils/luncher.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../Widgets/global_text.dart';

customerService(context) {
  showModalBottomSheet(
    shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10))),
    context: context,
    isScrollControlled: true,
    builder: (BuildContext context) {
      return _CustomerServiceScreen();
    },
  );
}

class _CustomerServiceScreen extends StatelessWidget {
  Widget build(BuildContext context) {
    final language = Provider.of<Language>(context, listen: false);
    return FractionallySizedBox(
      heightFactor: 0.65,
      child: Padding(
        padding: EdgeInsets.only(top: 25, right: 15.0, left: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GlobalText(
              text: language.getWords["customer_Service"],
              fontSize: 20,
              fontFamily: 'nrt-reg',
              fontWeight: FontWeight.w500,
              color: AppTheme.black,
            ),
            SizedBox(
              height: 12,
            ),
            GlobalText(
              text: language.getWords[
                  'if_you_encounter_any_issues_while_using_our_app_please_contact_our_support_team_for_prompt_assistance'],
              fontSize: 15,
              fontFamily: 'nrt-reg',
              fontWeight: FontWeight.w500,
              color: AppTheme.grey_thin,
            ),
            SizedBox(
              height: 20,
            ),
            SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _ServiceCardWidget(
                    title: language.getWords["phone_call"],
                    subtitle: "+9647514404290",
                    icon: 'phone.png',
                    onTap: () {
                      Launcher.openTell();
                    },
                  ),
                  Divider(),
                  _ServiceCardWidget(
                    title: language.getWords["whatsUp"],
                    subtitle: "9647514404290",
                    icon: 'whatsapp.png',
                    onTap: () {
                      Launcher.openWhatsApp();
                    },
                  ),
                  Divider(),
                  _ServiceCardWidget(
                    title: language.getWords["email"],
                    subtitle: "info@dottech.co",
                    icon: 'gmail.png',
                    onTap: () {
                      Launcher.openWhatsApp();
                    },
                  ),
                  Divider(),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class _ServiceCardWidget extends StatelessWidget {
  final title;
  final subtitle;
  final onTap;
  final icon;
  _ServiceCardWidget({this.onTap, this.title, this.icon, this.subtitle});
// 7514404290
  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      contentPadding: EdgeInsets.only(right: 5, left: 5),
      title: GlobalText(
        text: title,
        fontSize: 16,
        fontFamily: 'nrt-reg',
        fontWeight: FontWeight.w500,
        color: AppTheme.black,
      ),
      subtitle: GlobalText(
        text: subtitle ?? "",
        fontSize: 13,
        fontFamily: 'nrt-reg',
        fontWeight: FontWeight.w500,
        color: AppTheme.grey_thin,
      ),
      minLeadingWidth: 0,
      leading: Container(
        height: 30,
        width: 30,
        alignment: Alignment.center,
        child: Image.asset(
          'assets/images/$icon',
          color: AppTheme.primary,
        ),
      ),
    );
    ;
  }
}

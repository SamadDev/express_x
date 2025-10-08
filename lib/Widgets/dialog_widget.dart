import 'package:x_express/Language/language.dart';
import 'package:x_express/Theme/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:x_express/Utils/exports.dart';
import 'package:provider/provider.dart';

areYouSure({context, title, content, onPress}) async {
  final language = Provider.of<Language>(context, listen: false);
  showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          title: GlobalText(
            text: "$title",
            fontSize: 22,
            color: AppTheme.black,
          ),
          content: GlobalText(
            text: content,
            fontSize: 17,
            fontFamily: 'nrt-reg',
            fontWeight: FontWeight.w500,
            color: AppTheme.grey_thin,
          ),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: GlobalText(
                  text: language.getWords['cancel'],
                  color: AppTheme.black,
                  fontFamily: "sf_med",
                  fontSize: 18,
                )),
            TextButton(
                onPressed: onPress,
                child: GlobalText(
                  text: language.getWords['yes'],
                  color: AppTheme.primary,
                  fontFamily: "sf_med",
                  fontSize: 18,
                )),
          ],
        );
      });
}

void dialogWarning({context, title, content}) {
  final language = Provider.of<Language>(context, listen: false);
  showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          title: GlobalText(
            text: "$title",
            color: AppTheme.primary,
            fontSize: 20,
          ),
          content: GlobalText(
            text: content ?? "Error",
            fontSize: 18,
            color: Colors.black,
          ),
          actions: [
            TextButton(
                onPressed: () {
                  Clipboard.setData(ClipboardData(text: content));
                  Navigator.pop(context);
                },
                child: GlobalText(text: language.getWords['ok'])),
          ],
        );
      });
}

void successMessage({
  required BuildContext context,
  String? title,
  String? content,
  bool isDismissible = true, // New parameter
}) {
  final language = Provider.of<Language>(context, listen: false);
  showDialog(
    context: context,
    barrierDismissible: isDismissible, // Prevent dismissal by tapping outside
    builder: (context) {
      return WillPopScope(
        onWillPop: () async => isDismissible, // Prevent dismissal by back button
        child: AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          title: GlobalText(
            text: title ?? "",
            color: AppTheme.primary,
            fontSize: 20,
          ),
          content: GlobalText(
            text: content ?? "Error",
            fontSize: 18,
          ),
          actions: [
            TextButton(
              style: ButtonStyle(backgroundColor: MaterialStateProperty.all(AppTheme.primary)),
              onPressed: () {
                Clipboard.setData(ClipboardData(text: content ?? ""));
                Navigator.pop(context);
              },
              child: GlobalText(
                text: language.getWords['ok'],
                color: AppTheme.white,
              ),
            ),
          ],
        ),
      );
    },
  );
}

void logOutShowDialog({context, title, content}) {
  final language = Provider.of<Language>(context, listen: false);
  showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          title: GlobalText(
            text: "$title",
            color: AppTheme.primary,
            fontSize: 23,
          ),
          content: GlobalText(
            text: content.toString(),
            fontSize: 20,
          ),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: GlobalText(
                  text: language.getWords['ok'],
                )),
          ],
        );
      });
}

void LoadingDialog(context) {
  final language = Provider.of<Language>(context, listen: false);
  showDialog(
      barrierDismissible: false,
      context: (context),
      builder: (context) => WillPopScope(
            onWillPop: () async => false,
            child: AlertDialog(
              content: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GlobalText(
                    text: language.getWords["please wait"],
                    fontSize: 18,
                  ),
                  CircularProgressIndicator(
                    color: AppTheme.primary,
                  )
                ],
              ),
            ),
          ));
}

import 'package:x_express/Theme/style.dart';
import 'package:flutter/material.dart';
import 'package:x_express/Utils/exports.dart';


class NoInternetScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.card,
      body: Center(
        child: Padding(
          padding: EdgeInsets.only(right: 60, left: 60),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/images/wifi.png',
                color: AppTheme.primary,
                width: 150,
                height: 150,
              ),
              // SizedBox(
              //   height: 15,
              // ),
              GlobalText(text:"Some thing went wrong", textAlign: TextAlign.center,color: AppTheme.black,fontSize: 18),
              SizedBox(
                height: 5,
              ),
              GlobalText(text:"Make sure wifi or cellular is turned on and\n then tray again",
                  textAlign: TextAlign.center,
                color: AppTheme.black.withOpacity(0.5),
                fontWeight: FontWeight.w500,
                fontSize: 15,
              ),
              SizedBox(
                height: 50,
              ),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      minimumSize: Size(120, 40),
                      backgroundColor: AppTheme.primary,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))),
                  onPressed: () {
                    // Navigator.of(context).pop();
                  },
                  child: GlobalText(text:
                    "Try again",
                   color: AppTheme.secondary,
                    fontWeight: FontWeight.w500,
                    fontSize: 15,
                  ),
                  )
            ],
          ),
        ),
      ),
    );
  }
}
class NoInternetDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: AppTheme.card,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/wifi.png',
              color: AppTheme.primary,
              width: 150,
              height: 150,
            ),
            SizedBox(height: 15),
            GlobalText(text:
              "Something went wrong",
              textAlign: TextAlign.center,

            ),
            SizedBox(height: 5),
            GlobalText(text:
              "Make sure wifi or cellular is turned on and\nthen try again",
              textAlign: TextAlign.center,
          color: AppTheme.black.withOpacity(0.5),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                minimumSize: Size(120, 40),
                backgroundColor: AppTheme.primary,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              onPressed: () {
                Navigator.of(context).pop();
                // Perform the retry action here
              },
              child: GlobalText(text:
                "Try again",
              ),
            ),
          ],
        ),
      ),
    );
  }
}

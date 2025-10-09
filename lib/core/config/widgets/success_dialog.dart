import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:x_express/core/config/assets/app_lotties.dart';

void showSuccessDialog(context, {duration, message, isPop = true}) {
  showDialog<void>(
    barrierDismissible: false,
    context: context,
    builder: (BuildContext context) {
      late final AnimationController controller;

      return StatefulBuilder(
        builder: (context, setState) {
          return AlertDialog(
            content: SizedBox(
              height: 250,
              child: Column(
                children: [
                  const SizedBox(height: 20),
                  Lottie.asset(
                    AppLotties.success,
                    height: 180,
                    width: 180,
                    repeat: false,
                    onLoaded: (composition) {
                      controller = AnimationController(
                        vsync: Navigator.of(context),
                        duration: Duration(seconds: duration ?? 1),
                      )..forward().whenComplete(() {
                          Navigator.of(context).pop();
                          if (isPop == false) return;
                          Navigator.of(context).pop();
                        });
                    },
                  ),
                  Text(
                    message ?? "Process success fully done",
                    style: TextTheme.of(context).bodyLarge,
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          );
        },
      );
    },
  );
}

import 'package:lottie/lottie.dart';

import 'package:flutter/material.dart';
import 'package:x_express/core/config/assets/app_lotties.dart';
import 'package:x_express/core/config/widgets/globalText.dart';

class EmptyScreen extends StatelessWidget {
  const EmptyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: Lottie.asset(
              AppLotties.empty,
            ),
          ),
          GlobalText(
            "There is no data at that time",
          )
        ],
      ),
    );
  }
}

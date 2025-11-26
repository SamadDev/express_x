import 'package:flutter/material.dart';
import 'package:x_express/core/config/theme/color.dart';
import 'package:x_express/features/Store/view/add_to_bag_dialog.dart';

class OrderLinkWidget extends StatelessWidget {
  const OrderLinkWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AddToBagDialog();
          },
        );
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.grey[300]!),
        ),
        child: Row(
          children: [
            Expanded(
                child: Text(
              'Enter link to order',
              style: TextStyle(color: Colors.grey[600]),
            )),
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: kLightPrimary,
                borderRadius: BorderRadius.circular(4),
              ),
              child: const Text(
                'Paste Link',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

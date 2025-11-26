import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:x_express/core/config/theme/color.dart';
import 'package:x_express/features/Bag/data/service/bag_service.dart';
import 'package:x_express/features/Bag/view/bag_screen.dart';

class HomeAppBarWidget extends StatelessWidget {
  const HomeAppBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: false,
      backgroundColor: kLightPrimary,
      title: Image.asset(
        "assets/images/logo.png",
        width: 120,
      ),
      actions: [
        Consumer<BagService>(
          builder: (context, bagService, child) {
            return Container(
              decoration: BoxDecoration(
                color: kLightPrimary.withValues(alpha: 0.5),
                borderRadius: BorderRadius.circular(90),
              ),
              child: Stack(
                children: [
                  IconButton(
                    icon:
                        Icon(Icons.shopping_bag_outlined, color: kLightSurface),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => BagScreen(),
                        ),
                      );
                    },
                  ),
                  if (bagService.itemCount > 0)
                    Positioned(
                      right: 8,
                      top: 8,
                      child: Container(
                        padding: EdgeInsets.all(2),
                        decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        constraints: BoxConstraints(
                          minWidth: 16,
                          minHeight: 16,
                        ),
                        child: Text(
                          '${bagService.itemCount}',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                ],
              ),
            );
          },
        ),
      ],
    );
  }
}

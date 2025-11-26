import 'package:flutter/material.dart';
import 'package:x_express/core/config/constant/size.dart';
import 'package:x_express/core/config/theme/color.dart';
import 'package:x_express/core/config/widgets/globalText.dart';

class DynamicTabBar extends StatelessWidget {
  final List<String> tabs;
  final int selectedIndex;
  final Function(int) onTabSelected;

  const DynamicTabBar({
    super.key,
    required this.tabs,
    required this.selectedIndex,
    required this.onTabSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: kLightPlatinum50,
        borderRadius: BorderRadius.circular(SizeAsset.spacing / 2),
      ),
      child: Row(
        children: List.generate(
          tabs.length,
          (index) => Expanded(
            child: GestureDetector(
              onTap: () => onTabSelected(index),
              child: Container(
                padding: const EdgeInsets.symmetric(
                    vertical: SizeAsset.spacing / 1.8),
                decoration: BoxDecoration(
                  color: selectedIndex == index
                      ? kLightSurfacePrimary
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(SizeAsset.spacing / 2),
                  border: selectedIndex == index
                      ? Border.all(color: kLightStroke)
                      : null,
                ),
                alignment: Alignment.center,
                child: GlobalText(
                  tabs[index],
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

class StaggeredAnimationPage extends StatelessWidget {
final children;
StaggeredAnimationPage({this.children});
  @override
  Widget build(BuildContext context) {
    return AnimationLimiter(
      child: Column(
        children: AnimationConfiguration.toStaggeredList(
          duration: const Duration(milliseconds: 375),
          childAnimationBuilder: (widget) => SlideAnimation(
            horizontalOffset: 100,
            child: FadeInAnimation(
              child: widget,
            ),
          ),
          children: children,
        ),
      ),
    );
  }
}

import 'package:flutter/cupertino.dart';

class FadeSwitch extends StatelessWidget {
  const FadeSwitch({
    super.key,
    required this.child,
    this.duration = const Duration(milliseconds: 300),
  });

  final Widget child;
  final Duration duration;

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: duration,
      transitionBuilder: (child, anim) {
        return FadeTransition(
          opacity: anim,
          child: child,
        );
      },
      child: child,
    );
  }
}

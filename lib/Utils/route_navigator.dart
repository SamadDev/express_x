import 'package:flutter/material.dart';

void navigatorRouteAnimation({context, page}) {
  Navigator.of(context).push(
    PageRouteBuilder(
      transitionDuration: Duration(milliseconds: 700),
      pageBuilder: (BuildContext context, Animation animation, Animation secondaryAnimation) {
        return page;
      },
      transitionsBuilder:
          (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation, Widget child) {
        return Align(
          child: FadeTransition(
            opacity: animation,
            child: child,
          ),
        );
      },
    ),
  );
}

navigator_route({context, page}) {
  Navigator.of(context).push(MaterialPageRoute(builder: (context) => page));
}

navigator_route_pop({context}) {
  Navigator.of(context).pop();
}

void navigator_route_remove({context, page}) {
  Navigator.of(context).pushAndRemoveUntil(
    MaterialPageRoute(builder: (context) => page),
    (route) => false,
  );
}

Route createRoute(page) {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => page,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      const begin = Offset(0.0, 1.0);
      const end = Offset.zero;
      const curve = Curves.ease;
      Duration(seconds: 2);

      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

      return SlideTransition(
        position: animation.drive(tween),
        child: child,
      );
    },
  );
}

import 'package:flutter/material.dart';

PageRouteBuilder customPageRouteBuilder2Back(Widget page) {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => page,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      const begin = Offset(0.0, -1.0);
      const end = Offset.zero;

      var tween = Tween(begin: begin, end: end);
      var offsetAnimation = animation.drive(tween);
      // var curvedAnimation = CurvedAnimation(
      //   parent: animation,
      //   curve: Curves.fastEaseInToSlowEaseOut,
      // );

      return SlideTransition(position: offsetAnimation, child: child);
    },
  );
}

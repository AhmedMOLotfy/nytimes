import 'package:flutter/material.dart';
import 'package:nytimes/DetailsPage.dart';

// GestureDetector gestureDetector(BuildContext context) {
//   return GestureDetector(
//     onTap: () {
//       Navigator.of(context).push(route());
//     },
//   );
// }

Route route(dynamic results) {
  return PageRouteBuilder(pageBuilder: (context, animation, child) {
    return DetailsPage(
      results: results,
    );
  }, transitionsBuilder: (BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
    var begin = Offset(1.5, 0.0);
    var end = Offset.zero;
    var curve = Curves.easeInOut;
    var curveTween = CurveTween(curve: curve);
    var tween = Tween(begin: begin, end: end).chain(curveTween);
    return SlideTransition(
      position: animation.drive(tween),
      child: child,
    );
  });
}

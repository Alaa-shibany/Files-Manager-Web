import 'package:flutter/material.dart';

class BottomCircleClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(0, size.height * 0.75); // Start at the top-left corner

    // Draw a semicircle at the bottom
    path.quadraticBezierTo(
      size.width / 2, size.height, // Control point
      size.width, size.height * 0.75, // End point
    );

    path.lineTo(size.width, 0); // Line to the top-right corner
    path.close(); // Close the path

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}

import 'package:flutter/material.dart';

class HomeContainerClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.moveTo(size.width, size.height * 0.3857957);
    path.cubicTo(
      size.width,
      size.height * 0.3857957,
      size.width * 0.2215100,
      size.height * -0.2855471,
      size.width * 0.02281580,
      size.height * 0.1429686,
    );
    path.cubicTo(
      size.width * -0.1005196,
      size.height * 0.4089614,
      size.width * 0.02281580,
      size.height * 1.028571,
      size.width * 0.02281580,
      size.height * 1.028571,
    );
    path.lineTo(size.width, size.height * 1.028571);
    path.lineTo(size.width, size.height * 0.3857957);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}

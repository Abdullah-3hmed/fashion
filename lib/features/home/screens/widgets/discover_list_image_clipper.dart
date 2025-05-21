import 'package:flutter/material.dart';

class DiscoverListImageClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final Path path = Path();
    path.moveTo(0, 0);
    path.lineTo(size.width, size.height * 0.125);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height * 0.875);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}

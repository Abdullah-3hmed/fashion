import 'package:flutter/material.dart';

class ProfileContainerClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.moveTo(0, size.height * 0.08936507);
    path.cubicTo(
      0,
      size.height * 0.02783511,
      size.width * 0.09579639,
      size.height * -0.01498348,
      size.width * 0.1863822,
      size.height * 0.006056879,
    );
    path.lineTo(size.width * 0.9086056, size.height * 0.1738071);
    path.cubicTo(
      size.width * 0.9634778,
      size.height * 0.1865514,
      size.width,
      size.height * 0.2198440,
      size.width,
      size.height * 0.2571152,
    );
    path.lineTo(size.width, size.height * 0.9468085);
    path.cubicTo(
      size.width,
      size.height * 0.9761862,
      size.width * 0.9626917,
      size.height,
      size.width * 0.9166667,
      size.height,
    );
    path.lineTo(size.width * 0.08333333, size.height);
    path.cubicTo(
      size.width * 0.03730972,
      size.height,
      0,
      size.height * 0.9761862,
      0,
      size.height * 0.9468085,
    );
    path.lineTo(0, size.height * 0.08936507);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}

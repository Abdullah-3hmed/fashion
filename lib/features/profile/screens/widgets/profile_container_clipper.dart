import 'package:flutter/material.dart';

class ProfileContainerClipper extends CustomClipper<Path> {
  final double progress;

  ProfileContainerClipper({required this.progress});

  @override
  Path getClip(Size size) {
    final curvedValue = Curves.easeInOut.transform(progress);

    Path path = Path();

    final startY = lerpDouble(0.08936507, 0.0, curvedValue)!;
    final cp1Y = lerpDouble(0.02783511, 0.0, curvedValue)!;
    final cp1X = lerpDouble(0.09579639, 0.0, curvedValue)!;
    final endX = lerpDouble(0.1863822, 0.0, curvedValue)!;
    final endY = lerpDouble(0.006056879, 0.0, curvedValue)!;

    path.moveTo(0, size.height * startY);
    path.cubicTo(
      0,
      size.height * cp1Y,
      size.width * cp1X,
      size.height * -0.01498348 * (1 - curvedValue),
      size.width * endX,
      size.height * endY,
    );
    path.lineTo(
      size.width * 0.9086056,
      size.height * 0.1738071 * (1 - curvedValue),
    );
    path.cubicTo(
      size.width * 0.9634778,
      size.height * 0.1865514 * (1 - curvedValue),
      size.width,
      size.height * 0.2198440 * (1 - curvedValue),
      size.width,
      size.height * 0.2571152 * (1 - curvedValue),
    );
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.lineTo(0, size.height * startY);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(ProfileContainerClipper oldClipper) {
    return progress != oldClipper.progress;
  }

  double? lerpDouble(num a, num b, double t) {
    return a * (1.0 - t) + b * t;
  }
}

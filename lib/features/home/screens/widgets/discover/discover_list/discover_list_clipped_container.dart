import 'package:flutter/material.dart';

class DiscoverListClippedContainer extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final Path path = Path();
    path.moveTo(size.width, size.height * 0.9982920);
    path.lineTo(0, size.height * 0.6259124);
    path.lineTo(0, size.height * 0.1499699);
    path.cubicTo(
      size.width * 0.1147885,
      size.height * 0.1102903,
      size.width * 0.6953365,
      size.height * -0.07912416,
      size.width,
      size.height * 0.03739274,
    );
    path.lineTo(size.width, size.height * 0.9982920);
    path.close();

    final Paint paintFill =
        Paint()
          ..style = PaintingStyle.fill
          ..color = const Color(0xFF394D5D);

    canvas.drawPath(path, paintFill);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}

import 'dart:ui' as ui;

import 'package:flutter/material.dart';

class DiscoverGridClippedReverseContainer extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    // Flip horizontally
    canvas.translate(size.width, 0);
    canvas.scale(-1.0, 1.0);

    Path path_0 = Path();
    path_0.moveTo(0, size.height * 0.9984315);
    path_0.lineTo(size.width, size.height * 0.7327671);
    path_0.lineTo(size.width, size.height * 0.1762808);
    path_0.cubicTo(
      size.width * 0.8852133,
      size.height * 0.1296410,
      size.width * 0.3046647,
      size.height * -0.09300918,
      0,
      size.height * 0.04395096,
    );
    path_0.lineTo(0, size.height * 0.9984315);
    path_0.close();

    Paint paint0Fill = Paint()..style = PaintingStyle.fill;
    paint0Fill.shader = ui.Gradient.linear(
      Offset(size.width * -5.058947, size.height * 0.1599781),
      Offset(size.width * 1.342553, size.height * 1.325003),
      [Colors.white, const Color(0xff324656)],
      [0, 1],
    );
    canvas.drawPath(path_0, paint0Fill);

    Path path_1 = Path();
    path_1.moveTo(0, size.height * 0.9986219);
    path_1.lineTo(size.width, size.height * 0.7327712);
    path_1.lineTo(size.width, size.height * 0.1762753);
    path_1.cubicTo(
      size.width * 0.8851733,
      size.height * 0.1295866,
      size.width * 0.3042440,
      size.height * -0.09335315,
      0,
      size.height * 0.04427397,
    );
    path_1.lineTo(0, size.height * 0.9986219);
    path_1.close();

    Paint paint1Fill = Paint()..style = PaintingStyle.fill;
    paint1Fill.color = const Color(0xff324656);
    canvas.drawPath(path_1, paint1Fill);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

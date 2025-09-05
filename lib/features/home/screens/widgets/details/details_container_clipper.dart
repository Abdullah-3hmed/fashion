import 'package:flutter/material.dart';

class DetailsContainerClipper extends CustomClipper<Path> {
  final double progress;

  DetailsContainerClipper({this.progress = 0.0});

  @override
  Path getClip(Size size) {
    Path path = Path();
    double startY = lerpDouble(size.height * 0.1110934, 0, progress)!;

    double control1X = lerpDouble(0, 0, progress)!;
    double control1Y = lerpDouble(size.height * 0.04213882, 0, progress)!;
    double control2X = lerpDouble(size.width * 0.07966194, 0, progress)!;
    double control2Y = lerpDouble(size.height * -0.009701031, 0, progress)!;
    double end1X = lerpDouble(size.width * 0.1653986, 0, progress)!;
    double end1Y = lerpDouble(size.height * 0.003460307, 0, progress)!;

    double lineToX = lerpDouble(size.width * 0.8876194, size.width, progress)!;
    double lineToY = lerpDouble(size.height * 0.1143276, 0, progress)!;

    double control3X =
        lerpDouble(size.width * 0.9528833, size.width, progress)!;
    double control3Y = lerpDouble(size.height * 0.1243461, 0, progress)!;
    double control4X = lerpDouble(size.width, size.width, progress)!;
    double control4Y = lerpDouble(size.height * 0.1694728, 0, progress)!;
    double end2Y = lerpDouble(size.height * 0.2219605, 0, progress)!;

    path.moveTo(0, startY);
    path.cubicTo(control1X, control1Y, control2X, control2Y, end1X, end1Y);
    path.lineTo(lineToX, lineToY);
    path.cubicTo(control3X, control3Y, control4X, control4Y, size.width, end2Y);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(covariant DetailsContainerClipper oldClipper) {
    return oldClipper.progress != progress;
  }

  double? lerpDouble(double a, double b, double t) {
    return a + (b - a) * t;
  }
}

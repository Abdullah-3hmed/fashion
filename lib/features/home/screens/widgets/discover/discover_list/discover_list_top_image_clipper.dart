import 'package:flutter/material.dart';
import 'package:path_drawing/path_drawing.dart';

class DiscoverListTopImageClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final String svgPathData =
        'M0 16C0 7.16345 7.16344 0 16 0H296C304.837 0 312 7.16344 312 16V300L0 257.143V16Z';
    Path originalPath = parseSvgPathData(svgPathData);
    Rect originalBounds = originalPath.getBounds();
    Matrix4 matrix4 = Matrix4.identity();
    matrix4.scaleByDouble(
      size.width / originalBounds.width,
      size.height / originalBounds.height,
      1.0,
      1.0,
    );

    return originalPath.transform(matrix4.storage);
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

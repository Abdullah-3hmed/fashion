import 'package:flutter/material.dart';
import 'package:path_drawing/path_drawing.dart';

class DiscoverTopGridClippedImage extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final String svgPathData =
        'M150 0H16C7.16345 0 0 7.16344 0 16V200L150 180V0Z';

    final Path path = parseSvgPathData(svgPathData);
    Rect bounds = path.getBounds();
    Matrix4 matrix4 = Matrix4.identity();
    matrix4.scale(size.width / bounds.width, size.height / bounds.height);

    return path.transform(matrix4.storage);
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => true;
}

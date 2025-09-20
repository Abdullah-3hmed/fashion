import 'package:flutter/material.dart';
import 'package:path_drawing/path_drawing.dart';

class DiscoverGridClippedReverseImage extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    const String svgPathData = 'M150 0L0 20V200L150 180V0Z';

    final Path path = parseSvgPathData(svgPathData);
    Rect bounds = path.getBounds();

    Matrix4 matrix4 =
        Matrix4.identity()
          ..translateByDouble(size.width, 0.0, 0.0, 1.0)
          ..scaleByDouble(
            -size.width / bounds.width,
            size.height / bounds.height,
            1.0,
            1.0,
          );

    return path.transform(matrix4.storage);
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

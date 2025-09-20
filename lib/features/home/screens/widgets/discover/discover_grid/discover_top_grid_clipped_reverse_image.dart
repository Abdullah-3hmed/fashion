import 'package:flutter/material.dart';
import 'package:path_drawing/path_drawing.dart';

class DiscoverTopGridClippedReverseImage extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final String svgPathData =
        'M150 0H16C7.16345 0 0 7.16344 0 16V200L150 180V0Z';

    final Path path = parseSvgPathData(svgPathData);
    Rect bounds = path.getBounds();

    final Matrix4 scaleMatrix =
        Matrix4.identity()..scaleByDouble(
          size.width / bounds.width,
          size.height / bounds.height,
          1.0,
          1.0,
        );

    final Path scaledPath = path.transform(scaleMatrix.storage);

    final Matrix4 flipMatrix =
        Matrix4.identity()
          ..translateByDouble(size.width, 0.0, 0.0, 1.0)
          ..scaleByDouble(-1.0, 1.0, 1.0, 1.0);

    return scaledPath.transform(flipMatrix.storage);
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

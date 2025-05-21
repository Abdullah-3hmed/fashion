import 'package:flutter/material.dart';
import 'package:path_drawing/path_drawing.dart';

class DiscoverTopGridClippedReverseImage extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final String svgPathData =
        'M150 0H16C7.16345 0 0 7.16344 0 16V200L150 180V0Z';

    final Path path = parseSvgPathData(svgPathData);
    Rect bounds = path.getBounds();

    // Scale to fit size
    final Matrix4 scaleMatrix =
        Matrix4.identity()
          ..scale(size.width / bounds.width, size.height / bounds.height);

    // Apply the scale
    final Path scaledPath = path.transform(scaleMatrix.storage);

    // Now apply horizontal flip around center
    final Matrix4 flipMatrix =
        Matrix4.identity()
          ..translate(size.width)
          ..scale(-1.0, 1.0); // Flip X

    return scaledPath.transform(flipMatrix.storage);
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => true;
}

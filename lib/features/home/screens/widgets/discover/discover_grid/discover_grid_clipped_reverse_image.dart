import 'package:flutter/material.dart';
import 'package:path_drawing/path_drawing.dart';

class DiscoverGridClippedReverseImage extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final String svgPathData = 'M150 0L0 20V200L150 180V0Z';

    final Path path = parseSvgPathData(svgPathData);
    Rect bounds = path.getBounds();

    // عكس أفقي (Flip X)
    Matrix4 matrix4 =
        Matrix4.identity()
          ..translate(size.width)
          ..scale(-size.width / bounds.width, size.height / bounds.height);

    return path.transform(matrix4.storage);
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => true;
}

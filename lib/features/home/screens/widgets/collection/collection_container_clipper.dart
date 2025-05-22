import 'package:flutter/material.dart';
import 'package:path_drawing/path_drawing.dart';

class CollectionContainerClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final String svgPathData =
        'M0.000120099 33C0.000120099 33 0.00012207 4.30919e-09 179.5 3.32986e-09C360 2.34507e-09 360 33 360 33V192H0.000120099V33Z';

    Path originalPath = parseSvgPathData(svgPathData);
    Rect originalBounds = originalPath.getBounds();

    Matrix4 matrix4 = Matrix4.identity();
    matrix4.scale(
      size.width / originalBounds.width,
      size.height / originalBounds.height,
    );

    return originalPath.transform(matrix4.storage);
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => true;
}

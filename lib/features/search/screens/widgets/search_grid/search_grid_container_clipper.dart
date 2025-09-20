import 'package:flutter/material.dart';
import 'package:path_drawing/path_drawing.dart';

class SearchGridContainerClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final String svgPathData =
        'M14.7038 1.88979C58.1696 -7.97698 150 24.005 150 24.005V64H0V8.42822C3.77027 5.34986 8.78928 3.23239 14.7038 1.88979Z';

    final Path originalPath = parseSvgPathData(svgPathData);
    final Rect bounds = originalPath.getBounds();

    final Matrix4 matrix4 = Matrix4.identity();
    matrix4.scaleByDouble(
      size.width / bounds.width,
      size.height / bounds.height,
      1.0,
      1.0,
    );

    return originalPath.transform(matrix4.storage);
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

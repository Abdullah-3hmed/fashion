import 'package:flutter/material.dart';
import 'package:path_drawing/path_drawing.dart';

class SearchListContainerClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final String svgPathData =
        'M312 30.3814L312 81H0V10.6671C17.1357 2.15381 46.6729 -0.552919 80.9465 0.0906502C81.4581 0.100256 81.9707 0.110608 82.4843 0.121698C146.174 1.49686 225.696 14.2221 272.457 22.7267C296.592 27.1162 312 30.3814 312 30.3814Z';

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

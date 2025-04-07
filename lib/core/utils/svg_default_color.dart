import 'package:flutter/material.dart';

ColorFilter svgColor(BuildContext context) => ColorFilter.mode(
  Theme.of(context).colorScheme.onPrimaryContainer,
  BlendMode.srcIn,
);

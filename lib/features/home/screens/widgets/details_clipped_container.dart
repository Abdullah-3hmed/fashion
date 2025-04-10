import 'package:e_fashion_flutter/features/home/screens/widgets/details_container_clipper.dart';
import 'package:flutter/material.dart';

class DetailsClippedContainer extends StatelessWidget {
  const DetailsClippedContainer({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: DetailsContainerClipper(),
      child: Container(
        height: 466.0,
        color: Theme.of(context).colorScheme.onInverseSurface,
        width: double.infinity,
        child: child,
      ),
    );
  }
}

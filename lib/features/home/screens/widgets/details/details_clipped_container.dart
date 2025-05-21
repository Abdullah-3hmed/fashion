import 'package:e_fashion_flutter/features/home/screens/widgets/details/details_container_clipper.dart';
import 'package:flutter/material.dart';

class DetailsClippedContainer extends StatelessWidget {
  const DetailsClippedContainer({
    super.key,
    required this.child,
    required this.isClipped,
  });

  final Widget child;
  final bool isClipped;

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: isClipped ? DetailsContainerClipper() : null,
      child:
          isClipped
              ? AnimatedContainer(
                duration: const Duration(milliseconds: 900),
                curve: Curves.easeInOut,
                width: double.infinity,
                color: Theme.of(context).colorScheme.onInverseSurface,
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: child,
              )
              : AnimatedContainer(
                duration: const Duration(milliseconds: 900),
                curve: Curves.easeInOut,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.onInverseSurface,
                  borderRadius: const BorderRadiusDirectional.only(
                    topEnd: Radius.circular(32.0),
                    topStart: Radius.circular(32.0),
                  ),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: child,
              ),
    );
  }
}

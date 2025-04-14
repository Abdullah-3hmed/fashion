import 'package:e_fashion_flutter/features/profile/screens/widgets/profile_container_clipper.dart';
import 'package:flutter/material.dart';

class ProfileClippedContainer extends StatelessWidget {
  const ProfileClippedContainer({
    super.key,
    required this.child,
    this.isClipped = true,
  });

  final Widget child;
  final bool isClipped;

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: isClipped ? ProfileContainerClipper() : null,
      child:
          isClipped
              ? AnimatedContainer(
                duration: const Duration(milliseconds: 600),
                curve: Curves.easeInOut,
                width: double.infinity,
                color: Theme.of(context).colorScheme.onInverseSurface,
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: child,
              )
              : AnimatedContainer(
                duration: const Duration(milliseconds: 600),
                curve: Curves.easeInOut,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.onInverseSurface,
                  borderRadius: BorderRadiusDirectional.only(
                    topEnd: Radius.circular(isClipped ? 0.0 : 32.0),
                    topStart: Radius.circular(isClipped ? 0.0 : 32.0),
                  ),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: child,
              ),
    );
  }
}

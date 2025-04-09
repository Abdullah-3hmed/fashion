import 'package:e_fashion_flutter/features/profile/screens/widgets/profile_container_clipper.dart';
import 'package:flutter/material.dart';

class ProfileClippedContainer extends StatelessWidget {
  const ProfileClippedContainer({
    super.key,
    // required this.height,
    required this.child,
  });
  // final double height;
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: ProfileContainerClipper(),
      child: Container(
        height: 585.0,
        width: MediaQuery.sizeOf(context).width,
        color: Theme.of(context).colorScheme.onInverseSurface,
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: child,
      ),
    );
  }
}

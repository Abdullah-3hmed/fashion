import 'package:e_fashion_flutter/features/auth_feature/screens/widgets/auth_container_clipper.dart';
import 'package:flutter/material.dart';

class AuthClippedContainer extends StatelessWidget {
  const AuthClippedContainer({super.key, this.height, required this.child});
  final double? height;
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: AuthContainerClipper(),
      child: Container(
        height: height,
        width: MediaQuery.sizeOf(context).width,
        color: Theme.of(context).colorScheme.onInverseSurface,
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: child,
      ),
    );
  }
}

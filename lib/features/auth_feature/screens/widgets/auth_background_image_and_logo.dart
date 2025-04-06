import 'dart:ui';

import 'package:e_fashion_flutter/core/utils/assets_manager.dart';
import 'package:e_fashion_flutter/features/auth_feature/screens/widgets/auth_clipped_container.dart';
import 'package:flutter/material.dart';

class AuthBackgroundImageAndLogo extends StatelessWidget {
  const AuthBackgroundImageAndLogo({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: Stack(
        children: [
          ImageFiltered(
            imageFilter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
            child: const Image(image: AssetImage(AssetsManager.welcomeImage)),
          ),
          const PositionedDirectional(
            top: 80.0,
            start: 0.0,
            end: 0.0,
            child: Image(
              width: 180.0,
              height: 226.0,
              image: AssetImage(AssetsManager.appLogo),
            ),
          ),
          PositionedDirectional(
            bottom: 0.0,
            child: AuthClippedContainer(height: 540.0, child: child),
          ),
        ],
      ),
    );
  }
}

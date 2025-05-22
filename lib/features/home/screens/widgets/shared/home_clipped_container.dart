import 'package:e_fashion_flutter/features/home/screens/widgets/shared/home_container_clipper.dart';
import 'package:flutter/material.dart';

class HomeClippedContainer extends StatelessWidget {
  const HomeClippedContainer({super.key, required this.child});
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: HomeContainerClipper(),
      child: Container(
        height: 75.0,
        width: double.infinity,
        decoration: const BoxDecoration(
          color: Color(0xFF203343),
          borderRadius: BorderRadiusDirectional.only(
            bottomStart: Radius.circular(16.0),
            bottomEnd: Radius.circular(16.0),
          ),
        ),
        child: child,
      ),
    );
  }
}

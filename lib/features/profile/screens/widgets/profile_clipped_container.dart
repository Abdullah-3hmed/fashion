import 'package:flutter/material.dart';
import 'package:e_fashion_flutter/features/profile/screens/widgets/profile_container_clipper.dart';

class ProfileClippedContainer extends StatefulWidget {
  const ProfileClippedContainer({
    super.key,
    required this.child,
    required this.isClipped,
  });

  final Widget child;
  final bool isClipped;

  @override
  State<ProfileClippedContainer> createState() => _ProfileClippedContainerState();
}

class _ProfileClippedContainerState extends State<ProfileClippedContainer>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  bool _oldIsClipped = true;

  @override
  void initState() {
    super.initState();
    _oldIsClipped = widget.isClipped;
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    );
    _animation = CurvedAnimation(parent: _controller, curve: Curves.easeInOut);

    if (!widget.isClipped) {
      _controller.forward();
    }
  }

  @override
  void didUpdateWidget(covariant ProfileClippedContainer oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isClipped != _oldIsClipped) {
      _oldIsClipped = widget.isClipped;
      if (widget.isClipped) {
        _controller.reverse();
      } else {
        _controller.forward();
      }
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      child: widget.child,
      builder: (context, child) {
        return ClipPath(
          clipper: ProfileContainerClipper(progress: _animation.value),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 600),
            curve: Curves.easeInOut,
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            decoration: widget.isClipped
                ? null
                : BoxDecoration(
              color: Theme.of(context).colorScheme.onInverseSurface,
              borderRadius: const BorderRadiusDirectional.only(
                topEnd: Radius.circular(32.0),
                topStart: Radius.circular(32.0),
              ),
            ),
            color: widget.isClipped
                ? Theme.of(context).colorScheme.onInverseSurface
                : null,
            child: child,
          ),
        );
      },
    );
  }
}

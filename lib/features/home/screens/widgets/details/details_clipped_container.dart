import 'package:flutter/material.dart';
import 'package:e_fashion_flutter/features/home/screens/widgets/details/details_container_clipper.dart';

class DetailsClippedContainer extends StatefulWidget {
  const DetailsClippedContainer({
    super.key,
    required this.child,
    required this.isClipped,
  });

  final Widget child;
  final bool isClipped;

  @override
  State<DetailsClippedContainer> createState() =>
      _DetailsClippedContainerState();
}

class _DetailsClippedContainerState extends State<DetailsClippedContainer>
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
  void didUpdateWidget(covariant DetailsClippedContainer oldWidget) {
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
          clipper: DetailsContainerClipper(progress: _animation.value),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 900),
            curve: Curves.easeInOut,
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            decoration:
                widget.isClipped
                    ? null
                    : BoxDecoration(
                      color: Theme.of(context).colorScheme.onInverseSurface,
                      borderRadius: const BorderRadiusDirectional.only(
                        topEnd: Radius.circular(32.0),
                        topStart: Radius.circular(32.0),
                      ),
                    ),
            color:
                widget.isClipped
                    ? Theme.of(context).colorScheme.onInverseSurface
                    : null,
            child: child,
          ),
        );
      },
    );
  }
}

import 'package:flutter/material.dart';

class SlideFromBottomAnimation extends StatefulWidget {
  const SlideFromBottomAnimation({super.key, required this.child});

  final Widget child;

  @override
  State<SlideFromBottomAnimation> createState() =>
      _SlideFromBottomAnimationState();
}

class _SlideFromBottomAnimationState extends State<SlideFromBottomAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0.0, 1.0),
      end: Offset.zero, // يثبت في مكانه
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SlideTransition(position: _slideAnimation, child: widget.child);
  }
}

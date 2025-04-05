import 'package:flutter/material.dart';

class FadeThenSpinAnimation extends StatefulWidget {
  const FadeThenSpinAnimation({
    super.key,
    required this.child,
    this.fadeDuration,
    this.spinDuration,
  });

  final Widget child;
  final Duration? fadeDuration;
  final Duration? spinDuration;

  @override
  State<FadeThenSpinAnimation> createState() => _FadeThenSpinAnimationState();
}

class _FadeThenSpinAnimationState extends State<FadeThenSpinAnimation>
    with TickerProviderStateMixin {
  late AnimationController _fadeController;
  late Animation<double> _fadeAnimation;

  late AnimationController _spinController;

  bool _showSpin = false;

  @override
  void initState() {
    super.initState();

    // Fade animation setup
    _fadeController = AnimationController(
      duration: widget.fadeDuration ?? const Duration(seconds: 3),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _fadeController, curve: Curves.easeIn));

    // Spin animation setup
    _spinController = AnimationController(
      duration: widget.spinDuration ?? const Duration(seconds: 3),
      vsync: this,
    );

    // Start fade first
    _fadeController.forward().whenComplete(() {
      setState(() => _showSpin = true);
      _spinController.repeat();
    });
  }

  @override
  void dispose() {
    _fadeController.dispose();
    _spinController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Widget content = widget.child;

    if (_showSpin) {
      content = RotationTransition(turns: _spinController, child: content);
    }

    return FadeTransition(opacity: _fadeAnimation, child: content);
  }
}

import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class CartIconAnimated extends StatefulWidget {
  final VoidCallback onTap;
  final bool isSelected;

  const CartIconAnimated({
    super.key,
    required this.onTap,
    required this.isSelected,
  });

  @override
  State<CartIconAnimated> createState() => CartIconAnimatedState();
}

class CartIconAnimatedState extends State<CartIconAnimated> {
  final ValueNotifier<bool> _showBadge = ValueNotifier(false);
  final ValueNotifier<double> _leftPosition = ValueNotifier(0);

  void triggerAnimation() {
    _showBadge.value = true;
    _leftPosition.value = 3;

    Future.delayed(const Duration(milliseconds: 500), () {
      if (mounted) {
        _leftPosition.value = 28;
      }
    });

    Future.delayed(const Duration(seconds: 1), () {
      if (mounted) {
        _showBadge.value = false;
        _leftPosition.value = 3;
      }
    });
  }

  @override
  void dispose() {
    _showBadge.dispose();
    _leftPosition.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        IconButton(
          onPressed: widget.onTap,
          icon: Icon(
            Iconsax.bag_2,
            color:
                widget.isSelected
                    ? Theme.of(context).colorScheme.primary
                    : Colors.white,
          ),
        ),
        ValueListenableBuilder<bool>(
          valueListenable: _showBadge,
          builder: (_, show, __) {
            if (!show) return const SizedBox.shrink();
            return ValueListenableBuilder<double>(
              valueListenable: _leftPosition,
              child: CircleAvatar(
                backgroundColor: Colors.red,
                radius: 10.0,
                child: Text(
                  '1',
                  style: Theme.of(context).textTheme.bodySmall!.copyWith(
                    fontWeight: FontWeight.w800,
                    color: Colors.white,
                  ),
                ),
              ),
              builder: (_, left, child) {
                return AnimatedPositionedDirectional(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeIn,
                  top: 5.0,
                  start: left,
                  child: child!,
                );
              },
            );
          },
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class CartIconAnimated extends StatefulWidget {
  final VoidCallback onTap;
  final bool isSelected;
  final int length;

  const CartIconAnimated({
    super.key,
    required this.onTap,
    required this.isSelected,
    required this.length,
  });

  @override
  State<CartIconAnimated> createState() => CartIconAnimatedState();
}

class CartIconAnimatedState extends State<CartIconAnimated> {
  final ValueNotifier<double> _leftPosition = ValueNotifier(0);

  void triggerAnimation() {
    _leftPosition.value = 5;

    Future.delayed(const Duration(milliseconds: 500), () {
      if (mounted) {
        _leftPosition.value = 25;
      }
    });
  }

  @override
  void dispose() {
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
        ValueListenableBuilder<double>(
          valueListenable: _leftPosition,
          child: widget.length > 0 ? CircleAvatar(
            backgroundColor: Colors.red,
            radius: 10.0,
            child: Text(
              widget.length.toString(),
              style: Theme.of(context).textTheme.bodySmall!.copyWith(
                fontWeight: FontWeight.w800,
                color: Colors.white,
              ),
            ),
          ):const SizedBox.shrink(),
          builder: (_, left, child) {
            return AnimatedPositionedDirectional(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeIn,
              top: 5.0,
              start: left,
              child: child!,
            );
          },
        ),
      ],
    );
  }
}

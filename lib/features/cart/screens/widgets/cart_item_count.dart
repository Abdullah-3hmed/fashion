import 'package:flutter/material.dart';
import 'package:solar_icons/solar_icons.dart';

class CartItemCounter extends StatefulWidget {
  const CartItemCounter({
    super.key,
    required this.onChanged,
    required this.numberOfPieces,
  });

  final ValueChanged<int> onChanged;
  final int numberOfPieces;

  @override
  State<CartItemCounter> createState() => _CartItemCounterState();
}

class _CartItemCounterState extends State<CartItemCounter> {
  late final ValueNotifier<int> _count;

  @override
  void initState() {
    super.initState();
    _count = ValueNotifier<int>(widget.numberOfPieces);
  }
  @override
  void didUpdateWidget(covariant CartItemCounter oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.numberOfPieces != widget.numberOfPieces) {
      _count.value = widget.numberOfPieces;
    }
  }

  @override
  void dispose() {
    _count.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<int>(
      valueListenable: _count,
      builder: (context, value, _) {
        return Row(
          children: [
            IconButton(
              padding: EdgeInsets.zero,
              onPressed: () {
                if (value > 1) {
                  _count.value = value - 1;
                  widget.onChanged(_count.value);
                }
              },
              icon: const Icon(SolarIconsOutline.minusCircle),
            ),
            Text(
              "$value",
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            IconButton(
              padding: EdgeInsets.zero,
              onPressed: () {
                _count.value = value + 1;
                widget.onChanged(_count.value);
              },
              icon: const Icon(SolarIconsOutline.addCircle),
            ),
          ],
        );
      },
    );
  }
}

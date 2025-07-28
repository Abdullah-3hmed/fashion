import 'package:flutter/material.dart';
import 'package:solar_icons/solar_icons.dart';

class PiecesAvailable extends StatefulWidget {
  const PiecesAvailable({super.key, required this.onPiecesChanged});

  final ValueChanged<int> onPiecesChanged;

  @override
  State<PiecesAvailable> createState() => _PiecesAvailableState();
}

class _PiecesAvailableState extends State<PiecesAvailable> {
  final ValueNotifier<int> _pieces = ValueNotifier<int>(1);

  @override
  void dispose() {
    _pieces.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          "10 Pieces available",
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        ValueListenableBuilder<int>(
          valueListenable: _pieces,
          builder: (context, value, _) {
            return Row(
              children: [
                IconButton(
                  padding: EdgeInsets.zero,
                  onPressed: () {
                    if (value > 1) {
                      _pieces.value = value - 1;
                      widget.onPiecesChanged(_pieces.value);
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
                    if (value < 10) {
                      _pieces.value = value + 1;
                      widget.onPiecesChanged(_pieces.value);
                    }
                  },
                  icon: const Icon(SolarIconsOutline.addCircle),
                ),
              ],
            );
          },
        ),
      ],
    );
  }
}

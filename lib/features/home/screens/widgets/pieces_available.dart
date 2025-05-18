import 'package:flutter/material.dart';
import 'package:solar_icons/solar_icons.dart';

class PiecesAvailable extends StatefulWidget {
  const PiecesAvailable({super.key, required this.onPiecesChanged});
  final ValueChanged<int> onPiecesChanged;
  @override
  State<PiecesAvailable> createState() => _PiecesAvailableState();
}

class _PiecesAvailableState extends State<PiecesAvailable> {
  int _pieces = 1;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          "10 Pieces available",
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        IconButton(
          padding: EdgeInsets.zero,
          onPressed: () {
            if (_pieces > 1) {
              setState(() {
                _pieces--;
              });
              widget.onPiecesChanged(_pieces);
            }
          },
          icon: const Icon(SolarIconsOutline.minusCircle),
        ),
        Text("$_pieces", style: Theme.of(context).textTheme.bodyLarge),
        IconButton(
          padding: EdgeInsets.zero,
          onPressed: () {
            if (_pieces < 10) {
              setState(() {
                _pieces++;
              });
              widget.onPiecesChanged(_pieces);
            }
          },
          icon: const Icon(SolarIconsOutline.addCircle),
        ),
      ],
    );
  }
}

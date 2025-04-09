import 'package:flutter/material.dart';
import 'package:solar_icons/solar_icons.dart';

class DetailsPiecesAvailable extends StatefulWidget {
  const DetailsPiecesAvailable({super.key});

  @override
  State<DetailsPiecesAvailable> createState() => _DetailsPiecesAvailableState();
}

class _DetailsPiecesAvailableState extends State<DetailsPiecesAvailable> {
  int _pieces = 1;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          "20 Pieces available",
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        IconButton(
          padding: EdgeInsets.zero,
          onPressed: () {
            if (_pieces > 1) {
              setState(() {
                _pieces--;
              });
            }
          },
          icon: const Icon(SolarIconsOutline.minusCircle),
        ),
        Text("$_pieces", style: Theme.of(context).textTheme.bodyLarge),
        IconButton(
          padding: EdgeInsets.zero,
          onPressed: () {
            if (_pieces < 20) {
              setState(() {
                _pieces++;
              });
            }
          },
          icon: const Icon(SolarIconsOutline.addCircle),
        ),
      ],
    );
  }
}

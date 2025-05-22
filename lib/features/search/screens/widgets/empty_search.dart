import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class EmptySearch extends StatelessWidget {
  const EmptySearch({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Spacer(),
        Icon(
          Iconsax.close_circle,
          size: 80.0,
          color: Theme.of(context).colorScheme.primary,
        ),
        const SizedBox(height: 16.0),
        Text(
          "We couldn't find \n any products ",
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.bodySmall,
        ),
        const Spacer(),
      ],
    );
  }
}

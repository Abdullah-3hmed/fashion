import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class NoResultSearchSection extends StatelessWidget {
  const NoResultSearchSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Spacer(),
        Icon(
          Iconsax.search_normal_1,
          size: 80.0,
          color: Theme.of(context).colorScheme.primary,
        ),
        const SizedBox(height: 16.0),
        Text(
          "No result yet \n try to type something",
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.bodySmall,
        ),
        const Spacer(),
      ],
    );
  }
}

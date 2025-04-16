import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class NoFavoriteItems extends StatelessWidget {
  const NoFavoriteItems({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Iconsax.heart,
            size: 120.0,
            color: Theme.of(context).colorScheme.primary,
          ),
          Text(
            "No current \n favourites items",
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 12.0),
          Text(
            "Select your favourite \n item to add it",
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.titleSmall,
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class NoItemsInCart extends StatelessWidget {
  const NoItemsInCart({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Iconsax.bag_2,
            size: 120.0,
            color: Theme.of(context).colorScheme.primary,
          ),
          const SizedBox(height: 12.0),
          Text(
            "No items in the \n shopping bag",
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 12.0),
          Text(
            "Select the product you \n want to purchase",
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.titleSmall,
          ),
        ],
      ),
    );
  }
}

import 'package:e_fashion_flutter/core/utils/assets_manager.dart';
import 'package:e_fashion_flutter/features/cart/screens/widgets/cart_item_count.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class CartItem extends StatelessWidget {
  const CartItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      direction: DismissDirection.endToStart,
      background: Container(
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 24.0),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.error,
          borderRadius: BorderRadius.circular(16.0),
        ),
        child: const Icon(Iconsax.trash, color: Colors.white, size: 28.0),
      ),
      onDismissed: (direction) {
        print("Item deleted");
      },
      key: UniqueKey(),
      child: Container(
        padding: const EdgeInsetsDirectional.symmetric(
          horizontal: 8.0,
          vertical: 10.0,
        ),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surfaceContainerHighest,
          borderRadius: BorderRadiusDirectional.circular(16.0),
        ),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadiusDirectional.circular(16.0),
              child: Image.asset(
                AssetsManager.welcomeImage,
                width: 90.0,
                height: 100.0,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(width: 24.0),
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Denim Jacket",
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: 4.0),
                Text("Size : XL", style: Theme.of(context).textTheme.bodySmall),
                const SizedBox(height: 4.0),
                Row(
                  children: [
                    Text("Color", style: Theme.of(context).textTheme.bodySmall),
                    const SizedBox(width: 8.0),
                    const CircleAvatar(
                      radius: 6.0,
                      backgroundColor: Colors.black,
                    ),
                  ],
                ),
                Row(
                  children: [
                    Text(r"$200", style: Theme.of(context).textTheme.bodySmall),
                    const SizedBox(width: 16.0),
                    CartItemCounter(onPiecesChanged: (int value) {}),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

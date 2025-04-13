import 'package:e_fashion_flutter/core/utils/assets_manager.dart';
import 'package:flutter/material.dart';

class OrderItem extends StatelessWidget {
  const OrderItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120.0,
      padding: const EdgeInsetsDirectional.symmetric(
        horizontal: 8.0,
        vertical: 10.0,
      ),
      margin: const EdgeInsetsDirectional.symmetric(
        horizontal: 24.0,
        vertical: 16.0,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16.0),
        color: Theme.of(context).colorScheme.surfaceContainerHighest,
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(16.0),
            clipBehavior: Clip.antiAliasWithSaveLayer,
            child: Image.asset(
              width: 90.0,
              height: 100.0,
              fit: BoxFit.cover,
              AssetsManager.welcomeImage,
            ),
          ),
          const SizedBox(width: 24.0),
          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Black jacket",
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 4.0),
              Text("Size : XL", style: Theme.of(context).textTheme.bodySmall),
              const SizedBox(height: 16.0),
              Text(r"$200.00", style: Theme.of(context).textTheme.bodySmall),
            ],
          ),
          const Spacer(),
          Align(
            alignment: AlignmentDirectional.bottomEnd,
            child: Text(
              "On progress",
              style: Theme.of(context).textTheme.bodySmall!.copyWith(
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

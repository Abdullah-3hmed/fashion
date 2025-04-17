import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class NotificationMessageItem extends StatelessWidget {
  const NotificationMessageItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsetsDirectional.symmetric(
        horizontal: 16.0,
        vertical: 8.0,
      ),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadiusDirectional.circular(8.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "05:43 PM",
            style: Theme.of(context).textTheme.labelSmall!.copyWith(
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
          const SizedBox(height: 24.0),
          Row(
            children: [
              Icon(
                Iconsax.message,
                color: Theme.of(context).colorScheme.primary,
              ),
              const SizedBox(width: 10.0),
              Expanded(
                child: Text(
                  "You are welcome",
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

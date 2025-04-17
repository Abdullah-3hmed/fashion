import 'package:e_fashion_flutter/core/utils/assets_manager.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class NotificationOrderStateItem extends StatelessWidget {
  const NotificationOrderStateItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsetsDirectional.symmetric(
            horizontal: 16.0,
            vertical: 8.0,
          ),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surfaceContainerHighest,
            borderRadius: BorderRadiusDirectional.circular(8.0),
          ),
          child: Row(
            children: [
              Image.asset(
                height: 80.0,
                width: 120.0,
                fit: BoxFit.cover,
                AssetsManager.onItsWayImage,
              ),
              const SizedBox(width: 10.0),
              Column(
                children: [
                  Text(
                    "Order #54673",
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  const SizedBox(height: 8.0),
                  Text(
                    "your Order on its \n way",
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.labelSmall,
                  ),
                ],
              ),
              const Spacer(),
              const Icon(
                FontAwesomeIcons.circleCheck,
                color: Colors.greenAccent,
              ),
            ],
          ),
        ),
        const SizedBox(height: 4.0),
        Text(
          "05:43 PM",
          style: Theme.of(context).textTheme.labelSmall!.copyWith(
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
      ],
    );
  }
}

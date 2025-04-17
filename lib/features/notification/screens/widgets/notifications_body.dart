import 'package:e_fashion_flutter/features/notification/screens/widgets/notification_message_item.dart';
import 'package:e_fashion_flutter/features/notification/screens/widgets/notification_order_state_item.dart';
import 'package:flutter/material.dart';

class NotificationsBody extends StatelessWidget {
  const NotificationsBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsetsDirectional.symmetric(
        horizontal: 24.0,
        vertical: 16.0,
      ),
      child: Column(
        children: [
          Text(
            "You received a message fom chat support ",
            style: Theme.of(context).textTheme.labelSmall!.copyWith(
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
          const SizedBox(height: 16.0),
          const NotificationMessageItem(),
          const SizedBox(height: 16.0),
          const NotificationOrderStateItem(),
        ],
      ),
    );
  }
}

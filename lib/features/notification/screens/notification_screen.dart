import 'package:auto_route/auto_route.dart';
import 'package:e_fashion_flutter/features/notification/screens/widgets/notifications_body.dart';
import 'package:flutter/material.dart';

@RoutePage()
class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Notifications",
          style: Theme.of(context).textTheme.titleMedium,
        ),
      ),
      body: const NotificationsBody(),
    );
  }
}

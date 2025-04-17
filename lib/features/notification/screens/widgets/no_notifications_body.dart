import 'package:e_fashion_flutter/core/utils/assets_manager.dart';
import 'package:flutter/material.dart';

class NoNotificationsBody extends StatelessWidget {
  const NoNotificationsBody({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(AssetsManager.noNotificationsImage),
          const SizedBox(height: 24.0),
          Text(
            "No notifications yet",
            style: Theme.of(context).textTheme.titleMedium,
          ),
        ],
      ),
    );
  }
}

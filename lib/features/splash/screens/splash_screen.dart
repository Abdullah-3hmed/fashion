import 'package:auto_route/auto_route.dart';
import 'package:e_fashion_flutter/core/notifications/fcm_init_helper.dart';
import 'package:e_fashion_flutter/features/splash/screens/widgets/splash_screen_body.dart';
import 'package:flutter/material.dart';

@RoutePage()
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _checkNotificationPermission();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: SplashScreenBody());
  }

  void _checkNotificationPermission() async {
    bool isAllowed = await FcmInitHelper.isNotificationAllowed();
    if (!isAllowed && mounted) {
      showDialog(
        context: context,
        builder:
            (ctx) => AlertDialog(
              title: const Text("Allow Notifications"),
              content: const Text(
                "Would you like to enable notifications for this app?",
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(ctx).pop(),
                  child: Text(
                    "No Thanks",
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () async {
                    Navigator.of(ctx).pop();
                    await FcmInitHelper.requestPermission();
                  },
                  child: Text(
                    "Yes",
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                ),
              ],
            ),
      );
    }
  }
}

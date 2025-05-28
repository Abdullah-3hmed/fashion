import 'package:auto_route/auto_route.dart';
import 'package:e_fashion_flutter/config/router/app_router.dart';
import 'package:e_fashion_flutter/core/notifications/fcm_init_helper.dart';
import 'package:e_fashion_flutter/core/services/service_locator.dart';
import 'package:e_fashion_flutter/features/splash/screens/widgets/splash_screen_body.dart';
import 'package:e_fashion_flutter/shared/app_cubit/app_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await FcmInitHelper.initFirebaseMessagingListeners();
      await FcmInitHelper.setAwesomeNotificationListeners();
      await _handleInitialMessage();
    });
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
                  onPressed: () {
                    Navigator.of(ctx).pop();
                    context.read<AppCubit>().toggleNotifications(
                      areNotificationsEnabled: false,
                    );
                  },
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
                    await FcmInitHelper.requestPermission().then((value) {
                      if (mounted) {
                        context.read<AppCubit>().toggleNotifications(
                          areNotificationsEnabled: value,
                        );
                      }
                    });
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

  Future<void> _handleInitialMessage() async {
    final message = await FcmInitHelper.firebaseMessaging.getInitialMessage();
    if (message != null) {
      await getIt<AppRouter>().replaceAll([
        const AuthenticatedRoute(children: [LayoutRoute()]),
      ]);
      getIt<AppRouter>().push(const ChatSupportRoute());
    }
  }
}

import 'package:e_fashion_flutter/core/notifications/fcm_init_helper.dart';
import 'package:e_fashion_flutter/shared/app_cubit/app_state.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:permission_handler/permission_handler.dart';

class AppCubit extends HydratedCubit<AppState> {
  AppCubit() : super(const AppState());

  void toggleTheme() {
    emit(state.copyWith(isDarkMode: !state.isDarkMode));
  }

  void toggleNotifications({required bool areNotificationsEnabled}) async {
    emit(state.copyWith(areNotificationsEnabled: areNotificationsEnabled));
    if (!areNotificationsEnabled) {
      await FcmInitHelper.disableNotifications();
    } else {
      await FcmInitHelper.enableNotifications();
    }
  }

  Future<void> syncNotificationStatusWithSystem() async {
    final bool isAllowed =  await FcmInitHelper.isNotificationAllowed();
    emit(state.copyWith(areNotificationsEnabled: isAllowed));
    if (!isAllowed) {
      await FcmInitHelper.disableNotifications();
    } else {
      await FcmInitHelper.enableNotifications();
    }
  }

  Future<void> toggleNotificationsStatus({required bool value}) async {
    if (value) {
      final isAllowed = await FcmInitHelper.isNotificationAllowed();
      if (!isAllowed) {
        await openAppSettings();
        final newStatus = await FcmInitHelper.isNotificationAllowed();
        toggleNotifications(areNotificationsEnabled: newStatus);
      } else {
        toggleNotifications(areNotificationsEnabled: true);
      }
    } else {
      toggleNotifications(areNotificationsEnabled: false);
    }
  }

  @override
  AppState? fromJson(Map<String, dynamic> json) {
    return AppState(
      isDarkMode: json["is_dark_mode"] ?? false,
      areNotificationsEnabled: json["are_notifications_enabled"] ?? true,
    );
  }

  @override
  Map<String, dynamic>? toJson(AppState state) {
    return {
      "is_dark_mode": state.isDarkMode,
      "are_notifications_enabled": state.areNotificationsEnabled,
    };
  }
}

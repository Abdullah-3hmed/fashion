import 'package:e_fashion_flutter/core/notifications/fcm_init_helper.dart';
import 'package:e_fashion_flutter/shared/app_cubit/app_state.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

class AppCubit extends HydratedCubit<AppState> {
  AppCubit() : super(const AppState());

  void toggleTheme() {
    emit(state.copyWith(isDarkMode: !state.isDarkMode));
  }

  void toggleNotifications({required bool areNotificationsEnabled}) async {
    if (!areNotificationsEnabled) {
      await FcmInitHelper.disableNotification();
    } else {
      await FcmInitHelper.enableNotification();
    }

    emit(state.copyWith(areNotificationsEnabled: areNotificationsEnabled));
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

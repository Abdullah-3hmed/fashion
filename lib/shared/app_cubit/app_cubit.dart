import 'package:e_fashion_flutter/core/notifications/fcm_init_helper.dart';
import 'package:e_fashion_flutter/shared/app_cubit/app_state.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';

class AppCubit extends HydratedCubit<AppState> {
  AppCubit() : super(const AppState()){
    Future.microtask(() {
      _listenToConnectivity();
    });
  }

  void toggleTheme() {
    emit(state.copyWith(isDarkMode: !state.isDarkMode));
  }

  Future<void> toggleNotifications({required bool isNotificationAllowed}) async {
    emit(
      state.copyWith(
        areNotificationsEnabled: isNotificationAllowed,
        hasPendingNotificationUpdate: true,
      ),
    );
   await _syncNotificationStatus();
  }

  Future<void> _syncNotificationStatus() async {
    if (!state.hasPendingNotificationUpdate) return;
    final connectivity = await InternetConnection().hasInternetAccess;
    if (connectivity == false) return;

    try {
      if (state.areNotificationsEnabled) {
      //  final token = await FcmInitHelper.getFcmToken();
        //await FcmInitHelper.sendTokenToServer(token);
      } else {
       // await FcmInitHelper.sendTokenToServer("");
      }
      emit(state.copyWith(hasPendingNotificationUpdate: false));
    } catch (_) {

      emit(state.copyWith(hasPendingNotificationUpdate: true));
    }
  }

  void _listenToConnectivity() {
    InternetConnection().onStatusChange.listen((InternetStatus status) {
      if (status != InternetStatus.disconnected){
        _syncNotificationStatus();
      }
    });
  }

  @override
  AppState? fromJson(Map<String, dynamic> json) {
    return AppState(
      isDarkMode: json["is_dark_mode"] ?? false,
      areNotificationsEnabled: json["are_notifications_enabled"] ?? false,
      hasPendingNotificationUpdate: json["has_pending_notification_update"] ?? false,
    );
  }

  @override
  Map<String, dynamic>? toJson(AppState state) {
    return {
      "is_dark_mode": state.isDarkMode,
      "are_notifications_enabled": state.areNotificationsEnabled,
      "has_pending_notification_update": state.hasPendingNotificationUpdate,
    };
  }
}

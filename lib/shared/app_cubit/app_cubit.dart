import 'package:dartz/dartz.dart';
import 'package:e_fashion_flutter/core/error/failures.dart';
import 'package:e_fashion_flutter/core/notifications/fcm_init_helper.dart';
import 'package:e_fashion_flutter/core/utils/app_constants.dart';
import 'package:e_fashion_flutter/features/notification/repo/notification_repo.dart';
import 'package:e_fashion_flutter/shared/app_cubit/app_state.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';

class AppCubit extends HydratedCubit<AppState> {
  final NotificationRepo notificationRepo;

  AppCubit({required this.notificationRepo}) : super(const AppState()) {
    Future.microtask(() {
      _listenToConnectivity();
    });
  }

  void toggleTheme() {
    emit(state.copyWith(isDarkMode: !state.isDarkMode));
  }

  Future<void> toggleNotifications({
    required bool isNotificationAllowed,
  }) async {
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
    if (connectivity == false || AppConstants.token.isEmpty) return;

    if (state.areNotificationsEnabled) {
      final token = await FcmInitHelper.getFcmToken();
      final result = await notificationRepo.toggleNotification(
        fcmToken: token ?? "",
      );
      _handleResult(result);
    } else {
      final result = await notificationRepo.toggleNotification(fcmToken: "");
      _handleResult(result);
    }
  }

  void _listenToConnectivity() {
    InternetConnection().onStatusChange.listen((InternetStatus status) {
      if (status != InternetStatus.disconnected) {
        _syncNotificationStatus();
      }
    });
  }

  void _handleResult(Either<Failure, void> result) {
    result.fold(
      (failure) => emit(state.copyWith(hasPendingNotificationUpdate: true)),
      (_) => emit(state.copyWith(hasPendingNotificationUpdate: false)),
    );
  }

  @override
  AppState? fromJson(Map<String, dynamic> json) {
    return AppState(
      isDarkMode: json["is_dark_mode"] ?? false,
      areNotificationsEnabled: json["are_notifications_enabled"] ?? false,
      hasPendingNotificationUpdate:
          json["has_pending_notification_update"] ?? false,
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

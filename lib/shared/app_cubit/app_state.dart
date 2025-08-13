import 'package:equatable/equatable.dart';

class AppState extends Equatable {
  final bool isDarkMode;
  final bool areNotificationsEnabled;
  final bool hasPendingNotificationUpdate;

  const AppState({
    this.isDarkMode = false,
    this.areNotificationsEnabled = false,
    this.hasPendingNotificationUpdate = false,
  });

  AppState copyWith({bool? isDarkMode, bool? areNotificationsEnabled, bool? hasPendingNotificationUpdate}) {
    return AppState(
      isDarkMode: isDarkMode ?? this.isDarkMode,
      areNotificationsEnabled:
          areNotificationsEnabled ?? this.areNotificationsEnabled,
      hasPendingNotificationUpdate:
          hasPendingNotificationUpdate ?? this.hasPendingNotificationUpdate,
    );
  }

  @override
  List<Object?> get props => [isDarkMode, areNotificationsEnabled, hasPendingNotificationUpdate];
}

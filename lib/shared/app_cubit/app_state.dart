import 'package:equatable/equatable.dart';

class AppState extends Equatable {
  final bool isDarkMode;
  final bool areNotificationsEnabled;

  const AppState({
    this.isDarkMode = false,
    this.areNotificationsEnabled = true,
  });

  AppState copyWith({bool? isDarkMode, bool? areNotificationsEnabled}) {
    return AppState(
      isDarkMode: isDarkMode ?? this.isDarkMode,
      areNotificationsEnabled:
          areNotificationsEnabled ?? this.areNotificationsEnabled,
    );
  }

  @override
  List<Object?> get props => [isDarkMode, areNotificationsEnabled];
}

import 'package:equatable/equatable.dart';

class AppState extends Equatable {
  final bool isDarkMode;

  const AppState({this.isDarkMode = false});
  AppState copyWith({bool? isDarkMode}) {
    return AppState(isDarkMode: isDarkMode ?? this.isDarkMode);
  }

  @override
  List<Object?> get props => [isDarkMode];
}

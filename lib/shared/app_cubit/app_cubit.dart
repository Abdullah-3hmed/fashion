import 'package:e_fashion_flutter/shared/app_cubit/app_state.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

class AppCubit extends HydratedCubit<AppState> {
  AppCubit() : super(const AppState());
  void toggleTheme() {
    emit(state.copyWith(isDarkMode: !state.isDarkMode));
  }

  @override
  AppState? fromJson(Map<String, dynamic> json) {
    return AppState(isDarkMode: json["is_dark_mode"]);
  }

  @override
  Map<String, dynamic>? toJson(AppState state) {
    return {"is_dark_mode": state.isDarkMode};
  }
}

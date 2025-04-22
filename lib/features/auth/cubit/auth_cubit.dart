import 'package:e_fashion_flutter/features/auth/cubit/auth_state.dart';
import 'package:e_fashion_flutter/features/auth/repos/auth_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthCubit extends Cubit<AuthStates> {
  AuthCubit(this.authRepo) : super(AuthStates());
  final AuthRepo authRepo;

  Future<void> userLogin() async {
    final result = await authRepo.userLogin();
    // result.fold(
    //   // (failure) => emit(AuthStates(failure: failure)),
    //   // (data) => emit(AuthStates(data: data)),
    // );
  }
}

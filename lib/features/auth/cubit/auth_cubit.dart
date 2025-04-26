import 'package:e_fashion_flutter/core/local/cache_helper.dart';
import 'package:e_fashion_flutter/core/notifications/fcm_init_helper.dart';
import 'package:e_fashion_flutter/core/services/service_locator.dart';
import 'package:e_fashion_flutter/features/auth/cubit/auth_state.dart';
import 'package:e_fashion_flutter/features/auth/data/login_request_model.dart';
import 'package:e_fashion_flutter/features/auth/data/sign_up_request_model.dart';
import 'package:e_fashion_flutter/features/auth/repos/auth_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthCubit extends Cubit<AuthStates> {
  AuthCubit(this.authRepo) : super(AuthInitialState());
  final AuthRepo authRepo;

  Future<void> userSignUp({
    required String name,
    required String email,
    required String phone,
    required String password,
  }) async {
    emit(SignUpLoadingState());
    SignUpRequestModel signUpRequestModel = SignUpRequestModel(
      userName: name,
      email: email,
      phone: phone,
      password: password,
      fcmToken: await FcmInitHelper.getFcmToken() ?? "",
    );
    final result = await authRepo.userSignUp(
      signUpRequestModel: signUpRequestModel,
    );
    result.fold(
      (failure) => emit(SignUpErrorState(errorMessage: failure.errorMessage)),
      (authResponseModel) async {
        await getIt<CacheHelper>().saveData(
          key: "token",
          value: authResponseModel.token,
        );
        emit(SignUpSuccessState(authResponseModel: authResponseModel));
      },
    );
  }

  Future<void> userLogin({
    required String email,
    required String password,
  }) async {
    emit(LoginLoadingState());
    LoginRequestModel loginRequestModel = LoginRequestModel(
      email: email,
      password: password,
      fcmToken: await FcmInitHelper.getFcmToken() ?? "",
    );
    final result = await authRepo.userLogin(
      loginRequestModel: loginRequestModel,
    );
    result.fold(
      (failure) => emit(LoginErrorState(errorMessage: failure.errorMessage)),
      (authResponseModel) async {
        await getIt<CacheHelper>().saveData(
          key: "token",
          value: authResponseModel.token,
        );
        emit(LoginSuccessState(authResponseModel: authResponseModel));
      },
    );
  }
}

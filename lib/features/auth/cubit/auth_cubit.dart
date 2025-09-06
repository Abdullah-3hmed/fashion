import 'dart:developer';

import 'package:e_fashion_flutter/core/enums/request_status.dart';
import 'package:e_fashion_flutter/core/local/cache_helper.dart';
import 'package:e_fashion_flutter/core/notifications/fcm_init_helper.dart';
import 'package:e_fashion_flutter/core/services/service_locator.dart';
import 'package:e_fashion_flutter/core/utils/app_constants.dart';
import 'package:e_fashion_flutter/features/auth/cubit/auth_state.dart';
import 'package:e_fashion_flutter/features/auth/data/login_request_model.dart';
import 'package:e_fashion_flutter/features/auth/data/reset_password_request_model.dart';
import 'package:e_fashion_flutter/features/auth/data/sign_up_request_model.dart';
import 'package:e_fashion_flutter/features/auth/repos/auth_repo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit(this.authRepo) : super(const AuthState());
  final AuthRepo authRepo;

  Future<void> userSignUp({
    required String name,
    required String email,
    required String phone,
    required String password,
  }) async {
    emit(state.copyWith(signUpRequestStatus: RequestStatus.loading));
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
      (failure) => emit(
        state.copyWith(
          authErrorMessage: failure.errorMessage,
          signUpRequestStatus: RequestStatus.error,
        ),
      ),
      (authResponseModel) async {
        AppConstants.token = authResponseModel.token;
        AppConstants.userId = authResponseModel.userId;
        emit(
          state.copyWith(
            authResponseModel: authResponseModel,
            signUpRequestStatus: RequestStatus.success,
          ),
        );
        await getIt<CacheHelper>().saveData(
          key: "token",
          value: authResponseModel.token,
        );
        debugPrint("Saved user ID: ${authResponseModel.userId}");
        await getIt<CacheHelper>().saveData(
          key: "user_id",
          value: authResponseModel.userId,
        );
      },
    );
  }

  Future<void> userLogin({
    required String email,
    required String password,
  }) async {
    emit(state.copyWith(loginRequestStatus: RequestStatus.loading));
    LoginRequestModel loginRequestModel = LoginRequestModel(
      email: email,
      password: password,
      fcmToken: await FcmInitHelper.getFcmToken() ?? "",
    );
    final result = await authRepo.userLogin(
      loginRequestModel: loginRequestModel,
    );
    result.fold(
      (failure) => emit(
        state.copyWith(
          authErrorMessage: failure.errorMessage,
          loginRequestStatus: RequestStatus.error,
        ),
      ),
      (authResponseModel) async {
        AppConstants.token = authResponseModel.token;
        AppConstants.userId = authResponseModel.userId;
        emit(
          state.copyWith(
            authResponseModel: authResponseModel,
            loginRequestStatus: RequestStatus.success,
          ),
        );
        await getIt<CacheHelper>().saveData(
          key: "token",
          value: authResponseModel.token,
        );
        debugPrint("Saved user ID: ${authResponseModel.userId}");
        await getIt<CacheHelper>().saveData(
          key: "user_id",
          value: authResponseModel.userId,
        );
      },
    );
  }

  Future<void> forgetPassword({required String email}) async {
    emit(state.copyWith(forgetPasswordRequestStatus: RequestStatus.loading));
    final result = await authRepo.forgetPassword(email: email);
    result.fold(
      (failure) => emit(
        state.copyWith(
          authErrorMessage: failure.errorMessage,
          forgetPasswordRequestStatus: RequestStatus.error,
        ),
      ),

      (authResponseModel) => emit(
        state.copyWith(
          authResponseModel: authResponseModel,
          forgetPasswordRequestStatus: RequestStatus.success,
        ),
      ),
    );
  }

  Future<void> verifyOtp({required String email, required String otp}) async {
    emit(state.copyWith(verifyOtpRequestStatus: RequestStatus.loading));
    final result = await authRepo.verifyOtp(email: email, otp: otp);
    result.fold(
      (failure) => emit(
        state.copyWith(
          authErrorMessage: failure.errorMessage,
          verifyOtpRequestStatus: RequestStatus.error,
        ),
      ),
      (message) => emit(
        state.copyWith(
          verifyOtpMessage: message,
          verifyOtpRequestStatus: RequestStatus.success,
        ),
      ),
    );
  }

  Future<void> resetPassword({
    required String email,
    required String newPassword,
    required String confirmPassword,
  }) async {
    emit(state.copyWith(resetPasswordRequestStatus: RequestStatus.loading));
    ResetPasswordRequestModel resetPasswordRequestModel =
        ResetPasswordRequestModel(
          password: newPassword,
          confirmPassword: confirmPassword,
          token: state.authResponseModel.token,
          email: email,
        );
    final result = await authRepo.resetPassword(
      resetPasswordRequestModel: resetPasswordRequestModel,
    );
    result.fold(
      (failure) => emit(
        state.copyWith(
          authErrorMessage: failure.errorMessage,
          resetPasswordRequestStatus: RequestStatus.error,
        ),
      ),
      (message) => emit(
        state.copyWith(
          resetPasswordRequestStatus: RequestStatus.success,
          resetPasswordMessage: message,
        ),
      ),
    );
  }
}

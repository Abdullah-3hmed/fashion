import 'package:e_fashion_flutter/core/local/cache_helper.dart';
import 'package:e_fashion_flutter/core/notifications/fcm_init_helper.dart';
import 'package:e_fashion_flutter/core/services/service_locator.dart';
import 'package:e_fashion_flutter/features/auth/cubit/auth_state.dart';
import 'package:e_fashion_flutter/features/auth/data/sign_up_model.dart';
import 'package:e_fashion_flutter/features/auth/repos/auth_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthCubit extends Cubit<AuthStates> {
  AuthCubit(this.authRepo) : super(SignUpInitialState());
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
      (signUpResponseModel) async {
        await getIt<CacheHelper>().saveData(
          key: "token",
          value: signUpResponseModel.token,
        );
        emit(SignUpSuccessState(signUpResponseModel: signUpResponseModel));
      },
    );
  }
}

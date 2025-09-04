import 'dart:developer';
import 'dart:io';
import 'package:e_fashion_flutter/core/enums/request_status.dart';
import 'package:e_fashion_flutter/core/local/cache_helper.dart';
import 'package:e_fashion_flutter/core/services/connection_service.dart';
import 'package:e_fashion_flutter/core/services/service_locator.dart';
import 'package:e_fashion_flutter/core/utils/app_constants.dart';
import 'package:e_fashion_flutter/features/profile/cubit/user_cubit/user_state.dart';
import 'package:e_fashion_flutter/features/profile/data/chat/send_message_model.dart';
import 'package:e_fashion_flutter/features/profile/data/user/edit_user_model.dart';
import 'package:e_fashion_flutter/features/profile/data/user/user_model.dart';
import 'package:e_fashion_flutter/features/profile/data/user/user_password_model.dart';
import 'package:e_fashion_flutter/features/profile/repos/user_repo/user_repo.dart';
import 'package:flutter/material.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:image_picker/image_picker.dart';

class UserCubit extends Cubit<UserState> {
  UserCubit({required this.userRepo}) : super(const UserState());
  final UserRepo userRepo;

  Future<void> getUserProfile() async {
    final result = await userRepo.getUserProfile();
    result.fold(
      (failure) {
        if (!failure.isConnected) {
          emit(
            state.copyWith(
              userErrorMessage: failure.errorMessage,
              userRequestStates: RequestStatus.error,
              isConnected: false,
            ),
          );
        }
        emit(
          state.copyWith(
            userErrorMessage: failure.errorMessage,
            userRequestStates: RequestStatus.error,
          ),
        );
      },
      (userModel) {
        emit(
          state.copyWith(
            userModel: userModel,
            userRequestStates: RequestStatus.success,
            isConnected: true,
          ),
        );
      },
    );
  }

  Future<void> logOut() async {
    AppConstants.token = "";
    AppConstants.userId = "";
    ConnectionsService.closeConnection();
    await getIt<CacheHelper>().deleteAll();
  }

  Future<void> pickProfileImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      emit(
        state.copyWith(
          editUserModel: state.editUserModel.copyWith(
            profileImageFile: File(pickedFile.path),
          ),
        ),
      );
      await editProfile();
    } else {
      return;
    }
  }

  Future<void> editProfile({
    String? userName,
    String? phone,
    String? email,
  }) async {
    emit(state.copyWith(editUserRequestStatus: RequestStatus.loading));
    final result = await userRepo.editProfile(
      editUserModel: EditUserModel(
        userName: userName ?? state.userModel.userName,
        email: email ?? state.userModel.email,
        phone: phone ?? state.userModel.phone,
        profileImageFile: state.editUserModel.profileImageFile,
      ),
    );
    result.fold(
      (failure) {
        emit(
          state.copyWith(
            editUserModel: EditUserModel.empty,
            editUserErrorMessage: failure.errorMessage,
            editUserRequestStatus: RequestStatus.error,
          ),
        );
      },
      (editUserModel) {
        emit(
          state.copyWith(
            editUserModel: state.editUserModel.copyWith(profileImageFile: null),
            userModel: state.userModel.copyWith(
              profileImage: editUserModel.profileImage,
              userName: editUserModel.userName,
              phone: editUserModel.phone,
              email: editUserModel.email,
            ),
            editUserRequestStatus: RequestStatus.success,
          ),
        );
      },
    );
  }

  Future<void> changePassword({
    required String currentPassword,
    required String newPassword,
    required String confirmPassword,
  }) async {
    emit(state.copyWith(changePasswordRequestStatus: RequestStatus.loading));
    UserPasswordModel passwordModel = UserPasswordModel(
      currentPassword: currentPassword,
      newPassword: newPassword,
      confirmPassword: confirmPassword,
    );
    final result = await userRepo.changePassword(passwordModel: passwordModel);
    result.fold(
      (failure) => emit(
        state.copyWith(
          changePasswordMessage: failure.errorMessage,
          changePasswordRequestStatus: RequestStatus.error,
        ),
      ),
      (message) {
        emit(
          state.copyWith(
            changePasswordMessage: message,
            changePasswordRequestStatus: RequestStatus.success,
          ),
        );
      },
    );
  }

  void setUserLocation({required String location}) {
    emit(state.copyWith(userLocation: location));
    debugPrint("location>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>: $location");
  }
}

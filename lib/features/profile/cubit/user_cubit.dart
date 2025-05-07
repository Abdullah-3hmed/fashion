import 'dart:io';

import 'package:e_fashion_flutter/core/enums/request_status.dart';
import 'package:e_fashion_flutter/features/profile/cubit/user_state.dart';
import 'package:e_fashion_flutter/features/profile/data/edit_user_model.dart';
import 'package:e_fashion_flutter/features/profile/data/user_model.dart';
import 'package:e_fashion_flutter/features/profile/repos/user_repo.dart';
import 'package:flutter/material.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:image_picker/image_picker.dart';

class UserCubit extends HydratedCubit<UserState> {
  UserCubit({required this.userRepo}) : super(const UserState());
  final UserRepo userRepo;

  Future<void> getUserProfile() async {
    final result = await userRepo.getUserProfile();
    result.fold(
      (failure) => emit(
        state.copyWith(
          userErrorMessage: failure.errorMessage,
          userRequestStates: RequestStatus.error,
        ),
      ),
      (userModel) {
        debugPrint("user model ${userModel.toString()}");
        emit(
          state.copyWith(
            userModel: userModel,
            userRequestStates: RequestStatus.success,
          ),
        );
      },
    );
  }

  Future<void> logOut() async {
    await userRepo.logOut(email: state.userModel.email);
  }

  Future<void> editProfile({String? userName, String? phone}) async {
    final result = await userRepo.editProfile(
      editUserModel: EditUserModel(
        userName: userName ?? state.userModel.userName,
        phone: phone ?? state.userModel.phone,
        profileImage: state.userModel.profileImage,
        profileImageFile: state.editUserModel.profileImageFile,
      ),
    );
    result.fold(
      (failure) => emit(
        state.copyWith(
          editUserErrorMessage: failure.errorMessage,
          editUserRequestStatus: RequestStatus.error,
        ),
      ),
      (editUserModel) {
        emit(
          state.copyWith(
            editUserModel: EditUserModel.empty,
            userModel: state.userModel.copyWith(
              profileImage: editUserModel.profileImage,
              userName: editUserModel.userName,
              phone: editUserModel.phone,
            ),
            editUserRequestStatus: RequestStatus.success,
          ),
        );
      },
    );
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

  @override
  UserState? fromJson(Map<String, dynamic> json) {
    return UserState(userModel: UserModel.fromJson(json["user_model"]));
  }

  @override
  Map<String, dynamic>? toJson(UserState state) {
    return {"user_model": state.userModel.toJson()};
  }
}

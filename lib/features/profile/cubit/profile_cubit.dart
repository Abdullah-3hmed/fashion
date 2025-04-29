import 'dart:io';

import 'package:e_fashion_flutter/core/enums/request_status.dart';
import 'package:e_fashion_flutter/core/utils/show_toast.dart';
import 'package:e_fashion_flutter/core/utils/toast_states.dart';
import 'package:e_fashion_flutter/features/profile/cubit/profile_state.dart';
import 'package:e_fashion_flutter/features/profile/data/edit_profile_model.dart';
import 'package:e_fashion_flutter/features/profile/data/user_model.dart';
import 'package:e_fashion_flutter/features/profile/repos/profile_repo.dart';
import 'package:flutter/material.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:image_picker/image_picker.dart';

class ProfileCubit extends HydratedCubit<ProfileState> {
  ProfileCubit({required this.profileRepo}) : super(const ProfileState());
  final ProfileRepo profileRepo;

  Future<void> getUserProfile() async {
    final result = await profileRepo.getUserProfile();
    result.fold(
      (failure) => emit(
        state.copyWith(
          errorMessage: failure.errorMessage,
          userStates: RequestStatus.error,
        ),
      ),
      (userModel) {
        debugPrint("user model ${userModel.toString()}");
        emit(
          state.copyWith(
            userModel: userModel,
            userStates: RequestStatus.success,
          ),
        );
      },
    );
  }

  Future<void> logOut() async {
    await profileRepo.logOut(email: state.userModel.email);
  }

  Future<void> editProfile({String? userName, String? phone}) async {
    final result = await profileRepo.editProfile(
      editProfileModel: EditProfileModel(
        userName: userName ?? state.userModel.userName,
        phone: phone ?? state.userModel.phone,
        profileImage: state.userModel.profileImage,
        profileImageFile: state.pickedImageFile,
      ),
    );
    result.fold(
      (failure) => emit(
        state.copyWith(
          editProfileErrorMessage: failure.errorMessage,
          editProfileRequestStatus: RequestStatus.error,
        ),
      ),
      (editProfileModel) {
        debugPrint("user model ${editProfileModel.toString()}");
        emit(
          state.copyWith(
            editProfileModel: editProfileModel,
            pickedImageFile: null,
            userModel: state.userModel.copyWith(
              profileImage: editProfileModel.profileImage,
              userName: editProfileModel.userName,
              phone: editProfileModel.phone,
            ),
            userStates: RequestStatus.success,
          ),
        );
        showToast(
          message: "Profile Updated Successfully",
          state: ToastStates.success,
        );
      },
    );
  }

  Future<void> pickProfileImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      emit(state.copyWith(pickedImageFile: File(pickedFile.path)));
      await editProfile();
    } else {
      return;
    }
  }

  @override
  ProfileState? fromJson(Map<String, dynamic> json) {
    return ProfileState(userModel: UserModel.fromJson(json["user_model"]));
  }

  @override
  Map<String, dynamic>? toJson(ProfileState state) {
    return {"user_model": state.userModel.toJson()};
  }
}

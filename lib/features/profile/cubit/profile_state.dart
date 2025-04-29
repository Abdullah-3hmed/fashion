import 'dart:io';

import 'package:e_fashion_flutter/core/enums/request_status.dart';
import 'package:e_fashion_flutter/features/profile/data/edit_profile_model.dart';
import 'package:e_fashion_flutter/features/profile/data/user_model.dart';
import 'package:equatable/equatable.dart';

class ProfileState extends Equatable {
  final UserModel userModel;
  final String errorMessage;
  final RequestStatus userStates;
  final EditProfileModel editProfileModel;
  final RequestStatus editProfileRequestStatus;
  final String editProfileErrorMessage;

  const ProfileState({
    this.userModel = UserModel.empty,
    this.errorMessage = "",
    this.userStates = RequestStatus.loading,
    this.editProfileModel = EditProfileModel.empty,
    this.editProfileRequestStatus = RequestStatus.loading,
    this.editProfileErrorMessage = "",
  });

  ProfileState copyWith({
    UserModel? userModel,
    String? errorMessage,
    RequestStatus? userStates,
    File? pickedImageFile,
    EditProfileModel? editProfileModel,
    RequestStatus? editProfileRequestStatus,
    String? editProfileErrorMessage,
  }) {
    return ProfileState(
      userModel: userModel ?? this.userModel,
      errorMessage: errorMessage ?? this.errorMessage,
      userStates: userStates ?? this.userStates,
      editProfileModel: editProfileModel ?? this.editProfileModel,
      editProfileRequestStatus:
          editProfileRequestStatus ?? this.editProfileRequestStatus,
      editProfileErrorMessage:
          editProfileErrorMessage ?? this.editProfileErrorMessage,
    );
  }

  @override
  List<Object?> get props => [
    userModel,
    errorMessage,
    userStates,
    editProfileModel,
    editProfileRequestStatus,
    editProfileErrorMessage,
  ];
}

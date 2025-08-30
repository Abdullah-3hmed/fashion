import 'package:e_fashion_flutter/core/enums/request_status.dart';
import 'package:e_fashion_flutter/features/profile/data/user/edit_user_model.dart';
import 'package:e_fashion_flutter/features/profile/data/user/user_model.dart';
import 'package:equatable/equatable.dart';

class UserState extends Equatable {
  final UserModel userModel;
  final String userErrorMessage;
  final RequestStatus userRequestStates;
  final EditUserModel editUserModel;
  final RequestStatus editUserRequestStatus;
  final String editUserErrorMessage;
  final String changePasswordMessage;
  final RequestStatus changePasswordRequestStatus;
  final String userLocation;

  const UserState({
    this.userModel = UserModel.empty,
    this.userErrorMessage = "",
    this.userRequestStates = RequestStatus.loading,
    this.editUserModel = EditUserModel.empty,
    this.editUserRequestStatus = RequestStatus.initial,
    this.editUserErrorMessage = "",
    this.changePasswordMessage = "",
    this.changePasswordRequestStatus = RequestStatus.initial,
    this.userLocation = "",
  });

  UserState copyWith({
    UserModel? userModel,
    String? userErrorMessage,
    RequestStatus? userRequestStates,
    EditUserModel? editUserModel,
    RequestStatus? editUserRequestStatus,
    String? editUserErrorMessage,
    String? changePasswordMessage,
    RequestStatus? changePasswordRequestStatus,
    String? userLocation,
  }) {
    return UserState(
      userModel: userModel ?? this.userModel,
      userErrorMessage: userErrorMessage ?? this.userErrorMessage,
      userRequestStates: userRequestStates ?? this.userRequestStates,
      editUserModel: editUserModel ?? this.editUserModel,
      editUserRequestStatus:
          editUserRequestStatus ?? this.editUserRequestStatus,
      editUserErrorMessage: editUserErrorMessage ?? this.editUserErrorMessage,
      changePasswordMessage:
          changePasswordMessage ?? this.changePasswordMessage,
      changePasswordRequestStatus:
          changePasswordRequestStatus ?? this.changePasswordRequestStatus,
      userLocation: userLocation ?? this.userLocation,
    );
  }

  @override
  List<Object?> get props => [
    userModel,
    userErrorMessage,
    userRequestStates,
    editUserModel,
    editUserRequestStatus,
    editUserErrorMessage,
    changePasswordMessage,
    changePasswordRequestStatus,
    userLocation,
  ];
}

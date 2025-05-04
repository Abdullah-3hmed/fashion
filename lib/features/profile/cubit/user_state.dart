import 'package:e_fashion_flutter/core/enums/request_status.dart';
import 'package:e_fashion_flutter/features/profile/data/edit_user_model.dart';
import 'package:e_fashion_flutter/features/profile/data/user_model.dart';
import 'package:equatable/equatable.dart';

class UserState extends Equatable {
  final UserModel userModel;
  final String userErrorMessage;
  final RequestStatus userRequestStates;
  final EditUserModel editUserModel;
  final RequestStatus editUserRequestStatus;
  final String editUserErrorMessage;

  const UserState({
    this.userModel = UserModel.empty,
    this.userErrorMessage = "",
    this.userRequestStates = RequestStatus.loading,
    this.editUserModel = EditUserModel.empty,
    this.editUserRequestStatus = RequestStatus.loading,
    this.editUserErrorMessage = "",
  });

  UserState copyWith({
    UserModel? userModel,
    String? userErrorMessage,
    RequestStatus? userRequestStates,
    EditUserModel? editUserModel,
    RequestStatus? editUserRequestStatus,
    String? editUserErrorMessage,
  }) {
    return UserState(
      userModel: userModel ?? this.userModel,
      userErrorMessage: userErrorMessage ?? this.userErrorMessage,
      userRequestStates: userRequestStates ?? this.userRequestStates,
      editUserModel: editUserModel ?? this.editUserModel,
      editUserRequestStatus:
          editUserRequestStatus ?? this.editUserRequestStatus,
      editUserErrorMessage: editUserErrorMessage ?? this.editUserErrorMessage,
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
  ];
}

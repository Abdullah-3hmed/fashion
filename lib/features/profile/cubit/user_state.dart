import 'package:e_fashion_flutter/core/enums/request_status.dart';
import 'package:e_fashion_flutter/features/profile/data/edit_user_model.dart';
import 'package:e_fashion_flutter/features/profile/data/message_model.dart';
import 'package:e_fashion_flutter/features/profile/data/user_model.dart';
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
  final RequestStatus getChatHistoryState;
  final List<MessageModel> messageList;
  final String getChatHistoryErrorMessage;

  const UserState({
    this.userModel = UserModel.empty,
    this.userErrorMessage = "",
    this.userRequestStates = RequestStatus.loading,
    this.editUserModel = EditUserModel.empty,
    this.editUserRequestStatus = RequestStatus.initial,
    this.editUserErrorMessage = "",
    this.changePasswordMessage = "",
    this.changePasswordRequestStatus = RequestStatus.initial,
    this.getChatHistoryState = RequestStatus.loading,
    this.messageList = const [],
    this.getChatHistoryErrorMessage = "",
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
    RequestStatus? getChatHistoryState,
    List<MessageModel>? messageList,
    String? getChatHistoryErrorMessage,
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
      getChatHistoryState: getChatHistoryState ?? this.getChatHistoryState,
      messageList: messageList ?? this.messageList,
      getChatHistoryErrorMessage:
          getChatHistoryErrorMessage ?? this.getChatHistoryErrorMessage,
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
    getChatHistoryState,
    messageList,
    getChatHistoryErrorMessage,
  ];
}

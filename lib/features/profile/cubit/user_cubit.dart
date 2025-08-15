import 'dart:developer';
import 'dart:io';

import 'package:e_fashion_flutter/core/enums/request_status.dart';
import 'package:e_fashion_flutter/core/local/cache_helper.dart';
import 'package:e_fashion_flutter/core/services/connection_service.dart';
import 'package:e_fashion_flutter/core/services/service_locator.dart';
import 'package:e_fashion_flutter/core/utils/app_constants.dart';
import 'package:e_fashion_flutter/features/profile/cubit/user_state.dart';
import 'package:e_fashion_flutter/features/profile/data/edit_user_model.dart';
import 'package:e_fashion_flutter/features/profile/data/message_model.dart';
import 'package:e_fashion_flutter/features/profile/data/send_message_model.dart';
import 'package:e_fashion_flutter/features/profile/data/user_model.dart';
import 'package:e_fashion_flutter/features/profile/data/user_password_model.dart';
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
    AppConstants.token = "";
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
      // await editProfile();
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
            editUserModel: EditUserModel.empty,
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

  Future<void> sendMessage({
    required String message,
    required String senderId,
    required String receiverId,
  }) async {
    await ConnectionsService.checkConnection();

    final sendMessageModel = SendMessageModel(
      content: message,
      senderId: senderId,
      receiverId: receiverId,
      chatId: 0,
    );

    try {
      await ConnectionsService.connection.invoke(
        "MessageSent",
        args: [sendMessageModel.toJson()],
      );
      log("✅ Message sent successfully: ${sendMessageModel.toJson()}");
    } catch (error, stackTrace) {
      log("❌ Error sending message: $error");
      log("StackTrace: $stackTrace");
    }
  }

  Future<void> listenToMessage() async {
    await ConnectionsService.checkConnection();
    ConnectionsService.connection.off("ReceiveMessage");
    ConnectionsService.connection.on("ReceiveMessage", (arguments) {
      try {
        if (arguments != null && arguments.isNotEmpty) {
          final data = arguments[0];

          if (data is Map) {
            final Map<String, dynamic> jsonData = Map<String, dynamic>.from(
              data,
            );

            final message = MessageModel.fromJson(jsonData);

            emit(state.copyWith(messageList: [...state.messageList, message]));
            log("📩 New message received: ${message.toString()}");
          } else {
            log("⚠️ Received data is not a valid map: $data");
          }
        }
      } catch (e, stackTrace) {
        log("❌ Error handling incoming message: $e");
        log("StackTrace: $stackTrace");
      }
    });
  }

  Future<void> getChatHistory({required String? receiverId}) async {
    if (state.messageList.isNotEmpty) return;
    final result = await userRepo.getChatHistory(
      receiverId: receiverId ?? AppConstants.supportId,
    );
    result.fold(
      (failure) => emit(
        state.copyWith(
          getChatHistoryErrorMessage: failure.errorMessage,
          getChatHistoryState: RequestStatus.error,
        ),
      ),
      (messageList) {
        emit(
          state.copyWith(
            getChatHistoryState: RequestStatus.success,
            messageList: messageList,
          ),
        );
      },
    );
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

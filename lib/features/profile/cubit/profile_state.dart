import 'package:e_fashion_flutter/core/enums/request_status.dart';
import 'package:e_fashion_flutter/features/profile/data/user_model.dart';
import 'package:equatable/equatable.dart';

class ProfileStates extends Equatable {
  final UserModel userModel;
  final String errorMessage;
  final RequestStatus userStates;

  const ProfileStates({
    this.userModel = UserModel.empty,
    this.errorMessage = "",
    this.userStates = RequestStatus.loading,
  });

  ProfileStates copyWith({
    UserModel? userModel,
    String? errorMessage,
    RequestStatus? userStates,
  }) {
    return ProfileStates(
      userModel: userModel ?? this.userModel,
      errorMessage: errorMessage ?? this.errorMessage,
      userStates: userStates ?? this.userStates,
    );
  }

  @override
  List<Object> get props => [userModel, errorMessage, userStates];
}

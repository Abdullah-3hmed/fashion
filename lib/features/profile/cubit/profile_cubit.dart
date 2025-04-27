import 'package:e_fashion_flutter/core/enums/request_status.dart';
import 'package:e_fashion_flutter/features/profile/cubit/profile_state.dart';
import 'package:e_fashion_flutter/features/profile/data/user_model.dart';
import 'package:e_fashion_flutter/features/profile/repos/profile_repo.dart';
import 'package:flutter/material.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

class ProfileCubit extends HydratedCubit<ProfileStates> {
  ProfileCubit({required this.profileRepo}) : super(const ProfileStates());
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

  void editProfile({required String userName, required String phone}) {
    emit(
      state.copyWith(
        userModel: state.userModel.copyWith(userName: userName, phone: phone),
      ),
    );
  }

  @override
  ProfileStates? fromJson(Map<String, dynamic> json) {
    return ProfileStates(userModel: UserModel.fromJson(json["user_model"]));
  }

  @override
  Map<String, dynamic>? toJson(ProfileStates state) {
    return {"user_model": state.userModel.toJson()};
  }
}

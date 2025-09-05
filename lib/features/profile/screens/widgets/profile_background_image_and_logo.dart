import 'dart:ui';

import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:e_fashion_flutter/core/enums/request_status.dart';
import 'package:e_fashion_flutter/core/utils/show_toast.dart';
import 'package:e_fashion_flutter/core/widgets/custom_cached_network_image.dart';
import 'package:e_fashion_flutter/features/profile/cubit/user_cubit/user_cubit.dart';
import 'package:e_fashion_flutter/features/profile/cubit/user_cubit/user_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:solar_icons/solar_icons.dart';

class ProfileBackgroundImageAndLogo extends StatelessWidget {
  const ProfileBackgroundImageAndLogo({
    super.key,
    required this.child,
    this.isEditProfileScreen = false,
  });

  final Widget child;
  final bool isEditProfileScreen;

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: Stack(
        children: [
          ImageFiltered(
            imageFilter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
            child:
                context.select(
                          (UserCubit cubit) =>
                              cubit.state.editUserModel.profileImageFile,
                        ) !=
                        null
                    ? Image.file(
                      context
                          .read<UserCubit>()
                          .state
                          .editUserModel
                          .profileImageFile!,
                      fit: BoxFit.cover,
                      width: double.infinity,
                      height: double.infinity,
                    )
                    : CustomCachedNetworkImage(
                      imageUrl:
                          context
                              .read<UserCubit>()
                              .state
                              .userModel
                              .profileImage,
                      height: double.infinity,
                    ),
          ),
          PositionedDirectional(
            top: 80.0,
            start: 0.0,
            end: 0.0,
            child: Column(
              children: [
                BlocConsumer<UserCubit, UserState>(
                  listenWhen:
                      (previous, current) =>
                          previous.editUserModel != current.editUserModel &&
                          isEditProfileScreen,
                  listener: (context, state) {
                    if (state.editUserRequestStatus.isSuccess &&
                        isEditProfileScreen) {
                      showToast(
                        message: "Profile Updated Successfully",
                        state: ToastStates.success,
                      );
                    }
                    if (state.editUserRequestStatus.isError) {
                      showToast(
                        message: state.editUserErrorMessage,
                        state: ToastStates.error,
                      );
                    }
                  },
                  buildWhen:
                      (previous, current) =>
                          previous.editUserModel.profileImageFile !=
                          current.editUserModel.profileImageFile,
                  builder: (context, state) {
                    return Stack(
                      alignment: AlignmentDirectional.topEnd,
                      children: [
                        CircleAvatar(
                          radius: 60.0,
                          child: ClipOval(
                            child:
                                state.editUserModel.profileImageFile != null
                                    ? Image.file(
                                      state.editUserModel.profileImageFile!,
                                      width: 120.0,
                                      height: 120.0,
                                      fit: BoxFit.cover,
                                    )
                                    : CustomCachedNetworkImage(
                                      imageUrl: state.userModel.profileImage,
                                      width: 120.0,
                                      height: 120.0,
                                    ),
                          ),
                        ),
                        if (isEditProfileScreen)
                          InkWell(
                            onTap: () async {
                              await context
                                  .read<UserCubit>()
                                  .pickProfileImage();
                            },
                            child: CircleAvatar(
                              radius: 18.0,
                              backgroundColor:
                                  Theme.of(context).colorScheme.primary,
                              child: const Icon(
                                SolarIconsOutline.camera,
                                size: 20.0,
                                color: Colors.white,
                              ),
                            ),
                          ),
                      ],
                    );
                  },
                ),
                const SizedBox(height: 8.0),
                Text(
                  context.select(
                    (UserCubit cubit) => cubit.state.userModel.userName,
                  ),
                  style: Theme.of(
                    context,
                  ).textTheme.titleLarge!.copyWith(color: Colors.white),
                ),
              ],
            ),
          ),
          PositionedDirectional(
            bottom: 0.0,
            start: 0.0,
            end: 0.0,
            child: child,
          ),
        ],
      ),
    );
  }
}

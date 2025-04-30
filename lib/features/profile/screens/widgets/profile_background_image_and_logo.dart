import 'dart:ui';

import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:e_fashion_flutter/core/utils/assets_manager.dart';
import 'package:e_fashion_flutter/features/profile/cubit/user_cubit.dart';
import 'package:e_fashion_flutter/features/profile/cubit/user_state.dart';
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
            child: Image.asset(AssetsManager.welcomeImage, fit: BoxFit.cover),
          ),
          PositionedDirectional(
            top: 80.0,
            start: 0.0,
            end: 0.0,
            child: Column(
              children: [
                BlocBuilder<UserCubit, UserState>(
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
                                    : CachedNetworkImage(
                                      imageUrl: state.userModel.profileImage,
                                      width: 120.0,
                                      height: 120.0,
                                      fit: BoxFit.cover,
                                    ),
                          ),
                        ),
                        isEditProfileScreen
                            ? InkWell(
                              onTap: () async {
                                await context
                                    .read<UserCubit>()
                                    .pickProfileImage();
                                context.pop();
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
                            )
                            : const SizedBox.shrink(),
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

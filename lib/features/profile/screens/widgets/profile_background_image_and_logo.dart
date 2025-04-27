import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:e_fashion_flutter/core/utils/assets_manager.dart';
import 'package:e_fashion_flutter/features/profile/cubit/profile_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileBackgroundImageAndLogo extends StatelessWidget {
  const ProfileBackgroundImageAndLogo({super.key, required this.child});

  final Widget child;

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
                CircleAvatar(
                  radius: 60.0,
                  child: ClipOval(
                    child: CachedNetworkImage(
                      imageUrl: context.select(
                        (ProfileCubit cubit) =>
                            cubit.state.userModel.profileImage,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 8.0),
                Text(
                  context.select(
                    (ProfileCubit cubit) => cubit.state.userModel.userName,
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

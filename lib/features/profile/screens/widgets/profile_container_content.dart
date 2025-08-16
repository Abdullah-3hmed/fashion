import 'package:auto_route/auto_route.dart';
import 'package:e_fashion_flutter/config/router/app_router.dart';
import 'package:e_fashion_flutter/core/utils/app_constants.dart';
import 'package:e_fashion_flutter/features/profile/cubit/user_cubit/user_cubit.dart';
import 'package:e_fashion_flutter/features/profile/screens/widgets/profile_info_item.dart';
import 'package:e_fashion_flutter/shared/app_cubit/app_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';
import 'package:solar_icons/solar_icons.dart';

class ProfileContainerContent extends StatelessWidget {
  const ProfileContainerContent({super.key, required this.controller});

  final ScrollController controller;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      controller: controller,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 40.0),
          InkWell(
            onTap: () async {
              context.replaceRoute(const AuthRoute());
              await context.read<UserCubit>().logOut();
            },
            child: CircleAvatar(
              radius: 24.0,
              backgroundColor: Theme.of(context).colorScheme.primary,
              child: const Icon(SolarIconsBold.logout_2, color: Colors.white),
            ),
          ),
          const SizedBox(height: 44.0),
          Align(
            child: Text(
              "Profile Settings",
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ),
          const SizedBox(height: 24.0),
          ProfileInfoItem(
            onTap: () {
              context.pushRoute(const EditProfileRoute());
            },
            text: "My profile",
            icon: SolarIconsOutline.user,
          ),
          const SizedBox(height: 24.0),
          ProfileInfoItem(
            onTap: () {
              context.pushRoute(const MapRoute());
            },
            text: "Location",
            icon: SolarIconsOutline.mapPoint,
          ),
          const SizedBox(height: 24.0),
          ProfileInfoItem(
            onTap: () {
              context.pushRoute(const OrderStatusRoute());
            },
            text: "Order status",
            icon: Iconsax.bag_2,
          ),
          const SizedBox(height: 24.0),
          ProfileInfoItem(
            onTap: () {
              context.pushRoute( ChatSupportRoute(receiverId: AppConstants.supportId));
            },
            text: "Chat Support",
            icon: SolarIconsOutline.chatRound,
          ),
          const SizedBox(height: 24.0),
          ProfileInfoItem(
            onTap: () {
              context.pushRoute(const ProfileChangePasswordRoute());
            },
            text: "Change password",
            icon: SolarIconsOutline.lockKeyhole,
          ),
          const SizedBox(height: 24.0),
          ProfileInfoItem(
            text: "Notification",
            icon: Iconsax.notification,
            suffixWidget: Switch(
              activeColor: Colors.white,
              activeTrackColor: Colors.red,
              value: context.select(
                (AppCubit cubit) => cubit.state.areNotificationsEnabled,
              ),
              onChanged: (value)  {
                context.read<AppCubit>().toggleNotifications(isNotificationAllowed: value);
              },
            ),
          ),

          const SizedBox(height: 10.0),
          ProfileInfoItem(
            text: "Theme Mode",
            icon: SolarIconsOutline.sun,
            suffixWidget: Switch(
              activeColor: Colors.white,
              activeTrackColor: Colors.green,
              value: context.read<AppCubit>().state.isDarkMode,
              onChanged: (_) {
                context.read<AppCubit>().toggleTheme();
              },
            ),
          ),
        ],
      ),
    );
  }
}

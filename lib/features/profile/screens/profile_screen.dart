import 'dart:ui';

import 'package:auto_route/auto_route.dart';
import 'package:e_fashion_flutter/core/utils/assets_manager.dart';
import 'package:e_fashion_flutter/features/profile/screens/widgets/profile_clipped_container.dart';
import 'package:e_fashion_flutter/features/profile/screens/widgets/profile_info_item.dart';
import 'package:flutter/material.dart';
import 'package:solar_icons/solar_icons.dart';

@RoutePage()
class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox.expand(
        child: Stack(
          children: [
            ImageFiltered(
              imageFilter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
              child: Image.asset(AssetsManager.welcomeImage, fit: BoxFit.cover),
            ),
            PositionedDirectional(
              top: 40.0,
              start: 0.0,
              end: 0.0,
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 60.0,
                    child: ClipOval(
                      child: Image.asset(AssetsManager.profileImage),
                    ),
                  ),
                  const SizedBox(height: 8.0),
                  Text(
                    "Tara Slander",
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
              child: ProfileClippedContainer(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 20.0),
                      InkWell(
                        onTap: () {},
                        child: CircleAvatar(
                          radius: 24.0,
                          backgroundColor:
                              Theme.of(context).colorScheme.primary,
                          child: const Icon(
                            SolarIconsBold.logout_2,
                            color: Colors.white,
                          ),
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
                        onTap: () {},
                        text: "My profile",
                        icon: SolarIconsOutline.user,
                      ),
                      const SizedBox(height: 24.0),
                      ProfileInfoItem(
                        onTap: () {},
                        text: "Location",
                        icon: SolarIconsOutline.mapPoint,
                      ),
                      const SizedBox(height: 24.0),
                      ProfileInfoItem(
                        onTap: () {},
                        text: "Order status",
                        icon: SolarIconsOutline.bag4,
                      ),
                      const SizedBox(height: 24.0),
                      ProfileInfoItem(
                        onTap: () {},
                        text: "Chat Support",
                        icon: SolarIconsOutline.chatRound,
                      ),
                      const SizedBox(height: 24.0),
                      ProfileInfoItem(
                        onTap: () {},
                        text: "Change password",
                        icon: SolarIconsOutline.lockKeyhole,
                      ),
                      const SizedBox(height: 24.0),
                      ProfileInfoItem(
                        onTap: () {},
                        text: "Change email",
                        icon: Icons.email_outlined,
                      ),
                      const SizedBox(height: 10.0),
                      ProfileInfoItem(
                        onTap: () {},
                        text: "Notification",
                        icon: Icons.notifications_outlined,
                        suffixWidget: Switch(
                          activeColor: Colors.white,
                          activeTrackColor: Colors.red,
                          value: true,
                          onChanged: (value) {},
                        ),
                      ),
                      const SizedBox(height: 10.0),
                      ProfileInfoItem(
                        onTap: () {},
                        text: "Change email",
                        icon: SolarIconsOutline.sun,
                        suffixWidget: Switch(
                          activeColor: Colors.white,
                          activeTrackColor: Colors.green,
                          value: true,
                          onChanged: (value) {},
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

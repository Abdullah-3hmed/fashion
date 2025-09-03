import 'package:auto_route/auto_route.dart';
import 'package:e_fashion_flutter/core/widgets/no_internet_widget.dart';
import 'package:e_fashion_flutter/features/profile/cubit/user_cubit/user_cubit.dart';
import 'package:e_fashion_flutter/features/profile/cubit/user_cubit/user_state.dart';
import 'package:e_fashion_flutter/features/profile/screens/widgets/profile_background_image_and_logo.dart';
import 'package:e_fashion_flutter/features/profile/screens/widgets/profile_clipped_container.dart';
import 'package:e_fashion_flutter/features/profile/screens/widgets/profile_container_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage()
class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final ValueNotifier<bool> isClippedNotifier = ValueNotifier<bool>(true);
@override
  void initState() {
   context.read<UserCubit>().getUserProfile();
    super.initState();
  }
  @override
  void dispose() {
    isClippedNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocSelector<UserCubit, UserState, bool>(
        selector: (state) => state.isConnected,
        builder: (context, bool isConnected) {
          return isConnected
              ? ProfileBackgroundImageAndLogo(
                child: SizedBox(
                  height: 650.0,
                  child: DraggableScrollableSheet(
                    initialChildSize: 0.95,
                    minChildSize: 0.85,
                    builder: (context, scrollController) {
                      return NotificationListener<
                        DraggableScrollableNotification
                      >(
                        onNotification: (notification) {
                          final newIsClipped = notification.extent < 0.9;
                          if (newIsClipped != isClippedNotifier.value) {
                            isClippedNotifier.value = newIsClipped;
                          }
                          return true;
                        },
                        child: ValueListenableBuilder<bool>(
                          valueListenable: isClippedNotifier,
                          child: ProfileContainerContent(
                            controller: scrollController,
                          ),
                          builder: (context, isClipped, child) {
                            return ProfileClippedContainer(
                              isClipped: isClipped,
                              child: child!,
                            );
                          },
                        ),
                      );
                    },
                  ),
                ),
              )
              : NoInternetWidget(
                onPressed: () async {
                  await context.read<UserCubit>().getUserProfile();
                },
                errorMessage: context.select(
                  (UserCubit cubit) => cubit.state.userErrorMessage,
                ),
              );
        },
      ),
    );
  }
}

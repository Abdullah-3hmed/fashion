import 'package:auto_route/auto_route.dart';
import 'package:e_fashion_flutter/features/profile/screens/widgets/profile_background_image_and_logo.dart';
import 'package:e_fashion_flutter/features/profile/screens/widgets/profile_clipped_container.dart';
import 'package:e_fashion_flutter/features/profile/screens/widgets/profile_container_content.dart';
import 'package:flutter/material.dart';

@RoutePage()
class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late bool isClipped;

  @override
  void initState() {
    super.initState();
    isClipped = true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ProfileBackgroundImageAndLogo(
        child: SizedBox(
          height: 650.0,
          child: DraggableScrollableSheet(
            initialChildSize: 0.9,
            minChildSize: 0.8,
            builder: (context, scrollController) {
              return NotificationListener<DraggableScrollableNotification>(
                onNotification: (notification) {
                  final newIsClipped = notification.extent < 0.85;
                  if (newIsClipped != isClipped) {
                    setState(() {
                      isClipped = newIsClipped;
                    });
                  }
                  return true;
                },
                child: ProfileClippedContainer(
                  isClipped: isClipped,
                  child: ProfileContainerContent(controller: scrollController),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

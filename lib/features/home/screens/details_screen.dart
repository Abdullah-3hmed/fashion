import 'package:auto_route/auto_route.dart';
import 'package:e_fashion_flutter/core/utils/assets_manager.dart';
import 'package:e_fashion_flutter/features/home/screens/widgets/details_clipped_container.dart';
import 'package:e_fashion_flutter/features/home/screens/widgets/details_container_content.dart';
import 'package:flutter/material.dart';

@RoutePage()
class DetailsScreen extends StatefulWidget {
  const DetailsScreen({super.key});

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  late bool isClipped;
  @override
  void initState() {
    isClipped = true;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(AssetsManager.welcomeImage, fit: BoxFit.cover),
          ),
          DraggableScrollableSheet(
            initialChildSize: 0.47,
            minChildSize: 0.47,
            builder: (context, scrollController) {
              return NotificationListener<DraggableScrollableNotification>(
                onNotification: (notification) {
                  final newIsClipped = notification.extent < 0.65;
                  if (newIsClipped != isClipped) {
                    setState(() {
                      isClipped = newIsClipped;
                    });
                  }
                  return true;
                },
                child: DetailsClippedContainer(
                  isClipped: isClipped,
                  child: DetailsContainerContent(controller: scrollController),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

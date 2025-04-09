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
  bool _isClipped = true;
  double _dragOffset = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox.expand(
        child: Stack(
          children: [
            Image.asset(fit: BoxFit.cover, AssetsManager.welcomeImage),
            PositionedDirectional(
              bottom: 0.0,
              start: 0.0,
              end: 0.0,
              child: GestureDetector(
                onVerticalDragUpdate: (details) {
                  _dragOffset += details.delta.dy;
                },
                onVerticalDragEnd: (_) {
                  setState(() {
                    if (_dragOffset < -100) {
                      _isClipped = false; // سحب لأعلى
                    } else if (_dragOffset > 100) {
                      _isClipped = true; // سحب لأسفل
                    }
                    _dragOffset = 0;
                  });
                },
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeIn,
                  decoration:
                      _isClipped
                          ? null
                          : BoxDecoration(
                            color: Theme.of(context).scaffoldBackgroundColor,
                            borderRadius: BorderRadius.circular(0),
                          ),
                  child:
                      _isClipped
                          ? const DetailsClippedContainer(
                            child: DetailsContainerContent(),
                          )
                          : const DetailsContainerContent(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

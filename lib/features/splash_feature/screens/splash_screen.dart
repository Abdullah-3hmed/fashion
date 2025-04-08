import 'package:auto_route/auto_route.dart';
import 'package:e_fashion_flutter/config/router/app_router.dart';
import 'package:e_fashion_flutter/core/animations/fade_in_animation.dart';
import 'package:e_fashion_flutter/core/animations/fade_then_spin_animation.dart';
import 'package:e_fashion_flutter/core/animations/slide_animation.dart';
import 'package:e_fashion_flutter/core/utils/assets_manager.dart';
import 'package:flutter/material.dart';

@RoutePage()
class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onVerticalDragUpdate: (details) {
          if (details.delta.dy < 100) {
            context.replaceRoute(const AuthRoute());
          }
        },
        child: Stack(
          children: [
            const SizedBox.expand(
              child: Image(
                fit: BoxFit.cover,
                image: AssetImage(AssetsManager.welcomeImage),
              ),
            ),
            const PositionedDirectional(
              top: 75.0,
              start: 0.0,
              end: 0.0,
              child: FadeInAnimation(
                duration: Duration(seconds: 2),
                child: Image(image: AssetImage(AssetsManager.appLogo)),
              ),
            ),
            PositionedDirectional(
              bottom: 0.0,
              start: 0.0,
              end: 0.0,
              child: Stack(
                children: [
                  SlideAnimation(
                    begin: const Offset(0.0, 1.0),
                    duration: const Duration(milliseconds: 600),
                    child: SizedBox(
                      width: MediaQuery.sizeOf(context).width,
                      child: const Image(
                        fit: BoxFit.cover,
                        image: AssetImage(AssetsManager.welcomeCurvedContainer),
                      ),
                    ),
                  ),
                  const PositionedDirectional(
                    top: 60.0,
                    end: 35.0,
                    child: Stack(
                      alignment: AlignmentDirectional.center,
                      children: [
                        FadeThenSpinAnimation(
                          fadeDuration: Duration(seconds: 2),
                          spinDuration: Duration(seconds: 20),
                          child: Image(
                            image: AssetImage(AssetsManager.welcomeCircleImage),
                          ),
                        ),
                        Image(
                          image: AssetImage(AssetsManager.welcomeCircleArrow),
                        ),
                      ],
                    ),
                  ),
                  PositionedDirectional(
                    start: 24.0,
                    bottom: 92.0,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SlideAnimation(
                          begin: const Offset(-1.5, -0.5),
                          duration: const Duration(seconds: 1),
                          delay: const Duration(milliseconds: 900),
                          child: Text(
                            "Start your new",
                            style: Theme.of(context).textTheme.titleMedium!
                                .copyWith(color: Colors.white),
                          ),
                        ),
                        SlideAnimation(
                          begin: const Offset(-1.5, 0),
                          duration: const Duration(seconds: 1),
                          delay: const Duration(milliseconds: 900),
                          child: Text(
                            "Shopping experience",
                            style: Theme.of(context).textTheme.titleMedium!
                                .copyWith(color: Colors.white),
                          ),
                        ),
                        const SizedBox(height: 8.0),
                        SlideAnimation(
                          begin: const Offset(-1.5, 0.5),
                          duration: const Duration(seconds: 1),
                          delay: const Duration(milliseconds: 600),
                          child: Text(
                            "For fancy clothes and accessories",
                            style: Theme.of(context).textTheme.bodyMedium!
                                .copyWith(color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

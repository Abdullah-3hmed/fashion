import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:e_fashion_flutter/config/router/app_router.dart';
import 'package:e_fashion_flutter/core/utils/assets_manager.dart';
import 'package:e_fashion_flutter/core/widgets/secondary_button.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class HomeHeader extends StatefulWidget {
  const HomeHeader({super.key});

  @override
  State<HomeHeader> createState() => _HomeHeaderState();
}

class _HomeHeaderState extends State<HomeHeader> {
  final PageController controller = PageController();
  int activeIndex = 0;

  Timer? _timer;

  static const List<Map<String, String>> slides = [
    {
      'image': AssetsManager.testImage,
      'title': 'Summer COLLECTION',
      'discount': '30% OFF',
      'subtitle': 'On all summer outfits',
    },
    {
      'image': AssetsManager.welcomeImage,
      'title': 'Spring COLLECTION',
      'discount': '50% OFF',
      'subtitle': 'Fresh styles for you',
    },
    {
      'image': AssetsManager.testImage,
      'title': 'Autumn COLLECTION',
      'discount': '20% OFF',
      'subtitle': 'Warm & Stylish',
    },
    {
      'image': AssetsManager.welcomeImage,
      'title': 'Winter COLLECTION',
      'discount': '40% OFF',
      'subtitle': 'Cozy Looks Await',
    },
  ];

  @override
  void initState() {
    super.initState();

    controller.addListener(() {
      final page = controller.page?.round() ?? 0;
      if (page != activeIndex) {
        setState(() => activeIndex = page);
      }
    });

    _timer = Timer.periodic(const Duration(seconds: 4), (_) {
      int nextIndex = (controller.page?.round() ?? 0) + 1;
      if (nextIndex >= slides.length) nextIndex = 0;

      controller.animateToPage(
        nextIndex,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    });
  }

  @override
  void dispose() {
    controller.dispose();
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        AnimatedSwitcher(
          duration: const Duration(milliseconds: 500),
          child: ClipRRect(
            key: ValueKey(activeIndex),
            borderRadius: const BorderRadiusDirectional.only(
              bottomStart: Radius.circular(32.0),
              bottomEnd: Radius.circular(32.0),
            ),
            child: Image.asset(
              slides[activeIndex]['image']!,
              fit: BoxFit.cover,
              height: 320,
              width: double.infinity,
            ),
          ),
        ),
        SizedBox(
          height: 320,
          width: double.infinity,
          child: PageView.builder(
            controller: controller,
            itemCount: slides.length,
            itemBuilder: (_, __) => const SizedBox.shrink(),
          ),
        ),
        PositionedDirectional(
          bottom: 24.0,
          start: 24.0,
          child: SmoothPageIndicator(
            controller: controller,
            count: slides.length,
            effect: const ExpandingDotsEffect(
              dotWidth: 30.0,
              dotHeight: 4.0,
              activeDotColor: Colors.white,
              expansionFactor: 1.25,
            ),
            onDotClicked: (index) {
              controller.animateToPage(
                index,
                duration: const Duration(milliseconds: 600),
                curve: Curves.easeInOut,
              );
            },
          ),
        ),
        PositionedDirectional(
          start: 16.0,
          bottom: 66.0,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                slides[activeIndex]['title']!,
                style: Theme.of(
                  context,
                ).textTheme.titleMedium!.copyWith(color: Colors.white),
              ),
              const SizedBox(height: 8.0),
              Container(
                width: 75.0,
                height: 1.84,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.white, width: 2.0),
                ),
              ),
              const SizedBox(height: 8.0),
              Text(
                slides[activeIndex]['discount']!,
                style: Theme.of(
                  context,
                ).textTheme.displayLarge!.copyWith(color: Colors.white),
              ),
              Text(
                slides[activeIndex]['subtitle']!,
                style: Theme.of(
                  context,
                ).textTheme.titleMedium!.copyWith(color: Colors.white),
              ),
            ],
          ),
        ),

        PositionedDirectional(
          top: 54.0,
          start: 24.0,
          end: 24.0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                onPressed: () {
                  context.pushRoute(const SearchRoute());
                },
                icon: const Icon(
                  Iconsax.search_normal_1,
                  color: Colors.white,
                  size: 24.0,
                ),
              ),
              IconButton(
                onPressed: () {
                  context.pushRoute(const NotificationRoute());
                },
                icon: const Icon(Iconsax.notification, color: Colors.white),
              ),
            ],
          ),
        ),

        PositionedDirectional(
          bottom: 32.0,
          end: 16.0,
          child: SecondaryButton(
            onPressed: () {
              context.pushRoute(const CollectionRoute());
            },
            text: "Shop now",
          ),
        ),
      ],
    );
  }
}

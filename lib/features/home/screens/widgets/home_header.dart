import 'package:e_fashion_flutter/core/utils/assets_manager.dart';
import 'package:e_fashion_flutter/core/widgets/secondary_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class HomeHeader extends StatefulWidget {
  const HomeHeader({super.key});

  @override
  State<HomeHeader> createState() => _HomeHeaderState();
}

class _HomeHeaderState extends State<HomeHeader> {
  final PageController controller = PageController();
  int activeIndex = 0;

  static const List<String> imageList = [
    AssetsManager.testImage,
    AssetsManager.welcomeImage,
  ];

  @override
  void initState() {
    controller.addListener(() {
      final page = controller.page?.round() ?? 0;
      if (page != activeIndex) {
        setState(() => activeIndex = page);
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Fade transition
        AnimatedSwitcher(
          duration: const Duration(milliseconds: 500),
          child: ClipRRect(
            key: ValueKey(activeIndex),
            borderRadius: const BorderRadiusDirectional.only(
              bottomStart: Radius.circular(32.0),
              bottomEnd: Radius.circular(32.0),
            ),
            child: Image.asset(
              imageList[activeIndex],
              fit: BoxFit.cover,
              height: 320,
              width: double.infinity,
            ),
          ),
        ),

        // Transparent PageView فقط لتغيير الصفحة
        SizedBox(
          height: 320,
          width: double.infinity,
          child: PageView.builder(
            controller: controller,
            itemCount: imageList.length,
            itemBuilder: (_, __) => const SizedBox.shrink(),
          ),
        ),

        // Indicator مربوط فعليًا
        PositionedDirectional(
          bottom: 24.0,
          start: 24.0,
          child: SmoothPageIndicator(
            controller: controller,
            count: imageList.length,
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

        // الباقي زي ما هو: النص، الزرار، الأيقونات
        PositionedDirectional(
          start: 16.0,
          bottom: 66.0,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Hijab COLLECTION",
                style: Theme.of(context).textTheme.titleMedium,
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
                "50% OFF",
                style: Theme.of(
                  context,
                ).textTheme.displayLarge!.copyWith(color: Colors.white),
              ),
              Text(
                "For Selected collection",
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ],
          ),
        ),

        PositionedDirectional(
          top: 64.0,
          start: 24.0,
          end: 24.0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              InkWell(
                onTap: () {},
                child: SvgPicture.asset(AssetsManager.search),
              ),
              InkWell(
                onTap: () {},
                child: SvgPicture.asset(AssetsManager.notification),
              ),
            ],
          ),
        ),

        PositionedDirectional(
          bottom: 32.0,
          end: 16.0,
          child: SecondaryButton(onPressed: () {}, text: "Check it"),
        ),
      ],
    );
  }
}

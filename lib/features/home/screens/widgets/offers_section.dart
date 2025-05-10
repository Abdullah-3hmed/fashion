import 'package:auto_route/auto_route.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:e_fashion_flutter/config/router/app_router.dart';
import 'package:e_fashion_flutter/features/home/screens/widgets/home_carousel_slider_item.dart';
import 'package:flutter/material.dart';

class OffersSection extends StatelessWidget {
  const OffersSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Offers", style: Theme.of(context).textTheme.bodyMedium),
            TextButton(
              style: ButtonStyle(
                padding: WidgetStateProperty.all<EdgeInsetsGeometry>(
                  EdgeInsets.zero,
                ),
              ),
              onPressed: () {
                context.pushRoute(const DiscoverRoute());
              },
              child: Text(
                "See All",
                style: Theme.of(context).textTheme.labelMedium!.copyWith(
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
            ),
          ],
        ),
        CarouselSlider(
          items: const [
            HomeCarouselSliderItem(),
            HomeCarouselSliderItem(),
            HomeCarouselSliderItem(),
          ],
          options: CarouselOptions(
            enlargeCenterPage: true,
            viewportFraction: 0.70,
          ),
        ),
      ],
    );
  }
}

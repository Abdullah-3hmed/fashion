import 'package:carousel_slider/carousel_slider.dart';
import 'package:e_fashion_flutter/features/home/screens/widgets/home_carousel_slider_item.dart';
import 'package:flutter/material.dart';

class OffersSection extends StatelessWidget {
  const OffersSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 16.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Offers", style: Theme.of(context).textTheme.bodyMedium),
            Text(
              "See All",
              style: Theme.of(context).textTheme.labelMedium!.copyWith(
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
          ],
        ),
        const SizedBox(height: 18.0),
        CarouselSlider(
          items: const [
            HomeCarouselSliderItem(),
            HomeCarouselSliderItem(),
            HomeCarouselSliderItem(),
          ],
          options: CarouselOptions(
            height: 220.0,
            enlargeCenterPage: true,
            autoPlay: true,
            viewportFraction: 0.7,
            autoPlayInterval: const Duration(seconds: 3),
            autoPlayAnimationDuration: const Duration(seconds: 1),
          ),
        ),
      ],
    );
  }
}

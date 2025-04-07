import 'package:e_fashion_flutter/features/home/screens/widgets/home_carousel_slider_item.dart';
import 'package:flutter/material.dart';

class ZaraSection extends StatelessWidget {
  const ZaraSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Zara", style: Theme.of(context).textTheme.bodyMedium),
            TextButton(
              style: ButtonStyle(
                padding: WidgetStateProperty.all<EdgeInsetsGeometry>(
                  EdgeInsets.zero,
                ),
              ),
              onPressed: () {},
              child: Text(
                "See All",
                style: Theme.of(context).textTheme.labelMedium!.copyWith(
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 8.0),
        SizedBox(
          height: 180.0,
          child: ListView.separated(
            physics: const BouncingScrollPhysics(),
            scrollDirection: Axis.horizontal,
            itemCount: 4,
            itemBuilder:
                (context, _) => const SizedBox(
                  width: 180.0,
                  child: HomeCarouselSliderItem(),
                ),
            separatorBuilder:
                (BuildContext context, int index) =>
                    const SizedBox(width: 12.0),
          ),
        ),
      ],
    );
  }
}

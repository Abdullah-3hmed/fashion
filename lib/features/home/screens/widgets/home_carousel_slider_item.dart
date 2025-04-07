import 'package:e_fashion_flutter/core/utils/assets_manager.dart';
import 'package:e_fashion_flutter/features/home/screens/widgets/home_clipped_container.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HomeCarouselSliderItem extends StatelessWidget {
  const HomeCarouselSliderItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          alignment: AlignmentDirectional.bottomCenter,
          children: [
            Container(
              width: double.infinity,
              height: 180.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16.0),
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: Image.asset(AssetsManager.testImage).image,
                ),
              ),
            ),
            HomeClippedContainer(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Denim Jacket",
                    style: Theme.of(
                      context,
                    ).textTheme.bodyLarge!.copyWith(color: Colors.white),
                  ),
                  Text(
                    r"$200 $150",
                    style: Theme.of(
                      context,
                    ).textTheme.bodyLarge!.copyWith(color: Colors.white),
                  ),
                ],
              ),
            ),
            PositionedDirectional(
              bottom: 15.0,
              end: 11.0,
              child: Icon(
                FontAwesomeIcons.cartShopping,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
            PositionedDirectional(
              top: 12.0,
              end: 12.0,
              child: Icon(
                FontAwesomeIcons.heart,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

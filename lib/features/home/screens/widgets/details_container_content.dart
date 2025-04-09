import 'package:auto_route/auto_route.dart';
import 'package:e_fashion_flutter/core/utils/assets_manager.dart';
import 'package:e_fashion_flutter/core/widgets/primary_button.dart';
import 'package:e_fashion_flutter/features/auth/screens/widgets/details_screen_colors.dart';
import 'package:e_fashion_flutter/features/home/screens/widgets/details_pieces%20available.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class DetailsContainerContent extends StatelessWidget {
  const DetailsContainerContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsetsDirectional.symmetric(horizontal: 24.0),
      child: SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 30.0),
            InkWell(
              onTap: () {
                context.pop();
              },
              child: CircleAvatar(
                backgroundColor: Theme.of(context).colorScheme.primary,
                radius: 24.0,
                child: Icon(
                  Icons.arrow_back,
                  color: Theme.of(context).colorScheme.onPrimary,
                ),
              ),
            ),
            const SizedBox(height: 24.0),
            Text(
              "Denim Jacket",
              style: Theme.of(context).textTheme.titleMedium,
            ),
            Text(r"$350", style: Theme.of(context).textTheme.bodyLarge),
            const SizedBox(height: 24.0),
            Row(
              children: [
                Text("Color : ", style: Theme.of(context).textTheme.bodyMedium),
                const SizedBox(width: 18.0),
                const DetailsScreenColors(),
              ],
            ),
            const DetailsPiecesAvailable(),
            Text(
              "Bellylady Women Overcoat Fashionable Double-sided Faux Cashmere Coat Solid Color Lapel d-length Style Coat color",
              style: Theme.of(context).textTheme.bodySmall,
            ),
            const SizedBox(height: 24.0),
            PrimaryButton(
              icon: SvgPicture.asset(AssetsManager.cart),
              onPressed: () {},
              text: "Add to bag",
            ),
            const SizedBox(height: 24.0),
            Text(
              "Rate this product",
              style: Theme.of(context).textTheme.labelMedium,
            ),
            Text(
              "Tell others what you think",
              style: Theme.of(context).textTheme.bodySmall,
            ),
            const SizedBox(height: 24.0),
            RatingBar.builder(
              allowHalfRating: true,
              itemPadding: const EdgeInsets.symmetric(horizontal: 15.0),
              itemBuilder:
                  (context, _) =>
                      const Icon(FontAwesomeIcons.star, color: Colors.amber),
              onRatingUpdate: (rating) {},
            ),
            const SizedBox(height: 16.0),
            Align(
              child: Text(
                "Write a review",
                style: Theme.of(context).textTheme.bodySmall!.copyWith(
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
            ),
            const SizedBox(height: 24.0),
            Text(
              "Rating and Reviews",
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            Text(
              "See what others think about this product",
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 24.0),
            Align(
              child: Text(
                "4.9",
                style: Theme.of(context).textTheme.headlineSmall,
              ),
            ),
            const SizedBox(height: 24.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                for (int i = 1; i <= 5; i++) const Icon(FontAwesomeIcons.star),
              ],
            ),
            const SizedBox(height: 24.0),
            Align(
              child: Text(
                "0 Reviews",
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ),
            const SizedBox(height: 24.0),
            for (int i = 1; i <= 5; i++)
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("$i", style: Theme.of(context).textTheme.bodyLarge),
                  const Icon(Icons.star, color: Colors.amber),
                  const SizedBox(width: 16.0),
                  Container(
                    height: 8.0,
                    width: 220,
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.onPrimary,
                      borderRadius: BorderRadius.circular(100.0),
                    ),
                  ),
                ],
              ),
            const SizedBox(height: 40.0),
          ],
        ),
      ),
    );
  }
}

import 'package:auto_route/auto_route.dart';
import 'package:e_fashion_flutter/core/widgets/primary_button.dart';
import 'package:e_fashion_flutter/features/home/screens/widgets/colors_available.dart';
import 'package:e_fashion_flutter/features/home/screens/widgets/pieces_available.dart';
import 'package:e_fashion_flutter/features/home/screens/widgets/rating_section.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class DetailsContainerContent extends StatelessWidget {
  const DetailsContainerContent({super.key, required this.controller});

  final ScrollController controller;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      controller: controller,
      physics: const BouncingScrollPhysics(),
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
          Text("Denim Jacket", style: Theme.of(context).textTheme.titleMedium),
          Text(r"$350", style: Theme.of(context).textTheme.bodyLarge),
          const SizedBox(height: 24.0),
          ColorsAvailable(
            onColorChanged: (color) => debugPrint(color.toString()),
          ),
          PiecesAvailable(
            onPiecesChanged: (int value) {
              debugPrint(value.toString());
            },
          ),
          Text(
            "Belly lady Women Overcoat Fashionable Double-sided Faux Cashmere Coat Solid Color Lapel d-length Style Coat color",
            style: Theme.of(context).textTheme.bodySmall,
          ),
          const SizedBox(height: 24.0),
          PrimaryButton(
            icon: Icon(
              Iconsax.bag_2,
              color: Theme.of(context).colorScheme.onPrimary,
            ),
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
          const RatingSection(),
          const SizedBox(height: 40.0),
        ],
      ),
    );
  }
}

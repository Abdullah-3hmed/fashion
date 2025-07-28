import 'package:auto_route/auto_route.dart';
import 'package:e_fashion_flutter/core/widgets/primary_button.dart';
import 'package:e_fashion_flutter/features/home/data/home_details/product_details_model.dart';
import 'package:e_fashion_flutter/features/home/screens/widgets/details/rating_section.dart';
import 'package:e_fashion_flutter/features/home/screens/widgets/shared/colors_available.dart';
import 'package:e_fashion_flutter/features/home/screens/widgets/shared/pieces_available.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class ProductDetails extends StatelessWidget {
  const ProductDetails({
    super.key,
    required this.controller,
    required this.productDetailsModel,
  });

  final ScrollController controller;
  final ProductDetailsModel productDetailsModel;

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      controller: controller,
      physics: const BouncingScrollPhysics(),
      slivers: [
        SliverToBoxAdapter(
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
                productDetailsModel.title,
                style: Theme.of(context).textTheme.titleMedium,
              ),
              Text(
                r"$"
                "${productDetailsModel.price}",
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              const SizedBox(height: 24.0),
              ColorsAvailable(
                colors: productDetailsModel.parsedColors,
                onColorChanged: (color) => debugPrint(color.toString()),
              ),
              PiecesAvailable(
                onPiecesChanged: (int value) {
                  debugPrint(value.toString());
                },
              ),
              Text(
              "********",
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
              RatingSection(productDetailsModel: productDetailsModel),
              const SizedBox(height: 40.0),
            ],
          ),
        ),
      ],
    );
  }
}

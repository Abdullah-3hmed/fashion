import 'package:auto_route/auto_route.dart';
import 'package:e_fashion_flutter/config/router/app_router.dart';
import 'package:e_fashion_flutter/features/home/cubit/home_cubit.dart';
import 'package:e_fashion_flutter/features/home/cubit/home_state.dart';
import 'package:e_fashion_flutter/features/home/cubit/product_details_cubit.dart';
import 'package:e_fashion_flutter/features/home/cubit/product_details_state.dart';
import 'package:e_fashion_flutter/features/home/data/home_details/product_details_model.dart';
import 'package:e_fashion_flutter/features/home/screens/widgets/details/review_section.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class RatingSection extends StatelessWidget {
  const RatingSection({super.key, required this.productDetailsModel});

  final ProductDetailsModel productDetailsModel;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        RatingBar.builder(
          allowHalfRating: true,
          itemSize: 32.0,
          initialRating: context.select(
            (ProductDetailsCubit cubit) => cubit.state.rate,
          ),
          itemPadding: const EdgeInsets.symmetric(horizontal: 12.0),
          itemBuilder:
              (context, _) =>
                  const Icon(FontAwesomeIcons.star, color: Colors.amber),
          onRatingUpdate: (double newRating) {
            context.read<ProductDetailsCubit>().rateProduct(rate: newRating);
          },
        ),
        const SizedBox(height: 16.0),
        Align(
          child: TextButton(
            onPressed: () {
              context.pushRoute(
                EditReviewRoute(productDetailsModel: productDetailsModel),
              );
            },
            child: Text(
               "Write a review",
              style: Theme.of(context).textTheme.bodySmall!.copyWith(
                color: Theme.of(context).colorScheme.primary,
              ),
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
            " ${context.select((ProductDetailsCubit cubit) => cubit.state.rate)}",
            style: Theme.of(context).textTheme.headlineSmall,
          ),
        ),
        const SizedBox(height: 24.0),
        Align(
          child: RatingBarIndicator(
            rating: context.select(
              (ProductDetailsCubit cubit) => cubit.state.rate,
            ),
            itemBuilder:
                (context, index) => const Icon(Icons.star, color: Colors.amber),
            itemSize: 24.0,
            itemPadding: const EdgeInsets.symmetric(horizontal: 8.0),
          ),
        ),
        const SizedBox(height: 24.0),
        Align(
          child: Text(
            "${context.select((ProductDetailsCubit cubit) => cubit.state.productDetailsModel.reviews).length} reviews",
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ),
        const SizedBox(height: 24.0),
        for (int i = 1; i <= 5; i++)
          Row(
            children: [
              Text("$i", style: Theme.of(context).textTheme.bodyLarge),
              const SizedBox(width: 4.0),
              const Icon(Icons.star, color: Colors.amber),
              const SizedBox(width: 16.0),
              Expanded(
                child: LinearProgressIndicator(
                  value: _calculateRating(
                    i: i,
                    rating: context.select(
                      (ProductDetailsCubit cubit) => cubit.state.rate,
                    ),
                  ),
                  minHeight: 8,
                  backgroundColor: Colors.grey[300],
                  valueColor: const AlwaysStoppedAnimation<Color>(Colors.amber),
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ],
          ),
        const SizedBox(height: 24.0),
        BlocBuilder<ProductDetailsCubit, ProductDetailsState>(
          buildWhen:
              (previous, current) =>
                  previous.productDetailsModel.reviews !=
                  current.productDetailsModel.reviews,
          builder: (context, state) {
            final reviews = state.productDetailsModel.reviews;
            return reviews.isEmpty
                ? const SizedBox.shrink()
                : ReviewSection(reviews: reviews);
          },
        ),
      ],
    );
  }

  double _calculateRating({required int i, required double rating}) =>
      rating.floor() == i ? 1.0 : 0.0;
}

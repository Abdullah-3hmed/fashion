import 'package:auto_route/auto_route.dart';
import 'package:e_fashion_flutter/config/router/app_router.dart';
import 'package:e_fashion_flutter/features/home/cubit/home_cubit.dart';
import 'package:e_fashion_flutter/features/home/cubit/home_state.dart';
import 'package:e_fashion_flutter/features/home/data/product_details_model.dart';
import 'package:e_fashion_flutter/features/home/screens/widgets/review_section.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class RatingSection extends StatefulWidget {
  const RatingSection({super.key, required this.productDetailsModel});

  final ProductDetailsModel productDetailsModel;

  @override
  State<RatingSection> createState() => _RatingSectionState();
}

class _RatingSectionState extends State<RatingSection> with AutoRouteAware {
  double rating = 0.0;
  AutoRouteObserver? _observer;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _observer =
        RouterScope.of(context).firstObserverOfType<AutoRouteObserver>();
    if (_observer != null) {
      _observer?.subscribe(this, context.routeData);
    }
  }

  @override
  void dispose() {
    super.dispose();
    _observer?.unsubscribe(this);
  }

  @override
  void didPopNext() {
    setState(() {
      rating = 0.0;
    });
  }

  @override
  Widget build(BuildContext context) {
    final ProductDetailsModel product = widget.productDetailsModel;

    return Column(
      children: [
        RatingBar.builder(
          allowHalfRating: true,
          itemSize: 32.0,
          initialRating: rating,
          itemPadding: const EdgeInsets.symmetric(horizontal: 12.0),
          itemBuilder:
              (context, _) =>
                  const Icon(FontAwesomeIcons.star, color: Colors.amber),
          onRatingUpdate: (newRating) {
            setState(() {
              rating = newRating;
            });
          },
        ),
        const SizedBox(height: 16.0),
        Align(
          child: TextButton(
            onPressed: () {
              context.pushRoute(
                EditReviewRoute(productDetailsModel: product, rating: rating),
              );
            },
            child: Text(
              rating == 0 ? "Write a review" : "Edit review",
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
            " $rating",
            style: Theme.of(context).textTheme.headlineSmall,
          ),
        ),
        const SizedBox(height: 24.0),
        Align(
          child: RatingBarIndicator(
            rating: rating,
            itemBuilder:
                (context, index) => const Icon(Icons.star, color: Colors.amber),
            itemSize: 24.0,
            itemPadding: const EdgeInsets.symmetric(horizontal: 8.0),
          ),
        ),
        const SizedBox(height: 24.0),
        Align(
          child: Text(
            "${context.watch<HomeCubit>().state.productDetailsModel.reviews.length} reviews",
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
                  value: _calculateRating(i: i),
                  minHeight: 8,
                  backgroundColor: Colors.grey[300],
                  valueColor: const AlwaysStoppedAnimation<Color>(Colors.amber),
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ],
          ),
        const SizedBox(height: 24.0),
        BlocBuilder<HomeCubit, HomeState>(
          buildWhen:
              (previous, current) =>
                  previous.productDetailsModel.reviews !=
                  current.productDetailsModel.reviews,
          builder: (context, state) {
            final reviews = state.productDetailsModel.reviews;
            return reviews.isEmpty
                ? const SizedBox.shrink()
                : ReviewSection(review: reviews);
          },
        ),
      ],
    );
  }

  double _calculateRating({required int i}) {
    return rating.floor() == i ? 1.0 : 0.0;
  }
}

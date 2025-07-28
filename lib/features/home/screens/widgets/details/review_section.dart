import 'package:cached_network_image/cached_network_image.dart';
import 'package:e_fashion_flutter/features/home/data/home_details/review_model.dart';
import 'package:flutter/material.dart';

class ReviewSection extends StatelessWidget {
  const ReviewSection({super.key, required this.reviews});

  final List<ReviewModel> reviews;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        return Container(
          padding: const EdgeInsetsDirectional.symmetric(
            horizontal: 12.0,
            vertical: 16.0,
          ),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surfaceContainerHighest,
            borderRadius: BorderRadius.circular(12.0),
          ),
          child: Column(
            children: [
              Row(
                children: [
                  CircleAvatar(
                    radius: 20.0,
                    backgroundImage: CachedNetworkImageProvider(
                      reviews[index].imageUrl,
                    ),
                  ),
                  const SizedBox(width: 16.0),
                  Text(
                    reviews[index].name,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ],
              ),
              const SizedBox(height: 4.0),
              Row(
                children: [
                  for (int i = 1; i <= reviews[index].rate; i++)
                    const Icon(Icons.star, color: Colors.amber, size: 16.0),
                  const SizedBox(width: 11.0),
                  Text(
                    reviews[index].name,
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ],
              ),
              const SizedBox(height: 8.0),
              Align(
                alignment: AlignmentDirectional.centerStart,
                child: Text(
                  reviews[index].review.isEmpty?"No Comments Available":reviews[index].review,
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ),
            ],
          ),
        );
      },
      separatorBuilder: (context, index) => const SizedBox(height: 16.0),
      itemCount: reviews.length,
    );
  }
}

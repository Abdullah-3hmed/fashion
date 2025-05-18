import 'package:cached_network_image/cached_network_image.dart';
import 'package:e_fashion_flutter/features/home/cubit/home_cubit.dart';
import 'package:e_fashion_flutter/features/home/cubit/home_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ReviewSection extends StatelessWidget {
  const ReviewSection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      buildWhen:
          (previous, current) =>
              previous.productDetailsModel != current.productDetailsModel,
      builder: (context, state) {
        return ListView.separated(
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
                          state.productDetailsModel.reviews[index].userImage,
                        ),
                      ),
                      const SizedBox(width: 16.0),
                      Text(
                        state.productDetailsModel.reviews[index].userName,
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ],
                  ),
                  const SizedBox(height: 4.0),
                  Row(
                    children: [
                      for (
                        int i = 1;
                        i <= state.productDetailsModel.reviews[index].rating;
                        i++
                      )
                        const Icon(Icons.star, color: Colors.amber, size: 16.0),
                      const SizedBox(width: 11.0),
                      Text(
                        state.productDetailsModel.reviews[index].date,
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ],
                  ),
                  const SizedBox(height: 8.0),
                  Text(
                    state.productDetailsModel.reviews[index].review,
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ],
              ),
            );
          },
          separatorBuilder: (context, index) => const SizedBox(height: 16.0),
          itemCount: state.productDetailsModel.reviews.length,
        );
      },
    );
  }
}

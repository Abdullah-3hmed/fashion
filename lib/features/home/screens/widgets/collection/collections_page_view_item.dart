import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:e_fashion_flutter/config/router/app_router.dart';
import 'package:e_fashion_flutter/core/widgets/custom_cached_network_image.dart';
import 'package:e_fashion_flutter/core/widgets/secondary_button.dart';
import 'package:e_fashion_flutter/features/home/cubit/home_cubit/home_cubit.dart';
import 'package:e_fashion_flutter/features/home/data/home/collection_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CollectionsPageViewItem extends StatelessWidget {
  const CollectionsPageViewItem({super.key, required this.collection});

  final CollectionModel collection;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadiusDirectional.only(
        bottomStart: Radius.circular(32.0),
        bottomEnd: Radius.circular(32.0),
      ),
      child: Stack(
        children: [
          CustomCachedNetworkImage(
            imageUrl: collection.imageUrl,
            height: 320,
            width: double.infinity,
          ),
          PositionedDirectional(
            start: 16.0,
            bottom: 66.0,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  collection.title,
                  style: Theme.of(
                    context,
                  ).textTheme.titleMedium!.copyWith(color: Colors.white),
                ),
                const SizedBox(height: 8.0),
                Container(
                  width: 75.0,
                  height: 1.84,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.white, width: 2.0),
                  ),
                ),
                const SizedBox(height: 8.0),
                Text(
                  collection.description,
                  style: Theme.of(
                    context,
                  ).textTheme.displayLarge!.copyWith(color: Colors.white),
                ),
                Text(
                  collection.subTitle,
                  style: Theme.of(
                    context,
                  ).textTheme.titleMedium!.copyWith(color: Colors.white),
                ),
              ],
            ),
          ),
          PositionedDirectional(
            bottom: 20.0,
            end: 16.0,
            child: SecondaryButton(
              onPressed: () async {
                context.pushRoute(
                  CollectionRoute(collectionId: collection.id,title: collection.title),
                );
              },
              text: "Shop now",
            ),
          ),
        ],
      ),
    );
  }
}

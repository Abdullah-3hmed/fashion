import 'package:cached_network_image/cached_network_image.dart';
import 'package:e_fashion_flutter/core/widgets/custom_cached_network_image.dart';
import 'package:e_fashion_flutter/features/home/data/home/collection_item_model.dart';
import 'package:flutter/material.dart';

class ReverseCollectionItem extends StatelessWidget {
  const ReverseCollectionItem({super.key, required this.collectionItemModel});

  final CollectionItemModel collectionItemModel;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 186.0,
      width: double.infinity,
      padding: const EdgeInsetsDirectional.only(
        start: 40.0,
        top: 8.0,
        bottom: 8.0,
        end: 8.0,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16.0),
        color: Theme.of(context).colorScheme.surfaceContainerHighest,
      ),
      child: Row(
        children: [
          Expanded(
            child: SizedBox(
              width: 100.0,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    collectionItemModel.title,
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  const SizedBox(width: 16.0),
                  Text(
                    collectionItemModel.description,
                    maxLines: 8,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(width: 16.0),
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16.0),
              child: CustomCachedNetworkImage(
                height: 180.0,
                imageUrl: collectionItemModel.imageUrl,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

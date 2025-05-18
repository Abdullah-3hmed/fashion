import 'package:cached_network_image/cached_network_image.dart';
import 'package:e_fashion_flutter/features/home/data/collection_details_product.dart';
import 'package:flutter/material.dart';

class CollectionItem extends StatelessWidget {
  const CollectionItem({super.key, required this.product});

  final CollectionDetailsProduct product;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 186.0,
      width: double.infinity,
      padding: const EdgeInsetsDirectional.only(
        start: 8.0,
        top: 8.0,
        bottom: 8.0,
        end: 40.0,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16.0),
        color: Theme.of(context).colorScheme.surfaceContainerHighest,
      ),
      child: Row(
        children: [
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16.0),
              child: CachedNetworkImage(
                imageUrl: product.imageUrl,
                fit: BoxFit.cover,
                errorWidget: (context, url, error) => const Icon(Icons.error),
              ),
            ),
          ),
          const SizedBox(width: 16.0),
          Expanded(
            child: SizedBox(
              width: 100.0,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.productName,
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  const SizedBox(width: 16.0),
                  Text(
                    product.description,
                    maxLines: 8,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

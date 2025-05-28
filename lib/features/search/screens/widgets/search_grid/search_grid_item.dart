import 'package:cached_network_image/cached_network_image.dart';
import 'package:e_fashion_flutter/features/search/data/search_model.dart';
import 'package:e_fashion_flutter/features/search/screens/widgets/search_grid/search_grid_container_clipper.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class SearchGridItem extends StatelessWidget {
  const SearchGridItem({super.key, required this.searchModel});

  final SearchModel searchModel;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(16.0),
          child: CachedNetworkImage(
            imageUrl: searchModel.imageUrl,
            fit: BoxFit.cover,
            height: 180.0,
            width: double.infinity,
            errorWidget: (context, url, error) => const Icon(Icons.error),
          ),
        ),
        PositionedDirectional(
          bottom: 0.0,
          start: 0.0,
          end: 0.0,
          child: ClipPath(
            clipper: SearchGridContainerClipper(),
            child: Container(
              height: 64.0,
              width: double.infinity,
              decoration: const BoxDecoration(
                color: Color(0xFF203343),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(16.0),
                  bottomRight: Radius.circular(16.0),
                ),
              ),
              child: Row(
                children: [
                  const SizedBox(width: 12.0),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        searchModel.name.length > 8
                            ? '${searchModel.name.substring(0, 8)}...'
                            : searchModel.name,
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      Text(
                        r"$"
                        "${searchModel.price}",
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ],
                  ),
                  const Spacer(),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Iconsax.bag_2, color: Color(0xFF4A96D8)),
                  ),
                  const Spacer(),
                ],
              ),
            ),
          ),
        ),
        PositionedDirectional(
          top: 12.0,
          end: 12.0,
          child: CircleAvatar(
            radius: 16.0,
            backgroundColor: Colors.white.withValues(alpha: 0.15),
            child: Icon(
              Iconsax.heart,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
        ),
      ],
    );
  }
}

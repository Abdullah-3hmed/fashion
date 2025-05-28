import 'package:cached_network_image/cached_network_image.dart';
import 'package:e_fashion_flutter/features/search/data/search_model.dart';
import 'package:e_fashion_flutter/features/search/screens/widgets/search_list/search_list_container_clipper.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class SearchListViewItem extends StatelessWidget {
  const SearchListViewItem({super.key, required this.searchModel});

  final SearchModel searchModel;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: AlignmentDirectional.bottomCenter,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(16.0),
          child: CachedNetworkImage(
            imageUrl: searchModel.imageUrl,
            errorWidget: (context, url, error) => const Icon(Icons.error),
            fit: BoxFit.cover,
            height: 220.0,
            width: double.infinity,
          ),
        ),
        PositionedDirectional(
          bottom: -1.0,
          start: 0.0,
          end: 0.0,
          child: ClipPath(
            clipper: SearchListContainerClipper(),
            child: Container(
              height: 82.0,
              width: double.infinity,
              decoration: const BoxDecoration(
                color: Color(0xFF203343),
                borderRadius: BorderRadiusDirectional.only(
                  bottomStart: Radius.circular(16.0),
                  bottomEnd: Radius.circular(16.0),
                ),
              ),
              child: Row(
                children: [
                  const Spacer(),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        searchModel.name.length > 18
                            ? '${searchModel.name.substring(0, 18)}...'
                            : searchModel.name,
                        style: Theme.of(context).textTheme.titleLarge,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        r"$"
                        "${searchModel.price}",
                        style: Theme.of(context).textTheme.titleSmall,
                      ),
                    ],
                  ),
                  const Spacer(),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Iconsax.bag_2, color: Colors.white),
                  ),
                  const SizedBox(width: 16.0),
                ],
              ),
            ),
          ),
        ),
        PositionedDirectional(
          top: 16.0,
          end: 16.0,
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

import 'package:cached_network_image/cached_network_image.dart';
import 'package:e_fashion_flutter/core/widgets/modal_bottom_sheet_content.dart';
import 'package:e_fashion_flutter/features/home/data/discover_model.dart';
import 'package:e_fashion_flutter/features/home/screens/widgets/discover/discover_grid/discover_grid_clipped_container.dart';
import 'package:e_fashion_flutter/features/home/screens/widgets/discover/discover_grid/discover_grid_clipped_image.dart';
import 'package:e_fashion_flutter/features/home/screens/widgets/discover/discover_grid/discover_top_grid_clipped_image.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class DiscoverGridItem extends StatelessWidget {
  const DiscoverGridItem({
    super.key,
    required this.discoverModel,
    required this.isFirstItem,
  });

  final DiscoverModel discoverModel;
  final bool isFirstItem;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: AlignmentDirectional.bottomCenter,
      children: [
        ClipPath(
          clipper:
              isFirstItem
                  ? DiscoverTopGridClippedImage()
                  : DiscoverGridClippedImage(),
          child: ClipRRect(
            borderRadius:
                isFirstItem
                    ? const BorderRadiusDirectional.only(
                      topStart: Radius.circular(16.0),
                    )
                    : BorderRadiusDirectional.zero,
            child: CachedNetworkImage(
              imageUrl: discoverModel.image,
              height: isFirstItem ? 200.0 : 220.0,
              width: double.infinity,
              fit: BoxFit.cover,
              errorWidget: (context, url, error) => const Icon(Icons.error),
            ),
          ),
        ),
        CustomPaint(
          painter: DiscoverGridClippedContainer(),
          child: SizedBox(
            height: 72.0,
            child: Row(
              textDirection: TextDirection.ltr,
              children: [
                const SizedBox(width: 13.0),
                InkWell(
                  onTap: () async {
                    await showModalBottomSheet(
                      context: context,
                      builder: (context) => const ModalBottomSheetContent(),
                    );
                  },
                  child: Icon(
                    Iconsax.bag_2,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
                const SizedBox(width: 13.0),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      discoverModel.name.length > 7
                          ? '${discoverModel.name.substring(0, 7)}...'
                          : discoverModel.name,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(
                        context,
                      ).textTheme.bodyLarge!.copyWith(color: Colors.white),
                    ),
                    Text(
                      r"$"
                      "${discoverModel.price}",
                      style: Theme.of(
                        context,
                      ).textTheme.bodyLarge!.copyWith(color: Colors.white),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        Positioned(
          top: 22.0,
          left: 10.0,
          child: InkWell(
            onTap: () {},
            child: CircleAvatar(
              radius: 16.0,
              backgroundColor: Colors.white,
              child: Icon(
                Iconsax.heart,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

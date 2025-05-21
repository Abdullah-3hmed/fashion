import 'package:cached_network_image/cached_network_image.dart';
import 'package:e_fashion_flutter/core/widgets/modal_bottom_sheet_content.dart';
import 'package:e_fashion_flutter/features/home/data/discover_model.dart';
import 'package:e_fashion_flutter/features/home/screens/widgets/discover/discover_list/discover_list_clipped_container.dart';
import 'package:e_fashion_flutter/features/home/screens/widgets/discover/discover_list/discover_list_image_clipper.dart';
import 'package:e_fashion_flutter/features/home/screens/widgets/discover/discover_list/discover_list_top_image_clipper.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class DiscoverListItem extends StatelessWidget {
  const DiscoverListItem({
    super.key,
    required this.discoverModel,
    required this.isFirstItem,
  });

  final DiscoverModel discoverModel;
  final bool isFirstItem;

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        ClipPath(
          clipper:
              isFirstItem
                  ? DiscoverListTopImageClipper()
                  : DiscoverListImageClipper(),
          child: ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(16.0),
              topRight: Radius.circular(16.0),
            ),
            child: CachedNetworkImage(
              imageUrl: discoverModel.image,
              height: isFirstItem ? 300.0 : 320.0,
              width: double.infinity,
              fit: BoxFit.cover,
              errorWidget: (context, url, error) => const Icon(Icons.error),
            ),
          ),
        ),
        PositionedDirectional(
          bottom: isFirstItem ? -0.5 : -2.0,
          start: 0.0,
          end: 0.0,
          child: CustomPaint(
            painter: DiscoverListClippedContainer(),
            child: SizedBox(
              height: 112.0,
              child: Row(
                children: [
                  const Spacer(flex: 2),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        discoverModel.name.length > 20
                            ? '${discoverModel.name.substring(0, 20)}...'
                            : discoverModel.name,
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
                      const SizedBox(width: 16.0),
                    ],
                  ),
                  const Spacer(),
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
                  const SizedBox(width: 25.0),
                ],
              ),
            ),
          ),
        ),
        PositionedDirectional(
          top: isFirstItem ? 16.0 : 45.0,
          end: 16.0,
          child: InkWell(
            onTap: () {},
            child: CircleAvatar(
              radius: 18.0,
              backgroundColor: Colors.white.withValues(alpha: 0.15),
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

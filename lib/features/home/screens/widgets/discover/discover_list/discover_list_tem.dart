import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:e_fashion_flutter/config/router/app_router.dart';
import 'package:e_fashion_flutter/core/widgets/custom_cached_network_image.dart';
import 'package:e_fashion_flutter/core/widgets/modal_bottom_sheet_content.dart';
import 'package:e_fashion_flutter/features/home/screens/widgets/discover/discover_list/discover_list_clipped_container.dart';
import 'package:e_fashion_flutter/features/home/screens/widgets/discover/discover_list/discover_list_image_clipper.dart';
import 'package:e_fashion_flutter/features/home/screens/widgets/discover/discover_list/discover_list_top_image_clipper.dart';
import 'package:e_fashion_flutter/shared/data/product_model.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class DiscoverListItem extends StatelessWidget {
  const DiscoverListItem({
    super.key,
    required this.isFirstItem,
    required this.product,
  });

  final ProductModel product;
  final bool isFirstItem;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        context.pushRoute(
          ProductDetailsRoute(
            productId: product.id,
            imageUrl: product.imageUrl,
          ),
        );
      },
      child: Stack(
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
              child: CustomCachedNetworkImage(
                imageUrl: product.imageUrl,
                height: isFirstItem ? 300.0 : 320.0,
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
                    Expanded(
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              product.title,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: Theme.of(
                                context,
                              ).textTheme.bodyLarge!.copyWith(color: Colors.white),
                            ),
                            Text(
                              r"$"
                              "${product.basePrice}",
                              style: Theme.of(
                                context,
                              ).textTheme.bodyLarge!.copyWith(color: Colors.white),
                            ),
                            const SizedBox(width: 16.0),
                          ],
                        ),
                      ),
                    ),

                    InkWell(
                      onTap: () async {
                        await showModalBottomSheet(
                          context: context,
                          builder:
                              (context) =>
                                  ModalBottomSheetContent(productModel: product),
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
            top: isFirstItem ? 8.0 : 45.0,
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
      ),
    );
  }
}

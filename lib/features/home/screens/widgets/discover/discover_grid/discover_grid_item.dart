import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:e_fashion_flutter/config/router/app_router.dart';
import 'package:e_fashion_flutter/core/widgets/custom_cached_network_image.dart';
import 'package:e_fashion_flutter/core/widgets/custom_heart_icon.dart';
import 'package:e_fashion_flutter/core/widgets/modal_bottom_sheet_content.dart';
import 'package:e_fashion_flutter/features/home/screens/widgets/discover/discover_grid/discover_grid_clipped_container.dart';
import 'package:e_fashion_flutter/features/home/screens/widgets/discover/discover_grid/discover_grid_clipped_image.dart';
import 'package:e_fashion_flutter/features/home/screens/widgets/discover/discover_grid/discover_top_grid_clipped_image.dart';
import 'package:e_fashion_flutter/shared/data/product_model.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class DiscoverGridItem extends StatelessWidget {
  const DiscoverGridItem({
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
              child: CustomCachedNetworkImage(
                imageUrl: product.imageUrl,
                height: isFirstItem ? 200.0 : 220.0,
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
                        builder: (context) =>  ModalBottomSheetContent(productModel: product,),
                      );
                    },
                    child: Icon(
                      Iconsax.bag_2,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                  const SizedBox(width: 13.0),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
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
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          PositionedDirectional(
            top: 30.0,
            start: 10.0,
            child: InkWell(
              onTap: () {},
              child: CircleAvatar(
                radius: 16.0,
                backgroundColor: Colors.white.withValues(alpha: 0.15),
                child: CustomHeartIcon(productModel: product),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

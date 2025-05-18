import 'package:cached_network_image/cached_network_image.dart';
import 'package:e_fashion_flutter/core/widgets/modal_bottom_sheet_content.dart';
import 'package:e_fashion_flutter/features/home/data/product_model.dart';
import 'package:e_fashion_flutter/features/home/screens/widgets/home_clipped_container.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class BrandSectionItem extends StatelessWidget {
  const BrandSectionItem({super.key, required this.productModel});
  final ProductModel productModel;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        InkWell(
          onTap: () {
            // context.pushRoute( ProductDetailsRoute());
          },
          child: ClipRRect(
            borderRadius: BorderRadius.circular(16.0),
            child: CachedNetworkImage(
              height: 180.0,
              width: double.infinity,
              fit: BoxFit.cover,
              imageUrl: productModel.imageUrl,
              errorWidget: (context, url, error) => const Icon(Icons.error),
            ),
          ),
        ),
        PositionedDirectional(
          bottom: 0.0,
          start: 0.0,
          end: 0.0,
          child: InkWell(
            onTap: () {
              // context.pushRoute(const ProductDetailsRoute());
            },
            child: HomeClippedContainer(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 10.0),
                  Text(
                    productModel.name.length > 20
                        ? '${productModel.name.substring(0, 20)}...'
                        : productModel.name,
                    maxLines: 1,

                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(
                      context,
                    ).textTheme.bodyLarge!.copyWith(color: Colors.white),
                  ),
                  //TODO:replace this with price
                  const SizedBox(height: 4.0),
                ],
              ),
            ),
          ),
        ),
        PositionedDirectional(
          bottom: 0.0,
          end: 0.0,
          child: IconButton(
            onPressed: () async {
              await showModalBottomSheet(
                context: context,
                useRootNavigator: true,
                builder: (context) => const ModalBottomSheetContent(),
              );
            },
            icon: Icon(
              Iconsax.bag_2,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
        ),
        PositionedDirectional(
          top: 0.0,
          end: 0.0,
          child: IconButton(
            onPressed: () {},
            icon: Icon(
              Iconsax.heart,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
        ),
      ],
    );
  }
}

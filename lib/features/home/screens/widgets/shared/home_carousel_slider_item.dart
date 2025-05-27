import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:e_fashion_flutter/config/router/app_router.dart';
import 'package:e_fashion_flutter/core/widgets/modal_bottom_sheet_content.dart';
import 'package:e_fashion_flutter/features/home/data/offer_model.dart';
import 'package:e_fashion_flutter/features/home/screens/widgets/shared/home_clipped_container.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class HomeCarouselSliderItem extends StatelessWidget {
  const HomeCarouselSliderItem({super.key, required this.offerModel});

  final OfferModel offerModel;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        InkWell(
          onTap: () {
            context.pushRoute(
              ProductDetailsRoute(
                imageUrl: offerModel.imageUrl,
                productId: offerModel.id,
              ),
            );
          },
          child: ClipRRect(
            borderRadius: BorderRadius.circular(16.0),
            child: CachedNetworkImage(
              height: 180.0,
              width: double.infinity,
              fit: BoxFit.cover,
              imageUrl: offerModel.imageUrl,
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
              context.pushRoute(
                ProductDetailsRoute(
                  imageUrl: offerModel.imageUrl,
                  productId: offerModel.id,
                ),
              );
            },
            child: HomeClippedContainer(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 10.0),
                  Text(
                    offerModel.name.length > 20
                        ? '${offerModel.name.substring(0, 20)}...'
                        : offerModel.name,
                    maxLines: 1,

                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(
                      context,
                    ).textTheme.bodyLarge!.copyWith(color: Colors.white),
                  ),
                  Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                          text:
                              r"$"
                              "${offerModel.oldPrice}",
                          style: Theme.of(
                            context,
                          ).textTheme.bodyLarge!.copyWith(
                            color: Theme.of(context).colorScheme.primary,
                            overflow: TextOverflow.ellipsis,
                            decoration: TextDecoration.lineThrough,
                            decorationColor:
                                Theme.of(context).colorScheme.primary,
                          ),
                        ),
                        TextSpan(
                          text:
                              r"  $"
                              "${offerModel.discountedPrice}",
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

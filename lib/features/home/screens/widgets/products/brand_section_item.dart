import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:e_fashion_flutter/config/router/app_router.dart';
import 'package:e_fashion_flutter/core/widgets/custom_cached_network_image.dart';
import 'package:e_fashion_flutter/core/widgets/modal_bottom_sheet_content.dart';
import 'package:e_fashion_flutter/features/cart/cubit/cart_cubit/cart_cubit.dart';
import 'package:e_fashion_flutter/features/home/screens/widgets/offers/home_clipped_container.dart';
import 'package:e_fashion_flutter/shared/data/bottom_sheet_model.dart';
import 'package:e_fashion_flutter/shared/data/product_model.dart';
import 'package:e_fashion_flutter/shared/widgets/custom_heart_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
            context.pushRoute(
              ProductDetailsRoute(
                imageUrl: productModel.imageUrl,
                productId: productModel.id,
              ),
            );
          },
          child: ClipRRect(
            borderRadius: BorderRadius.circular(16.0),
            child: CustomCachedNetworkImage(
              imageUrl: productModel.imageUrl,
              height: 200.0,
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
                  imageUrl: productModel.imageUrl,
                  productId: productModel.id,
                ),
              );
            },
            child: HomeClippedContainer(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 10.0),
                  Text(
                    productModel.title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(
                      context,
                    ).textTheme.bodyLarge!.copyWith(color: Colors.white),
                  ),
                  const SizedBox(height: 4.0),
                  Text(
                    r"$"
                    "${productModel.basePrice}",
                    style: Theme.of(
                      context,
                    ).textTheme.bodyMedium!.copyWith(color: Colors.white),
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
                builder:
                    (_) => BlocProvider.value(
                      value: context.read<CartCubit>(),
                      child: ModalBottomSheetContent(
                        isBottomNav: true,
                        bottomSheetModel: BottomSheetModel.fromProduct(
                          productModel,
                        ),
                      ),
                    ),
              );
            },
            icon: Icon(
              Iconsax.bag_2,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
        ),
        PositionedDirectional(
          top: 16.0,
          end: 16.0,
          child: CustomHeartIcon(productModel: productModel),
        ),
      ],
    );
  }
}

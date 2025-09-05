import 'package:cached_network_image/cached_network_image.dart';
import 'package:e_fashion_flutter/core/widgets/custom_cached_network_image.dart';
import 'package:e_fashion_flutter/core/widgets/modal_bottom_sheet_content.dart';
import 'package:e_fashion_flutter/features/cart/cubit/cart_cubit/cart_cubit.dart';
import 'package:e_fashion_flutter/features/search/screens/widgets/search_grid/search_grid_container_clipper.dart';
import 'package:e_fashion_flutter/shared/data/bottom_sheet_model.dart';
import 'package:e_fashion_flutter/shared/data/product_model.dart';
import 'package:e_fashion_flutter/shared/widgets/custom_heart_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';

class SearchGridItem extends StatelessWidget {
  const SearchGridItem({super.key, required this.productModel});

  final ProductModel productModel;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(16.0),
          child: CustomCachedNetworkImage(
            imageUrl: productModel.imageUrl,
            height: 180.0,
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
                  const SizedBox(width: 5.0),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          productModel.title,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                        Text(
                          "\$${productModel.isOffer ? productModel.discountPrice : productModel.basePrice}",
                          maxLines: 1,
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    onPressed: () async {
                      await showModalBottomSheet(
                        context: context,
                        builder:
                            (_) => BlocProvider.value(
                              value: context.read<CartCubit>(),
                              child: ModalBottomSheetContent(
                                bottomSheetModel: BottomSheetModel.fromProduct(
                                  productModel,
                                  isOffered: productModel.isOffer,
                                ),
                              ),
                            ),
                      );
                    },
                    padding: EdgeInsets.zero,
                    icon: const Icon(Iconsax.bag_2, color: Color(0xFF4A96D8)),
                  ),
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
            child: CustomHeartIcon(productModel: productModel),
          ),
        ),
      ],
    );
  }
}

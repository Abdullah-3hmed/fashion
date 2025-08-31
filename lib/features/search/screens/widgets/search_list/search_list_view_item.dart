import 'package:cached_network_image/cached_network_image.dart';
import 'package:e_fashion_flutter/core/widgets/custom_cached_network_image.dart';
import 'package:e_fashion_flutter/core/widgets/modal_bottom_sheet_content.dart';
import 'package:e_fashion_flutter/features/cart/cubit/cart_cubit/cart_cubit.dart';
import 'package:e_fashion_flutter/features/search/screens/widgets/search_list/search_list_container_clipper.dart';
import 'package:e_fashion_flutter/shared/data/bottom_sheet_model.dart';
import 'package:e_fashion_flutter/shared/data/product_model.dart';
import 'package:e_fashion_flutter/shared/widgets/custom_heart_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';

class SearchListViewItem extends StatelessWidget {
  const SearchListViewItem({super.key, required this.product});

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: AlignmentDirectional.bottomCenter,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(16.0),
          child: CustomCachedNetworkImage(
            imageUrl: product.imageUrl,
            height: 220.0,
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
                  const SizedBox(width: 8.0),
                  Expanded(
                    child: Center(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            product.title,
                            textAlign: TextAlign.center,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: Theme.of(context).textTheme.titleLarge!
                                .copyWith(color: Colors.white),
                          ),
                          Text(
                            "\$${product.isOffer ? product.discountPrice : product.basePrice}",
                            style: Theme.of(context).textTheme.titleSmall!
                                .copyWith(color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 8.0),
                  IconButton(
                    onPressed: () async {
                      await showModalBottomSheet(
                        context: context,
                        builder:
                            (_) => BlocProvider.value(
                              value: context.read<CartCubit>(),
                              child: ModalBottomSheetContent(
                                bottomSheetModel: BottomSheetModel.fromProduct(
                                  product,
                                  isOffered: product.isOffer,
                                ),
                              ),
                            ),
                      );
                    },
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
            child: CustomHeartIcon(productModel: product),
          ),
        ),
      ],
    );
  }
}

import 'package:e_fashion_flutter/core/enums/request_status.dart';
import 'package:e_fashion_flutter/core/utils/app_constants.dart';
import 'package:e_fashion_flutter/features/home/cubit/home_cubit/home_cubit.dart';
import 'package:e_fashion_flutter/features/home/cubit/home_cubit/home_state.dart';
import 'package:e_fashion_flutter/features/home/screens/widgets/products/brand_section.dart';
import 'package:e_fashion_flutter/features/home/screens/widgets/products/brand_section_item.dart';
import 'package:e_fashion_flutter/shared/data/product_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';

class ProductsSection extends StatelessWidget {
  const ProductsSection({super.key});

  static const ProductModel dummyProductModel = ProductModel(
    imageUrl: AppConstants.imageUrl,
    basePrice: 0.0,
    colors: "",
    discountPrice: 0.0,
    sizes: "",
    id: "",
    title: "",
    isOffer: false,
  );

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      buildWhen:
          (previous, current) =>
              previous.productsState != current.productsState,
      builder: (context, state) {
        switch (state.productsState) {
          case RequestStatus.loading:
            return SliverToBoxAdapter(
              child: Column(
                children: [
                  const SizedBox(height: 20.0),
                  Skeletonizer(
                    child: SizedBox(
                      height: 180.0,
                      child: ListView.separated(
                        physics: const BouncingScrollPhysics(),
                        scrollDirection: Axis.horizontal,
                        itemCount: 3,
                        itemBuilder:
                            (context, index) => const SizedBox(
                              width: 240.0,
                              child: BrandSectionItem(
                                productModel: dummyProductModel,
                              ),
                            ),
                        separatorBuilder:
                            (context, index) => const SizedBox(width: 12.0),
                      ),
                    ),
                  ),
                ],
              ),
            );

          case RequestStatus.success:
            return SliverList(
              delegate: SliverChildListDelegate(
                state.products.groupedBrandProducts.entries
                    .where((entry) => entry.value.isNotEmpty)
                    .map(
                      (entry) => BrandSection(
                        brandName: entry.key,
                        products: entry.value,
                      ),
                    )
                    .toList(),
              ),
            );

          case RequestStatus.error:
            return SliverToBoxAdapter(
              child: Center(
                child: Text(
                  state.productsErrorMessage,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ),
            );

          default:
            return const SliverToBoxAdapter(child: SizedBox.shrink());
        }
      },
    );
  }
}

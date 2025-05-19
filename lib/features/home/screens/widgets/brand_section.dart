import 'package:e_fashion_flutter/core/enums/request_status.dart';
import 'package:e_fashion_flutter/core/utils/assets_manager.dart';
import 'package:e_fashion_flutter/features/home/cubit/home_cubit.dart';
import 'package:e_fashion_flutter/features/home/cubit/home_state.dart';
import 'package:e_fashion_flutter/features/home/data/product_model.dart';
import 'package:e_fashion_flutter/features/home/screens/widgets/brand_section_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BrandSection extends StatelessWidget {
  const BrandSection({super.key, required this.brandName});

  final String brandName;
  static const ProductModel dummyProductModel = ProductModel(
    id: 1,
    name: "anyThing",
    imageUrl: AssetsManager.welcomeImage,
    price: 300.0,
  );

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(brandName, style: Theme.of(context).textTheme.bodyMedium),
            TextButton(
              style: ButtonStyle(
                padding: WidgetStateProperty.all<EdgeInsetsGeometry>(
                  EdgeInsets.zero,
                ),
              ),
              onPressed: () {},
              child: Text(
                "See All",
                style: Theme.of(context).textTheme.labelMedium!.copyWith(
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 8.0),
        BlocBuilder<HomeCubit, HomeState>(
          buildWhen:
              (previous, current) =>
                  previous.productsStatus != current.productsStatus,
          builder: (context, state) {
            switch (state.productsStatus) {
              case RequestStatus.loading:
                return SizedBox(
                  height: 180.0,
                  child: ListView.separated(
                    physics: const BouncingScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    itemCount: 4,
                    itemBuilder:
                        (context, index) => const SizedBox(
                          width: 240.0,
                          child: BrandSectionItem(
                            productModel: dummyProductModel,
                          ),
                        ),
                    separatorBuilder:
                        (BuildContext context, int index) =>
                            const SizedBox(width: 12.0),
                  ),
                );
              case RequestStatus.success:
                return SizedBox(
                  height: 180.0,
                  child: ListView.separated(
                    physics: const BouncingScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    itemCount: 4,
                    itemBuilder:
                        (context, index) => SizedBox(
                          width: 240.0,
                          child: BrandSectionItem(
                            productModel: state.products[index],
                          ),
                        ),
                    separatorBuilder:
                        (BuildContext context, int index) =>
                            const SizedBox(width: 12.0),
                  ),
                );
              case RequestStatus.error:
                return Center(
                  child: Text(
                    state.productsErrorMessage,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                );
              default:
                return const SizedBox.shrink();
            }
          },
        ),
      ],
    );
  }
}

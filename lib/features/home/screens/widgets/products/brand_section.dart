import 'package:auto_route/auto_route.dart';
import 'package:e_fashion_flutter/config/router/app_router.dart';
import 'package:e_fashion_flutter/core/enums/request_status.dart';
import 'package:e_fashion_flutter/core/utils/app_constants.dart';
import 'package:e_fashion_flutter/features/home/cubit/home_cubit.dart';
import 'package:e_fashion_flutter/features/home/cubit/home_state.dart';
import 'package:e_fashion_flutter/features/home/screens/widgets/products/brand_section_item.dart';
import 'package:e_fashion_flutter/shared/data/product_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BrandSection extends StatelessWidget {
  const BrandSection({
    super.key,
    required this.brandName,
    required this.products,
  });

  final String brandName;
  final List<ProductModel> products;

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
              onPressed: () {
                context.pushRoute(DiscoverRoute(productsDiscoverList:products ));
              },
              child: Text(
                "Discover",
                style: Theme.of(context).textTheme.labelMedium!.copyWith(
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 8.0),
        SizedBox(
          height: 220.0,
          child: ListView.separated(
            physics: const BouncingScrollPhysics(),
            scrollDirection: Axis.horizontal,
            itemCount: products.length,
            itemBuilder:
                (context, index) => SizedBox(
                  width: 200.0,
                  child: BrandSectionItem(productModel: products[index]),
                ),
            separatorBuilder:
                (BuildContext context, int index) =>
                    const SizedBox(width: 12.0),
          ),
        ),
      ],
    );
  }
}

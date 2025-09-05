import 'package:e_fashion_flutter/features/search/screens/widgets/search_grid/search_grid_item.dart';
import 'package:e_fashion_flutter/shared/data/product_model.dart';
import 'package:flutter/material.dart';

class SearchGridView extends StatelessWidget {
  const SearchGridView({super.key, required this.products});
  final List<ProductModel> products;
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      physics: const BouncingScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 200,
        crossAxisSpacing: 12,
        mainAxisSpacing: 16,
        childAspectRatio: 0.86,
      ),
      itemBuilder:
          (context, index) => SearchGridItem(productModel: products[index]),
      itemCount: products.length,
    );
  }
}

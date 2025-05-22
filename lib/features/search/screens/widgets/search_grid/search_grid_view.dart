import 'package:e_fashion_flutter/features/search/data/search_model.dart';
import 'package:e_fashion_flutter/features/search/screens/widgets/search_grid/search_grid_item.dart';
import 'package:flutter/material.dart';

class SearchGridView extends StatelessWidget {
  const SearchGridView({super.key, required this.searchProducts});
  final List<SearchModel> searchProducts;
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
          (context, index) =>
              SearchGridItem(searchModel: searchProducts[index]),
      itemCount: searchProducts.length,
    );
  }
}

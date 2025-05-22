import 'package:e_fashion_flutter/features/search/data/search_model.dart';
import 'package:e_fashion_flutter/features/search/screens/widgets/search_list/search_list_view_item.dart';
import 'package:flutter/material.dart';

class SearchListView extends StatelessWidget {
  const SearchListView({super.key, required this.searchProducts});
  final List<SearchModel> searchProducts;
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      physics: const BouncingScrollPhysics(),
      itemBuilder:
          (context, index) =>
              SearchListViewItem(searchModel: searchProducts[index]),
      separatorBuilder: (context, _) => const SizedBox(height: 8.0),
      itemCount: searchProducts.length,
    );
  }
}

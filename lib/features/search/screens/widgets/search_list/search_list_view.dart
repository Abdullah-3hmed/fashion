import 'package:e_fashion_flutter/features/search/screens/widgets/search_list/search_list_view_item.dart';
import 'package:flutter/material.dart';

class SearchListView extends StatelessWidget {
  const SearchListView({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemBuilder: (context, index) => const SearchListViewItem(),
      separatorBuilder: (context, _) => const SizedBox(height: 8.0),
      itemCount: 5,
    );
  }
}

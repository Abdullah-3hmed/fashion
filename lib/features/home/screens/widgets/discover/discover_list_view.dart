import 'package:e_fashion_flutter/features/home/screens/widgets/discover/discover_list/discover_list_tem.dart';
import 'package:e_fashion_flutter/shared/data/product_model.dart';
import 'package:flutter/material.dart';

class DiscoverListView extends StatelessWidget {
  const DiscoverListView({super.key, required this.discoverList});

  final List<ProductModel> discoverList;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      key: const ValueKey('list'),
      physics: const BouncingScrollPhysics(),
      itemBuilder:
          (context, index) => DiscoverListItem(
            isFirstItem: index == 0,
            product: discoverList[index],
          ),
      separatorBuilder: (_, __) => const SizedBox(height: 16.0),
      itemCount: discoverList.length,
    );
  }
}

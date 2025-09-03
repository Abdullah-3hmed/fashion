import 'package:e_fashion_flutter/core/enums/request_status.dart';
import 'package:e_fashion_flutter/features/home/screens/widgets/discover/discover_grid/discover_grid_item.dart';
import 'package:e_fashion_flutter/features/home/screens/widgets/discover/discover_grid/discover_grid_reverse_item.dart';
import 'package:e_fashion_flutter/shared/data/product_model.dart';
import 'package:flutter/material.dart';

class DiscoverGridView extends StatelessWidget {
  const DiscoverGridView({
    super.key,
    required this.discoverList,
    required this.controller,
    required this.status,
  });

  final List<ProductModel> discoverList;
  final ScrollController controller;
  final RequestStatus status;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      controller: controller,
      physics: const BouncingScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 16.0,
        mainAxisSpacing: 16.0,
        childAspectRatio: 0.75,
      ),
      itemCount: discoverList.length + 1,
      itemBuilder: (context, index) {
        if (index == discoverList.length) {
          if (status.isLoading) {
            return const Padding(
              padding: EdgeInsets.all(16.0),
              child: Center(child: CircularProgressIndicator()),
            );
          }
          return const SizedBox.shrink();
        }

        final ProductModel model = discoverList[index];
        final bool isFirstItem = index < 2;
        return index.isEven
            ? DiscoverGridItem(product: model, isFirstItem: isFirstItem)
            : DiscoverGridReverseItem(product: model, isFirstItem: isFirstItem);
      },
    );
  }
}

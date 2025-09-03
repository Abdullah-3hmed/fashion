import 'package:e_fashion_flutter/core/enums/request_status.dart';
import 'package:e_fashion_flutter/features/home/screens/widgets/discover/discover_grid/discover_grid_item.dart';
import 'package:e_fashion_flutter/features/home/screens/widgets/discover/discover_grid/discover_grid_reverse_item.dart';
import 'package:e_fashion_flutter/shared/data/product_model.dart';
import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';

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

  static List<ProductModel> dummyList = List<ProductModel>.generate(
    6,
        (index) => const ProductModel(
      id: "",
      title: "*********",
      imageUrl: "",
      basePrice: 0.0,
      discountPrice: 0.0,
      colors: "",
      sizes: "",
      isOffer: false,
    ),
  );

  @override
  Widget build(BuildContext context) {
    final List<ProductModel> data =
    status.isLoading ? dummyList : discoverList;

    return Skeletonizer(
      enabled: status.isLoading,
      child: GridView.builder(
        controller: controller,
        physics: const BouncingScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 16.0,
          mainAxisSpacing: 16.0,
          childAspectRatio: 0.75,
        ),
        itemCount: data.length,
        itemBuilder: (context, index) {
          final ProductModel model = data[index];
          final bool isFirstItem = index < 2;

          return index.isEven
              ? DiscoverGridItem(product: model, isFirstItem: isFirstItem)
              : DiscoverGridReverseItem(
            product: model,
            isFirstItem: isFirstItem,
          );
        },
      ),
    );
  }
}

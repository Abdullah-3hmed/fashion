import 'package:e_fashion_flutter/core/enums/request_status.dart';
import 'package:e_fashion_flutter/features/home/screens/widgets/discover/discover_list/discover_list_tem.dart';
import 'package:e_fashion_flutter/shared/data/product_model.dart';
import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';

class DiscoverListView extends StatelessWidget {
  const DiscoverListView({
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
      child: ListView.separated(
        controller: controller,
        physics: const BouncingScrollPhysics(),
        itemCount: data.length,
        itemBuilder: (context, index) {
          return DiscoverListItem(
            isFirstItem: index == 0,
            product: data[index],
          );
        },
        separatorBuilder: (_, __) => const SizedBox(height: 16.0),
      ),
    );
  }
}

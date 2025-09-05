import 'package:e_fashion_flutter/core/enums/request_status.dart';
import 'package:e_fashion_flutter/core/utils/app_constants.dart';
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

  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
      enabled: status.isLoading,
      child: ListView.separated(
        controller: controller,
        physics: const BouncingScrollPhysics(),
        itemCount: discoverList.length,
        itemBuilder: (context, index) {
          return DiscoverListItem(
            isFirstItem: index == 0,
            product: discoverList[index],
          );
        },
        separatorBuilder: (_, _) => const SizedBox(height: 16.0),
      ),
    );
  }
}
import 'package:auto_route/auto_route.dart';
import 'package:e_fashion_flutter/core/enums/request_status.dart';
import 'package:e_fashion_flutter/core/utils/app_constants.dart';
import 'package:e_fashion_flutter/features/home/cubit/home_cubit.dart';
import 'package:e_fashion_flutter/features/home/cubit/home_state.dart';
import 'package:e_fashion_flutter/features/home/data/collection_details_product.dart';
import 'package:e_fashion_flutter/features/home/screens/widgets/collection/collection_item.dart';
import 'package:e_fashion_flutter/features/home/screens/widgets/collection/collection_items.dart';
import 'package:e_fashion_flutter/features/home/screens/widgets/collection/reverse_collection_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';

@RoutePage()
class CollectionScreen extends StatelessWidget {
  const CollectionScreen({super.key, required this.collectionName});

  final String collectionName;
  static const CollectionDetailsProduct dummyProduct = CollectionDetailsProduct(
    id: 0,
    productName: "Product name",
    description: "Description",
    imageUrl: AppConstants.imageUrl,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          collectionName,
          style: Theme.of(context).textTheme.titleMedium,
        ),
      ),
      body: BlocBuilder<HomeCubit, HomeState>(
        buildWhen:
            (previous, current) =>
                previous.collectionDetailsStatus !=
                current.collectionDetailsStatus,
        builder: (context, state) {
          switch (state.collectionDetailsStatus) {
            case RequestStatus.loading:
              return Skeletonizer(
                child: ListView.separated(
                  itemCount: 3,
                  separatorBuilder:
                      (context, index) => const SizedBox(height: 16.0),
                  itemBuilder:
                      (context, index) =>
                          index % 2 == 0
                              ? const CollectionItem(product: dummyProduct)
                              : const ReverseCollectionItem(
                                product: dummyProduct,
                              ),
                ),
              );
            case RequestStatus.success:
              return CollectionItems(
                collectionDetailsModel: state.collectionDetailsModel,
              );
            case RequestStatus.error:
              return Center(
                child: Text(
                  state.collectionDetailsErrorMessage,
                  style: Theme.of(context).textTheme.titleSmall,
                ),
              );
            default:
              return const SizedBox.shrink();
          }
        },
      ),
    );
  }
}

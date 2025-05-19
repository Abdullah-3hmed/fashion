import 'package:auto_route/auto_route.dart';
import 'package:e_fashion_flutter/core/enums/request_status.dart';
import 'package:e_fashion_flutter/core/utils/app_constants.dart';
import 'package:e_fashion_flutter/core/utils/assets_manager.dart';
import 'package:e_fashion_flutter/core/widgets/secondary_button.dart';
import 'package:e_fashion_flutter/features/home/cubit/home_cubit.dart';
import 'package:e_fashion_flutter/features/home/cubit/home_state.dart';
import 'package:e_fashion_flutter/features/home/data/collection_details_product.dart';
import 'package:e_fashion_flutter/features/home/screens/widgets/collection_item.dart';
import 'package:e_fashion_flutter/features/home/screens/widgets/reverse_collection_item.dart';
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
              return Stack(
                alignment: AlignmentDirectional.bottomCenter,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24.0,
                      vertical: 16.0,
                    ),
                    child: ListView.separated(
                      physics: const BouncingScrollPhysics(),
                      itemCount:
                          state
                              .collectionDetailsModel
                              .collectionProducts
                              .length,
                      separatorBuilder:
                          (context, index) => const SizedBox(height: 16.0),
                      itemBuilder:
                          (context, index) =>
                              index % 2 == 0
                                  ? CollectionItem(
                                    product:
                                        state
                                            .collectionDetailsModel
                                            .collectionProducts[index],
                                  )
                                  : ReverseCollectionItem(
                                    product:
                                        state
                                            .collectionDetailsModel
                                            .collectionProducts[index],
                                  ),
                    ),
                  ),
                  Image.asset(
                    width: double.infinity,
                    fit: BoxFit.cover,
                    AssetsManager.collectionClippedContainer,
                  ),
                  PositionedDirectional(
                    bottom: 100.0,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          r"$"
                          "${state.collectionDetailsModel.totalPrice}",
                          style: Theme.of(context).textTheme.titleMedium!
                              .copyWith(color: Colors.white),
                        ),
                        const SizedBox(width: 16.0),
                        SecondaryButton(
                          onPressed: () {},
                          text: "Buy collection",
                          backgroundColor:
                              Theme.of(context).colorScheme.primary,
                        ),
                      ],
                    ),
                  ),
                ],
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

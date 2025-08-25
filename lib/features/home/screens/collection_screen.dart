import 'dart:ui';

import 'package:auto_route/auto_route.dart';
import 'package:e_fashion_flutter/config/router/app_router.dart';
import 'package:e_fashion_flutter/core/enums/request_status.dart';
import 'package:e_fashion_flutter/core/services/service_locator.dart';
import 'package:e_fashion_flutter/core/utils/app_constants.dart';
import 'package:e_fashion_flutter/core/widgets/secondary_button.dart';
import 'package:e_fashion_flutter/features/home/cubit/collection_details_cubit/collection_details_cubit.dart';
import 'package:e_fashion_flutter/features/home/cubit/collection_details_cubit/collection_details_state.dart';
import 'package:e_fashion_flutter/features/home/cubit/home_cubit/home_cubit.dart';
import 'package:e_fashion_flutter/features/home/cubit/home_cubit/home_state.dart';
import 'package:e_fashion_flutter/features/home/data/home/collection_item_model.dart';
import 'package:e_fashion_flutter/features/home/screens/widgets/collection/collection_container_clipper.dart';
import 'package:e_fashion_flutter/features/home/screens/widgets/collection/collection_item.dart';
import 'package:e_fashion_flutter/features/home/screens/widgets/collection/collection_items.dart';
import 'package:e_fashion_flutter/features/home/screens/widgets/collection/reverse_collection_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';

@RoutePage()
class CollectionScreen extends StatelessWidget implements AutoRouteWrapper {
  @override
  Widget wrappedRoute(BuildContext context) => BlocProvider(
    create:
        (context) =>
            getIt<CollectionDetailsCubit>()
              ..getCollectionDetails(collectionId: collectionId),
    child: this,
  );

  const CollectionScreen({
    super.key,
    required this.title,
    required this.collectionId,
  });

  final String title;
  final String collectionId;
  static const CollectionItemModel dummyProduct = CollectionItemModel(
    id: "",
    title: "*****************",
    description: "**************",
    imageUrl: "****************",
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title, style: Theme.of(context).textTheme.titleMedium),
      ),
      body: BlocBuilder<CollectionDetailsCubit, CollectionDetailsState>(
        buildWhen:
            (previous, current) =>
                previous.collectionDetailsStatus !=
                current.collectionDetailsStatus,
        builder: (context, state) {
          switch (state.collectionDetailsStatus) {
            case RequestStatus.loading:
              return Skeletonizer(
                child: Stack(
                  alignment: AlignmentDirectional.bottomCenter,
                  children: [
                    ListView.separated(
                      itemCount: 3,
                      separatorBuilder:
                          (context, index) => const SizedBox(height: 16.0),
                      itemBuilder:
                          (context, index) =>
                              index % 2 == 0
                                  ? const CollectionItem(
                                    collectionItemModel: dummyProduct,
                                  )
                                  : const ReverseCollectionItem(
                                    collectionItemModel: dummyProduct,
                                  ),
                    ),
                    ClipPath(
                      clipper: CollectionContainerClipper(),
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 25, sigmaY: 25),
                        child: Container(
                          height: 192,
                          decoration: const BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                Color.fromRGBO(255, 255, 255, 0.1),
                                Color.fromRGBO(36, 123, 160, 0.1),
                              ],
                            ),
                            borderRadius: BorderRadius.all(Radius.circular(50)),
                          ),
                        ),
                      ),
                    ),
                    PositionedDirectional(
                      bottom: 100.0,
                      start: 0.0,
                      end: 0.0,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            r"$"
                            "${300}",
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

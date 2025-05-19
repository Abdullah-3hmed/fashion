import 'package:e_fashion_flutter/core/enums/request_status.dart';
import 'package:e_fashion_flutter/core/utils/app_constants.dart';
import 'package:e_fashion_flutter/features/home/cubit/home_cubit.dart';
import 'package:e_fashion_flutter/features/home/cubit/home_state.dart';
import 'package:e_fashion_flutter/features/home/data/collection_model.dart';
import 'package:e_fashion_flutter/features/home/screens/widgets/home_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';

class HomeHeaderBlocBuilder extends StatelessWidget {
  const HomeHeaderBlocBuilder({super.key});
  static final dummyCollections = List.generate(
    5,
    (index) => const CollectionModel(
      id: 0,
      title: '•••••• ••••••',
      imageUrl: AppConstants.imageUrl,
      discount: '••% OFF',
      subTitle: '•••••••••••••',
      price: 0.0,
    ),
  );
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      buildWhen:
          (previous, current) =>
              previous.collectionsStatus != current.collectionsStatus,
      builder: (context, state) {
        switch (state.collectionsStatus) {
          case RequestStatus.loading:
            return Skeletonizer(
              child: HomeHeader(collections: dummyCollections),
            );
          case RequestStatus.success:
            return HomeHeader(collections: state.collections);
          case RequestStatus.error:
            return SizedBox(
              height: 200.0,
              child: Text(
                state.collectionsErrorMessage,
                style: Theme.of(context).textTheme.titleMedium,
              ),
            );
          default:
            return const SizedBox.shrink();
        }
      },
    );
  }
}

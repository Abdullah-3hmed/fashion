import 'package:e_fashion_flutter/core/enums/request_status.dart';
import 'package:e_fashion_flutter/core/utils/show_toast.dart';
import 'package:e_fashion_flutter/core/utils/toast_states.dart';
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
      imageUrl:
          'http://efashion.runasp.net/Products/Woman Dress.jpg', // صورة رمادية مؤقتة
      discount: '••% OFF',
      subTitle: '•••••••••••••',
      discountPercent: 0.0,
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
            showToast(
              message: state.collectionsErrorMessage,
              state: ToastStates.error,
            );
            return Center(
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

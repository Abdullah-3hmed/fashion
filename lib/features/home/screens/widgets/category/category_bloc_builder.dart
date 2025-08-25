import 'package:e_fashion_flutter/core/enums/request_status.dart';
import 'package:e_fashion_flutter/core/utils/app_constants.dart';
import 'package:e_fashion_flutter/features/home/cubit/home_cubit/home_cubit.dart';
import 'package:e_fashion_flutter/features/home/cubit/home_cubit/home_state.dart';
import 'package:e_fashion_flutter/features/home/data/home/category_model.dart';
import 'package:e_fashion_flutter/features/home/screens/widgets/category/category_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';

class CategoryBlocBuilder extends StatelessWidget {
  const CategoryBlocBuilder({super.key, required this.genderWidth});

  final ValueNotifier<double> genderWidth;

  static List<CategoryModel> dummyCategories = List<CategoryModel>.generate(
    5,
    (index) =>
        CategoryModel(id: index, name: "jeans", image: AppConstants.imageUrl),
  );

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      buildWhen:
          (previous, current) =>
              previous.categoriesStatus != current.categoriesStatus,
      builder: (context, state) {
        switch (state.categoriesStatus) {
          case RequestStatus.loading:
            return Skeletonizer(
              child: CategoryContainer(categories: dummyCategories,isLoading: true,),
            );
          case RequestStatus.success:
            return GestureDetector(
              onHorizontalDragUpdate: (details) {
                genderWidth.value = (genderWidth.value + details.delta.dx)
                    .clamp(0.0, 145.0);
              },
              onHorizontalDragEnd: (_) {
                if (genderWidth.value >= 72.5) {
                  genderWidth.value = 145.0;
                } else {
                  genderWidth.value = 0.0;
                }
              },
              child: CategoryContainer(
                categories: state.categories,
                isScroll: genderWidth.value == 0.0,
              ),
            );
          case RequestStatus.error:
            return Center(
              child: Text(
                state.categoriesErrorMessage,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            );
          default:
            return const SizedBox.shrink();
        }
      },
    );
  }
}

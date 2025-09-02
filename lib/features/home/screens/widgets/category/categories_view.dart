import 'package:e_fashion_flutter/core/enums/request_status.dart';
import 'package:e_fashion_flutter/core/utils/app_constants.dart';
import 'package:e_fashion_flutter/features/home/cubit/home_cubit/home_cubit.dart';
import 'package:e_fashion_flutter/features/home/cubit/home_cubit/home_state.dart';
import 'package:e_fashion_flutter/features/home/data/home/category_model.dart';
import 'package:e_fashion_flutter/features/home/screens/widgets/filter/filter_category_section.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';

class CategoriesView extends StatelessWidget {
  const CategoriesView({super.key, required this.genderWidth});

  final ValueNotifier<double> genderWidth;

  static final List<CategoryModel> dummyCategories =
  List.generate(5, (index) => CategoryModel(
    id: index,
    name: "jeans",
    image: AppConstants.imageUrl,
  ));

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      buildWhen: (previous, current) =>
      previous.categoriesStatus != current.categoriesStatus,
      builder: (context, state) {
        switch (state.categoriesStatus) {
          case RequestStatus.loading:
            return Skeletonizer(
              child: CategoryContainer(
                categories: dummyCategories,
              ),
            );

          case RequestStatus.success:
            return GestureDetector(
              onHorizontalDragUpdate: (details) {
                genderWidth.value = (genderWidth.value + details.delta.dx)
                    .clamp(0.0, 145.0);
              },
              onHorizontalDragEnd: (_) {
                genderWidth.value =
                genderWidth.value >= 72.5 ? 145.0 : 0.0;
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

class CategoryContainer extends StatelessWidget {
  const CategoryContainer({
    super.key,
    required this.categories,
    this.isScroll = true,});

  final List<CategoryModel> categories;
  final bool isScroll;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: AlignmentDirectional.centerStart,
      children: [
        Container(

          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surfaceContainerHighest,
            borderRadius: BorderRadius.circular(16.0),
          ),
          child: FilterCategorySection(
            categories: categories,
            isScroll: isScroll,
          ),
        ),
        Container(
          height: 40.0,
          width: 5.0,
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.primary,
            borderRadius: const BorderRadius.all(Radius.circular(5.0)),
          ),
        ),
      ],
    );
  }
}

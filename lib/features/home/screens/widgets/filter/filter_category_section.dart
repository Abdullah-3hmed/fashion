import 'package:e_fashion_flutter/core/utils/app_constants.dart';
import 'package:e_fashion_flutter/features/home/cubit/home_cubit/home_cubit.dart';
import 'package:e_fashion_flutter/features/home/cubit/home_cubit/home_state.dart';
import 'package:e_fashion_flutter/features/home/data/home/category_model.dart';
import 'package:e_fashion_flutter/features/home/screens/widgets/filter/filter_section_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FilterCategorySection extends StatelessWidget {
  const FilterCategorySection({
    super.key,
    required this.categories,
    this.isScroll = false,
  });

  final List<CategoryModel> categories;
  final bool isScroll;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 70.0,
      child: BlocBuilder<HomeCubit, HomeState>(
        buildWhen: (previous, current) =>
        previous.categoryActiveIndex != current.categoryActiveIndex,
        builder: (context, state) {
          return ListView.separated(
            physics:
            isScroll
                ? const ScrollPhysics()
                : const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemBuilder:
                (context, index) =>
                InkWell(
                  onTap: () {
                    context.read<HomeCubit>().changeCategory(index: index);
                    context.read<HomeCubit>().selectCategory(
                      categoryId: categories[index].id,
                    );
                  },
                  child: FilterSectionItem(
                    image: categories[index].image,
                    text: categories[index].name,
                    isSelected: state.categoryActiveIndex == index,
                    isCategory: true,
                  ),
                ),
            separatorBuilder: (context, index) => const SizedBox(width: 16.0),
            itemCount: categories.length,
          );
        },
      ),
    );
  }
}

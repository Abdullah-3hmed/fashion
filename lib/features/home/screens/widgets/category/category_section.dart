import 'package:e_fashion_flutter/core/animations/slide_animation.dart';
import 'package:e_fashion_flutter/core/widgets/third_button.dart';
import 'package:e_fashion_flutter/features/home/cubit/home_cubit.dart';
import 'package:e_fashion_flutter/features/home/cubit/home_state.dart';
import 'package:e_fashion_flutter/features/home/screens/widgets/category/category_bloc_builder.dart';
import 'package:e_fashion_flutter/features/home/screens/widgets/filter/filter_gender_section.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CategorySection extends StatefulWidget {
  const CategorySection({super.key});

  @override
  State<CategorySection> createState() => _CategorySectionState();
}

class _CategorySectionState extends State<CategorySection> {
  final ValueNotifier<double> genderWidth = ValueNotifier<double>(145);

  @override
  void dispose() {
    genderWidth.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 16.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Category", style: Theme.of(context).textTheme.bodyMedium),
            BlocBuilder<HomeCubit, HomeState>(
              buildWhen:
                  (previous, current) =>
                      previous.categoryActiveIndex !=
                          current.categoryActiveIndex ||
                      previous.genderActiveIndex != current.genderActiveIndex,
              builder: (context, state) {
                return state.genderActiveIndex != -1 || state.categoryActiveIndex != -1
                    ? SlideAnimation(
                      duration: const Duration(milliseconds: 300),
                      begin: const Offset(1.0, 0.0),
                      child: ThirdButton(
                        onPressed: () async {
                          await context.read<HomeCubit>().getProducts();
                        },
                        text: "Apply",
                      ),
                    )
                    : const SizedBox.shrink();
              },
            ),
          ],
        ),
        const SizedBox(height: 8.0),
        Row(
          children: [
            ValueListenableBuilder<double>(
              valueListenable: genderWidth,
              builder: (context, value, _) {
                return AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  width: value,
                  padding: const EdgeInsets.symmetric(
                    vertical: 8.0,
                    horizontal: 16.0,
                  ),
                  decoration: BoxDecoration(
                    color:
                        Theme.of(context).colorScheme.surfaceContainerHighest,
                    borderRadius: BorderRadius.circular(16.0),
                  ),
                  child: ClipRect(
                    child: Align(
                      alignment: Alignment.centerLeft,
                      widthFactor: value / 145.0,
                      child: const FilterGenderSection(),
                    ),
                  ),
                );
              },
            ),
            const SizedBox(width: 16.0),
            Expanded(
              child: ValueListenableBuilder<double>(
                valueListenable: genderWidth,
                builder: (context, value, _) {
                  return CategoryBlocBuilder(genderWidth: genderWidth);
                },
              ),
            ),
          ],
        ),
      ],
    );
  }
}

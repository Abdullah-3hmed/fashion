import 'package:e_fashion_flutter/core/animations/slide_animation.dart';
import 'package:e_fashion_flutter/core/enums/request_status.dart';
import 'package:e_fashion_flutter/core/widgets/third_button.dart';
import 'package:e_fashion_flutter/features/home/cubit/home_cubit.dart';
import 'package:e_fashion_flutter/features/home/cubit/home_state.dart';
import 'package:e_fashion_flutter/features/home/data/category_model.dart';
import 'package:e_fashion_flutter/features/home/screens/widgets/category_container.dart';
import 'package:e_fashion_flutter/features/home/screens/widgets/filter_gender_section.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';

class CategorySection extends StatefulWidget {
  const CategorySection({super.key});

  @override
  State<CategorySection> createState() => _CategorySectionState();
}

class _CategorySectionState extends State<CategorySection> {
  final ValueNotifier<double> genderWidth = ValueNotifier<double>(145);

  List<CategoryModel> dummyCategories = List.generate(
    5,
    (index) => const CategoryModel(
      name: "jeans",
      image: "http://efashion.runasp.net/Products/Woman T-shirt.jpg",
    ),
  );

  String? selectedGender;
  String? selectedCategory;

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
            if (selectedGender != null || selectedCategory != null)
              SlideAnimation(
                duration: const Duration(milliseconds: 300),
                begin: const Offset(1.0, 0.0),
                child: ThirdButton(
                  onPressed: () {
                    debugPrint(
                      'Applied with Gender: $selectedGender, Category: $selectedCategory',
                    );
                  },
                  text: "Apply",
                ),
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
                      child: FilterGenderSection(
                        onGenderChanged: (value) {
                          debugPrint(value);
                          setState(() => selectedGender = value);
                        },
                      ),
                    ),
                  ),
                );
              },
            ),
            const SizedBox(width: 16.0),
            Expanded(
              child: GestureDetector(
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
                child: ValueListenableBuilder<double>(
                  valueListenable: genderWidth,
                  builder: (context, value, _) {
                    return BlocBuilder<HomeCubit, HomeState>(
                      builder: (context, state) {
                        switch (state.categoriesStatus) {
                          case RequestStatus.loading:
                            return Skeletonizer(
                              child: CategoryContainer(
                                categories: dummyCategories,
                                onCategoryChanged: (_) {},
                              ),
                            );
                          case RequestStatus.success:
                            return CategoryContainer(
                              categories: state.categories,
                              isScroll: value == 0.0,
                              onCategoryChanged: (value) {
                                debugPrint(value);
                                setState(() => selectedCategory = value);
                              },
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
                  },
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

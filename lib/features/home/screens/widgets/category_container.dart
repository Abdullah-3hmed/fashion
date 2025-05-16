import 'package:e_fashion_flutter/features/home/data/category_model.dart';
import 'package:e_fashion_flutter/features/home/screens/widgets/filter_category_section.dart';
import 'package:flutter/material.dart';

class CategoryContainer extends StatelessWidget {
  const CategoryContainer({
    super.key,
    required this.categories,
    this.isScroll = true,
    this.onCategoryChanged,
  });

  final List<CategoryModel> categories;
  final bool isScroll;
  final ValueChanged<String>? onCategoryChanged;

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
            onCategoryChanged: (String value) {
              onCategoryChanged!(value);
            },
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

import 'package:e_fashion_flutter/features/home/data/category_model.dart';
import 'package:e_fashion_flutter/features/home/screens/widgets/filter_section_item.dart';
import 'package:flutter/material.dart';

class FilterCategorySection extends StatefulWidget {
  const FilterCategorySection({
    super.key,
    required this.onCategoryChanged,
    this.categories = const [],
    this.isScroll = false,
  });

  final ValueChanged<String> onCategoryChanged;
  final List<CategoryModel> categories;
  final bool isScroll;

  @override
  State<FilterCategorySection> createState() => _FilterCategorySectionState();
}

class _FilterCategorySectionState extends State<FilterCategorySection> {
  int activeIndex = -1;

  @override
  Widget build(BuildContext context) {
    final categories = widget.categories;
    return SizedBox(
      height: 70.0,
      child: ListView.separated(
        physics:
            widget.isScroll
                ? const ScrollPhysics()
                : const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemBuilder:
            (context, index) => InkWell(
              onTap: () {
                setState(() {
                  activeIndex = index;
                  widget.onCategoryChanged(categories[index].name);
                });
              },
              child: FilterSectionItem(
                image: categories[index].image,
                text: categories[index].name,
                isSelected: activeIndex == index,
                isCategory: true,
              ),
            ),
        separatorBuilder: (context, index) => const SizedBox(width: 16.0),
        itemCount: categories.length,
      ),
    );
  }
}

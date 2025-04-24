import 'package:e_fashion_flutter/core/utils/assets_manager.dart';
import 'package:e_fashion_flutter/features/home/screens/widgets/filter_section_item.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class FilterCategoryModel extends Equatable {
  final String title;
  final String image;

  const FilterCategoryModel({required this.title, required this.image});

  @override
  List<Object?> get props => [title, image];
}

class FilterCategorySection extends StatefulWidget {
  const FilterCategorySection({super.key, required this.onCategoryChanged});

  final ValueChanged<String> onCategoryChanged;

  @override
  State<FilterCategorySection> createState() => _FilterCategorySectionState();
}

class _FilterCategorySectionState extends State<FilterCategorySection> {
  int activeIndex = -1;
  List<FilterCategoryModel> filterGenderList = const [
    FilterCategoryModel(title: "jeans", image: AssetsManager.jeans),
    FilterCategoryModel(title: "jeans", image: AssetsManager.jeans),
    FilterCategoryModel(title: "jeans", image: AssetsManager.jeans),
    FilterCategoryModel(title: "jeans", image: AssetsManager.jeans),
    FilterCategoryModel(title: "jeans", image: AssetsManager.jeans),
  ];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 70.0,
      child: ListView.separated(
        physics: const NeverScrollableScrollPhysics(),
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        itemBuilder:
            (context, index) => InkWell(
              onTap: () {
                setState(() {
                  activeIndex = index;
                  widget.onCategoryChanged(filterGenderList[index].title);
                });
              },
              child: FilterSectionItem(
                image: filterGenderList[index].image,
                text: filterGenderList[index].title,
                isSelected: activeIndex == index,
              ),
            ),
        separatorBuilder: (context, index) => const SizedBox(width: 16.0),
        itemCount: filterGenderList.length,
      ),
    );
  }
}

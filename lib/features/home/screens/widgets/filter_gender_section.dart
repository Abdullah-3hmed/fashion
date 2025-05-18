import 'package:e_fashion_flutter/core/utils/assets_manager.dart';
import 'package:e_fashion_flutter/features/home/screens/widgets/filter_section_item.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class FilterGenderModel extends Equatable {
  final String title;
  final String image;

  const FilterGenderModel({required this.title, required this.image});
  @override
  List<Object?> get props => [title, image];
}

class FilterGenderSection extends StatefulWidget {
  const FilterGenderSection({super.key, required this.onGenderChanged});
  final ValueChanged<String> onGenderChanged;
  @override
  State<FilterGenderSection> createState() => _FilterGenderSectionState();
}

class _FilterGenderSectionState extends State<FilterGenderSection> {
  int activeIndex = -1;
  List<FilterGenderModel> filterGenderList = const [
    FilterGenderModel(title: "women", image: AssetsManager.woman),
    FilterGenderModel(title: "men", image: AssetsManager.man),
  ];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 70.0,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: List.generate(
            filterGenderList.length,
            (index) => InkWell(
              onTap: () {
                setState(() {
                  activeIndex = index;
                  widget.onGenderChanged(filterGenderList[index].title);
                });
              },
              child: Padding(
                padding:
                    index == 0
                        ? const EdgeInsetsDirectional.only(end: 16.0)
                        : const EdgeInsetsDirectional.only(),
                child: FilterSectionItem(
                  image: filterGenderList[index].image,
                  text: filterGenderList[index].title,
                  isSelected: activeIndex == index,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

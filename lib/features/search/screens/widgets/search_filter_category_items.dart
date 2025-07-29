import 'package:e_fashion_flutter/core/utils/app_constants.dart';
import 'package:e_fashion_flutter/features/home/data/home/category_model.dart';
import 'package:e_fashion_flutter/features/search/screens/widgets/search_filter_category_item.dart';
import 'package:flutter/material.dart';

class SearchFilterCategoryItems extends StatefulWidget {
  const SearchFilterCategoryItems({super.key, required this.onCategoryChanged});
final ValueChanged<int> onCategoryChanged;
  @override
  State<SearchFilterCategoryItems> createState() =>
      _SearchFilterCategoryItemsState();
}

class _SearchFilterCategoryItemsState extends State<SearchFilterCategoryItems> {
  int selectedIndex = -1;

  @override
  Widget build(BuildContext context) {
   final List<CategoryModel> categories = AppConstants.categories;
    return Wrap(
      spacing: 8.0,
      runSpacing: 8.0,
      children: List.generate(
        categories.length,
        (index) => GestureDetector(
          onTap: () {
            setState(() {
              selectedIndex = index;
              widget.onCategoryChanged(categories[index].id);
            });
          },
          child: SearchFilterCategoryItem(
            brandName: categories[index].name,
            isSelected: index == selectedIndex,
          ),
        ),
      ),
    );
  }
}

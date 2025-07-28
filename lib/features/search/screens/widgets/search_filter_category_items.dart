import 'package:e_fashion_flutter/features/search/screens/widgets/search_filter_category_item.dart';
import 'package:flutter/material.dart';

class SearchFilterCategoryItems extends StatefulWidget {
  const SearchFilterCategoryItems({super.key, required this.onCategoryChanged});
final ValueChanged<String> onCategoryChanged;
  @override
  State<SearchFilterCategoryItems> createState() =>
      _SearchFilterCategoryItemsState();
}

class _SearchFilterCategoryItemsState extends State<SearchFilterCategoryItems> {
  int selectedIndex = -1;
  List<String> brands = const [
    "Dress",
    "T-Shirt",
    "Pants",
    "Blouse",
    "Jackets",
    "Suits",
    "Sneakers",
    "Perfume",
    "Vests",
    "Jeans",
    "Shorts",
    "Socks",
    "Sweatshirt",
  ];

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8.0,
      runSpacing: 8.0,
      children: List.generate(
        brands.length,
        (index) => GestureDetector(
          onTap: () {
            setState(() {
              selectedIndex = index;
              widget.onCategoryChanged(brands[index]);
            });
          },
          child: SearchFilterCategoryItem(
            brandName: brands[index],
            isSelected: index == selectedIndex,
          ),
        ),
      ),
    );
  }
}

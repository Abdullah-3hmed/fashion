import 'package:e_fashion_flutter/features/search/screens/widgets/search_filter_brand_item.dart';
import 'package:flutter/material.dart';

class SearchFilterBrandItems extends StatefulWidget {
  const SearchFilterBrandItems({super.key, required this.onBrandChanged});
  final ValueChanged<String> onBrandChanged;
  @override
  State<SearchFilterBrandItems> createState() => _SearchFilterBrandItemsState();
}

class _SearchFilterBrandItemsState extends State<SearchFilterBrandItems> {
  int selectedIndex = -1;
  List<String> brands = const ["Armani", "Fendi", "Nike", "Burberry", "Chanel"];

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
              widget.onBrandChanged(brands[index]);
            });
          },
          child: SearchFilterBrandItem(
            brandName: brands[index],
            isSelected: index == selectedIndex,
          ),
        ),
      ),
    );
  }
}

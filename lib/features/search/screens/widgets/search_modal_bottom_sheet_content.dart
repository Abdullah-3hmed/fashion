import 'package:e_fashion_flutter/core/widgets/primary_button.dart';
import 'package:e_fashion_flutter/features/search/screens/widgets/search_filter_brand_items.dart';
import 'package:e_fashion_flutter/features/search/screens/widgets/search_filter_category_items.dart';
import 'package:e_fashion_flutter/features/search/screens/widgets/search_filter_slider.dart';
import 'package:flutter/material.dart';

class SearchModalBottomSheetContent extends StatelessWidget {
  const SearchModalBottomSheetContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsetsDirectional.only(
        top: 16.0,
        start: 24.0,
        end: 24.0,
      ),
      child: SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20.0),
            Divider(
              thickness: 4.0,
              height: 20.0,
              indent: 155.0,
              endIndent: 155.0,
              color: Colors.grey[300],
            ),
            const SizedBox(height: 20.0),
            Align(
              child: Text(
                "Search Filters",
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ),
            const SizedBox(height: 30.0),
            Text("Brands", style: Theme.of(context).textTheme.bodySmall),
            const Divider(thickness: 1.0, color: Color(0x1a1c1e40)),
            const SizedBox(height: 8.0),
            const SearchFilterBrandItems(),
            const SizedBox(height: 24.0),
            Text("Categories", style: Theme.of(context).textTheme.bodySmall),
            Divider(thickness: 1.0, color: Colors.grey[300]),
            const SizedBox(height: 8.0),
            const SearchFilterCategoryItems(),
            const SizedBox(height: 24.0),
            Text("Price", style: Theme.of(context).textTheme.bodySmall),
            Divider(thickness: 1.0, height: 12.0, color: Colors.grey[300]),
            const SizedBox(height: 40.0),
            SearchFilterSlider(
              minValue: (int minValue) {
                debugPrint(minValue.toString());
              },
              maxValue: (int maxValue) {
                debugPrint(maxValue.toString());
              },
            ),
            const SizedBox(height: 60.0),
            PrimaryButton(onPressed: () {}, text: "Apply Filters"),
            const SizedBox(height: 50.0),
          ],
        ),
      ),
    );
  }
}

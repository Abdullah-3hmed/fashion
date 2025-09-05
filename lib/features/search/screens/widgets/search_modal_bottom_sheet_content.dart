import 'package:auto_route/auto_route.dart';
import 'package:e_fashion_flutter/core/services/service_locator.dart';
import 'package:e_fashion_flutter/core/widgets/primary_button.dart';
import 'package:e_fashion_flutter/features/search/bloc/search_bloc.dart';
import 'package:e_fashion_flutter/features/search/bloc/search_events.dart';
import 'package:e_fashion_flutter/features/search/screens/widgets/search_filter_brand_items.dart';
import 'package:e_fashion_flutter/features/search/screens/widgets/search_filter_category_items.dart';
import 'package:e_fashion_flutter/features/search/screens/widgets/search_filter_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchModalBottomSheetContent extends StatefulWidget {
  const SearchModalBottomSheetContent({super.key, required this.query});

  final String query;

  @override
  State<SearchModalBottomSheetContent> createState() =>
      _SearchModalBottomSheetContentState();
}

class _SearchModalBottomSheetContentState
    extends State<SearchModalBottomSheetContent> {
  String selectedBrand = '';
  int categoryId = 0;
  int minPrice = 0;
  int maxPrice = 0;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsetsDirectional.only(
        top: 16.0,
        start: 24.0,
        end: 24.0,
      ),
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
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
            SearchFilterBrandItems(
              onBrandChanged: (String brand) {
                selectedBrand = brand;
              },
            ),
            const SizedBox(height: 24.0),
            Text("Categories", style: Theme.of(context).textTheme.bodySmall),
            Divider(thickness: 1.0, color: Colors.grey[300]),
            const SizedBox(height: 8.0),
            SearchFilterCategoryItems(
              onCategoryChanged: (int id) {
                categoryId = id;
              },
            ),
            const SizedBox(height: 24.0),
            Text("Price", style: Theme.of(context).textTheme.bodySmall),
            Divider(thickness: 1.0, height: 12.0, color: Colors.grey[300]),
            const SizedBox(height: 40.0),
            SearchFilterSlider(
              minValue: (int minValue) {
                minPrice = minValue;
              },
              maxValue: (int maxValue) {
                maxPrice = maxValue;
              },
            ),
            PrimaryButton(
              onPressed: () {
                context.read<SearchBloc>().add(
                  SearchProductEvent(
                    query: widget.query,
                    brand: selectedBrand,
                    categoryId: categoryId,
                    minPrice: minPrice,
                    maxPrice: maxPrice,
                  ),
                );
                context.pop();
              },
              text: "Apply Filters",
            ),
            const SizedBox(height: 60.0),
          ],
        ),
      ),
    );
  }
}

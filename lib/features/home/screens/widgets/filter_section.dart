import 'package:e_fashion_flutter/core/utils/assets_manager.dart';
import 'package:e_fashion_flutter/core/widgets/third_button.dart';
import 'package:e_fashion_flutter/features/home/screens/widgets/filter_section_item.dart';
import 'package:flutter/material.dart';

class FilterSection extends StatelessWidget {
  const FilterSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 16.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Filter", style: Theme.of(context).textTheme.bodyMedium),
              ThirdButton(onPressed: () {}, text: "Apply"),
            ],
          ),
          const SizedBox(height: 8.0),
          SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    vertical: 8.0,
                    horizontal: 16.0,
                  ),
                  decoration: BoxDecoration(
                    color:
                        Theme.of(context).colorScheme.surfaceContainerHighest,
                    borderRadius: BorderRadius.circular(16.0),
                  ),
                  child: const Row(
                    children: [
                      FilterSectionItem(
                        text: "Woman",
                        image: AssetsManager.woman,
                      ),
                      SizedBox(width: 16.0),
                      FilterSectionItem(text: "Man", image: AssetsManager.man),
                    ],
                  ),
                ),
                const SizedBox(width: 16.0),
                Stack(
                  alignment: AlignmentDirectional.centerStart,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        vertical: 8.0,
                        horizontal: 16.0,
                      ),
                      decoration: BoxDecoration(
                        color:
                            Theme.of(
                              context,
                            ).colorScheme.surfaceContainerHighest,
                        borderRadius: BorderRadius.circular(16.0),
                      ),
                      child: const Row(
                        children: [
                          FilterSectionItem(
                            text: "jeans",
                            image: AssetsManager.jeans,
                          ),
                          SizedBox(width: 16.0),
                          FilterSectionItem(
                            text: "jeans",
                            image: AssetsManager.jeans,
                          ),
                          SizedBox(width: 16.0),
                          FilterSectionItem(
                            text: "jeans",
                            image: AssetsManager.jeans,
                          ),
                          SizedBox(width: 16.0),
                          FilterSectionItem(
                            text: "jeans",
                            image: AssetsManager.jeans,
                          ),
                          SizedBox(width: 16.0),
                          FilterSectionItem(
                            text: "jeans",
                            image: AssetsManager.jeans,
                          ),
                        ],
                      ),
                    ),
                    Container(
                      height: 40.0,
                      width: 5.0,
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.primary,
                        borderRadius: const BorderRadius.all(
                          Radius.circular(5.0),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

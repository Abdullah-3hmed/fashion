import 'package:e_fashion_flutter/features/home/data/discover_model.dart';
import 'package:e_fashion_flutter/features/home/screens/widgets/discover/discover_grid/discover_grid_item.dart';
import 'package:e_fashion_flutter/features/home/screens/widgets/discover/discover_grid/discover_grid_reverse_item.dart';
import 'package:flutter/material.dart';

class DiscoverGridView extends StatelessWidget {
  const DiscoverGridView({super.key, required this.discoverList});

  final List<DiscoverModel> discoverList;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      key: const ValueKey('discover_grid'),
      physics: const BouncingScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 16.0,
        mainAxisSpacing: 16.0,
        childAspectRatio: 0.75,
      ),
      itemCount: discoverList.length,
      itemBuilder: (context, index) {
        final DiscoverModel model = discoverList[index];
        final bool isFirstItem = index < 2;
        return index.isEven
            ? DiscoverGridItem(discoverModel: model, isFirstItem: isFirstItem)
            : DiscoverGridReverseItem(
              discoverModel: model,
              isFirstItem: isFirstItem,
            );
      },
    );
  }
}

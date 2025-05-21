import 'package:e_fashion_flutter/features/home/data/discover_model.dart';
import 'package:flutter/material.dart';

class DiscoverAndSearchGridView extends StatelessWidget {
  const DiscoverAndSearchGridView({super.key, required this.discoverList});

  final List<DiscoverModel> discoverList;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      key: const ValueKey('grid'),
      physics: const BouncingScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 16.0,
        mainAxisSpacing: 16.0,
        childAspectRatio: 0.75,
      ),
      itemCount: discoverList.length,
      itemBuilder: (context, index) => const SizedBox.shrink(),
      // DiscoverAndSearchItem(discoverModel: discoverList[index]),
    );
  }
}

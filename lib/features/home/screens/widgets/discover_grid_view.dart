import 'package:e_fashion_flutter/features/home/screens/widgets/discover_item.dart';
import 'package:flutter/material.dart';

class DiscoverGridView extends StatelessWidget {
  const DiscoverGridView({super.key});

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
      itemCount: 10,
      itemBuilder: (context, index) => const DiscoverItem(),
    );
  }
}

import 'package:e_fashion_flutter/features/favourite/screens/widgets/favorite_item.dart';
import 'package:flutter/material.dart';

class FavoriteGridView extends StatelessWidget {
  const FavoriteGridView({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      physics: const BouncingScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 200.0,
        crossAxisSpacing: 12.0,
        mainAxisSpacing: 10.0,
        childAspectRatio: 0.65,
      ),
      itemBuilder: (context, index) => const FavoriteItem(),
      itemCount: 10,
    );
  }
}

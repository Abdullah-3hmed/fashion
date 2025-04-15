import 'package:auto_route/auto_route.dart';
import 'package:e_fashion_flutter/features/favourite/screens/widgets/favorite_item.dart';
import 'package:flutter/material.dart';

@RoutePage()
class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Your Favourites",
          style: Theme.of(context).textTheme.titleMedium,
        ),
      ),
      body: Padding(
        padding: const EdgeInsetsDirectional.symmetric(horizontal: 24.0),
        child: GridView.builder(
          physics: const BouncingScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 12.0,
            mainAxisSpacing: 10.0,
            childAspectRatio: 0.67,
          ),
          itemBuilder: (context, index) => const FavoriteItem(),
          itemCount: 10,
        ),
      ),
    );
  }
}

import 'package:auto_route/auto_route.dart';
import 'package:e_fashion_flutter/features/favourite/screens/widgets/favorite_grid_view.dart';
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
      body: const Padding(
        padding: EdgeInsetsDirectional.symmetric(horizontal: 24.0),
        child: FavoriteGridView(),
      ),
    );
  }
}

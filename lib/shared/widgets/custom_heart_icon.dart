import 'package:e_fashion_flutter/features/favourite/cubit/favorite_cubit.dart';
import 'package:e_fashion_flutter/features/favourite/cubit/favorite_state.dart';
import 'package:e_fashion_flutter/shared/data/product_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:solar_icons/solar_icons.dart';

class CustomHeartIcon extends StatelessWidget {
  const CustomHeartIcon({super.key, required this.productModel});

  final ProductModel productModel;

  @override
  Widget build(BuildContext context) {
    return BlocSelector<FavoriteCubit, FavoriteState, bool>(
      selector: (state) => state.favorites.containsKey(productModel.id),
      builder: (context, inFavorites) {
        return GestureDetector(
          onTap: () async {
            await context.read<FavoriteCubit>().addAndRemoveFavorite(
              favoriteModel: productModel.toFavoriteModel(),
            );
          },
          child: AnimatedSwitcher(
            duration: const Duration(milliseconds: 300),
            transitionBuilder: (child, anim) =>
                ScaleTransition(scale: anim, child: child),
            child: Icon(
              inFavorites ? SolarIconsBold.heart : SolarIconsOutline.heart,
              key: ValueKey(inFavorites),
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
        );
      },
    );
  }
}

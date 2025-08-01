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
      selector: (state) {
        return state.inFavorites.contains(productModel.id);
      },
      builder: (context, inFavorites) {
        return IconButton(
          onPressed: () async {
            await context.read<FavoriteCubit>().addAndRemoveFavorite(
              favoriteModel: productModel.toFavoriteModel(),
            );
          },
          icon: Icon(
            inFavorites ? SolarIconsBold.heart : SolarIconsOutline.heart,
            color: Theme.of(context).colorScheme.primary,
          ),
        );
      },
    );
  }
}

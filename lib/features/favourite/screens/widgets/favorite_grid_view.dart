import 'package:e_fashion_flutter/core/enums/request_status.dart';
import 'package:e_fashion_flutter/core/utils/app_constants.dart';
import 'package:e_fashion_flutter/features/favourite/cubit/favorite_cubit.dart';
import 'package:e_fashion_flutter/features/favourite/cubit/favorite_state.dart';
import 'package:e_fashion_flutter/features/favourite/data/favorite_model.dart';
import 'package:e_fashion_flutter/features/favourite/screens/widgets/favorite_item.dart';
import 'package:e_fashion_flutter/features/favourite/screens/widgets/no_favorite_items.dart';
import 'package:e_fashion_flutter/shared/data/product_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';

class FavoriteGridView extends StatelessWidget {
  const FavoriteGridView({super.key});

  static const dummy = FavoriteModel(
    id: "",
    title: "",
    price: 0.0,
    image: AppConstants.imageUrl,
  );

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FavoriteCubit, FavoriteState>(
      buildWhen: (pre, cur) => pre.favoriteState != cur.favoriteState || pre.inFavorites != cur.inFavorites,
      builder: (context, state) {
        switch (state.favoriteState) {
          case RequestStatus.loading:
            return Skeletonizer(
              child: GridView.builder(
                physics: const BouncingScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 200.0,
                  crossAxisSpacing: 12.0,
                  mainAxisSpacing: 10.0,
                  childAspectRatio: 0.63,
                ),
                itemCount: 6,
                itemBuilder:
                    (context, index) =>
                        const FavoriteItem(favoriteModel: dummy),
              ),
            );
          case RequestStatus.success:
            return state.favorites.isEmpty
                ? const NoFavoriteItems()
                : GridView.builder(
                  physics: const BouncingScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 200.0,
                    crossAxisSpacing: 12.0,
                    mainAxisSpacing: 10.0,
                    childAspectRatio: 0.63,
                  ),
                  itemCount: state.favorites.length,
                  itemBuilder:
                      (context, index) =>
                          FavoriteItem(favoriteModel: state.favorites[index]),
                );

          case RequestStatus.error:
            return Center(
              child: Text(
                state.favoriteErrorMessage,
                style: Theme.of(context).textTheme.titleMedium,
              ),
            );

          default:
            return const SizedBox.shrink();
        }
      },
    );
  }
}

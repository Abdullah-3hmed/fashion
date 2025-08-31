import 'package:e_fashion_flutter/core/enums/request_status.dart';
import 'package:e_fashion_flutter/core/utils/app_constants.dart';
import 'package:e_fashion_flutter/core/utils/show_toast.dart';
import 'package:e_fashion_flutter/core/utils/toast_states.dart';
import 'package:e_fashion_flutter/core/widgets/no_internet_widget.dart';
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
    colors: "",
    sizes: "",
  );

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<FavoriteCubit, FavoriteState>(
      listenWhen:
          (pre, cur) =>
              pre.favoriteState != cur.favoriteState ||
              pre.favorites != cur.favorites,
      listener: (context, state) {
        if (state.favoriteState.isError) {
          showToast(
            message: state.favoriteErrorMessage,
            state: ToastStates.error,
          );
        }
      },
      buildWhen:
          (pre, cur) =>
              pre.favoriteState != cur.favoriteState ||
              pre.favorites != cur.favorites,
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
                : _buildGridView(state: state);
          case RequestStatus.error:
            return state.favorites.isEmpty
                ? const NoFavoriteItems()
                : _buildGridView(state: state);

          default:
            return const SizedBox.shrink();
        }
      },
    );
  }

  GridView _buildGridView({required FavoriteState state}) {
    final List<FavoriteModel> favorites = state.favorites.values.toList();
    return GridView.builder(
      physics: const BouncingScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 200.0,
        crossAxisSpacing: 12.0,
        mainAxisSpacing: 10.0,
        childAspectRatio: 0.6,
      ),
      itemCount: state.favorites.length,
      itemBuilder:
          (context, index) => FavoriteItem(favoriteModel: favorites[index]),
    );
  }
}

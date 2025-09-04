import 'package:auto_route/auto_route.dart';
import 'package:e_fashion_flutter/core/enums/request_status.dart';
import 'package:e_fashion_flutter/core/utils/app_constants.dart';
import 'package:e_fashion_flutter/core/utils/show_toast.dart';
import 'package:e_fashion_flutter/features/favourite/cubit/favorite_cubit.dart';
import 'package:e_fashion_flutter/features/favourite/cubit/favorite_state.dart';
import 'package:e_fashion_flutter/features/favourite/data/favorite_model.dart';
import 'package:e_fashion_flutter/features/favourite/screens/widgets/favorite_item.dart';
import 'package:e_fashion_flutter/features/favourite/screens/widgets/no_favorite_items.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';

@RoutePage()
class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({super.key});

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;
  static const dummyFavoriteModel = FavoriteModel(
    id: "",
    title: "",
    price: 0.0,
    image: AppConstants.imageUrl,
    colors: "",
    sizes: "",
  );

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Your Favourites",
          style: Theme.of(context).textTheme.titleMedium,
        ),
      ),
      body: Padding(
        padding: const EdgeInsetsDirectional.symmetric(horizontal: 24.0),
        child: BlocConsumer<FavoriteCubit, FavoriteState>(
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
                    gridDelegate:
                        const SliverGridDelegateWithMaxCrossAxisExtent(
                          maxCrossAxisExtent: 200.0,
                          crossAxisSpacing: 12.0,
                          mainAxisSpacing: 10.0,
                          childAspectRatio: 0.63,
                        ),
                    itemCount: 6,
                    itemBuilder:
                        (context, index) => const FavoriteItem(
                          favoriteModel: dummyFavoriteModel,
                        ),
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
        ),
      ),
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
        childAspectRatio: 0.68,
      ),
      itemCount: state.favorites.length,
      itemBuilder:
          (context, index) => FavoriteItem(favoriteModel: favorites[index]),
    );
  }
}

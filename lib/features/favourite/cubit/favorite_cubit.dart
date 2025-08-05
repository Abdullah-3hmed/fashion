import 'package:e_fashion_flutter/core/enums/request_status.dart';
import 'package:e_fashion_flutter/features/favourite/cubit/favorite_state.dart';
import 'package:e_fashion_flutter/features/favourite/data/favorite_model.dart';
import 'package:e_fashion_flutter/features/favourite/repos/favorite_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FavoriteCubit extends Cubit<FavoriteState> {
  final FavoriteRepo favoriteRepo;

  FavoriteCubit({required this.favoriteRepo}) : super(const FavoriteState());

  Future<void> addAndRemoveFavorite({
    required FavoriteModel favoriteModel,
  }) async {
    final Set<String> oldInFavorites = {...state.inFavorites};
    final List<FavoriteModel> oldFavorites = [...state.favorites];
    final Set<String> inFavorites = {...state.inFavorites};
    final List<FavoriteModel> favorites = [...state.favorites];
    if (inFavorites.contains(favoriteModel.id)) {
      inFavorites.remove(favoriteModel.id);
      favorites.removeWhere((element) => element.id == favoriteModel.id);
    } else {
      inFavorites.add(favoriteModel.id);
      favorites.add(favoriteModel);
    }
    emit(state.copyWith(inFavorites: inFavorites, favorites: favorites));
    final result = await favoriteRepo.addAndRemoveToFavorite(
      productId: favoriteModel.id,
    );
    result.fold(
      (failure) => emit(
        state.copyWith(
          favoriteErrorMessage: failure.errorMessage,
          favoriteState: RequestStatus.error,
          inFavorites: oldInFavorites,
          favorites: oldFavorites,
        ),
      ),
      (_) {
        emit(state.copyWith(favoriteState: RequestStatus.success));
      },
    );
  }

  Future<void> getFavorites() async {
    emit(state.copyWith(favoriteState: RequestStatus.loading));
    final result = await favoriteRepo.getFavorites();
    result.fold(
      (failure) => emit(
        state.copyWith(
          favoriteErrorMessage: failure.errorMessage,
          favoriteState: RequestStatus.error,
        ),
      ),
      (favorites) {
        final Set<String> favoriteIds = favorites.map((e) => e.id).toSet();
        emit(
          state.copyWith(
            favorites: favorites,
            favoriteState: RequestStatus.success,
            inFavorites: favoriteIds,
          ),
        );
      },
    );
  }
}

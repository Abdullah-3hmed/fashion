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
    final FavoriteState oldState = state;
    final Map<String, FavoriteModel> favorites = {...state.favorites};
    if (favorites.containsKey(favoriteModel.id)) {
      favorites.remove(favoriteModel.id);
    } else {
      favorites.putIfAbsent(favoriteModel.id, () => favoriteModel);
    }
    emit(state.copyWith(favorites: favorites));
    final result = await favoriteRepo.addAndRemoveToFavorite(
      productId: favoriteModel.id,
    );
    result.fold(
      (failure) => emit(
        oldState.copyWith(
          favoriteErrorMessage: failure.errorMessage,
          favoriteState: RequestStatus.error,
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
        emit(
          state.copyWith(
            favorites: _generateFavoritesMap(favorites),
            favoriteState: RequestStatus.success,
          ),
        );
      },
    );
  }

  Map<String, FavoriteModel> _generateFavoritesMap(
    List<FavoriteModel> favorites,
  ) {
    final Map<String, FavoriteModel> favoritesMap = {
      for (var item in favorites) item.id: item,
    };
    return favoritesMap;
  }
}

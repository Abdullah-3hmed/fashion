import 'package:e_fashion_flutter/core/enums/request_status.dart';
import 'package:e_fashion_flutter/features/favourite/data/favorite_model.dart';
import 'package:equatable/equatable.dart';

class FavoriteState extends Equatable {
  final RequestStatus favoriteState;
  final String favoriteErrorMessage;
  final List<FavoriteModel> favorites;
  final Set<String> inFavorites;

  const FavoriteState({
    this.favoriteState = RequestStatus.initial,
    this.favoriteErrorMessage = "",
    this.favorites = const [],
    this.inFavorites = const {},
  });

  FavoriteState copyWith({
    RequestStatus? favoriteState,
    String? favoriteErrorMessage,
    List<FavoriteModel>? favorites,
    Set<String>? inFavorites,
  }) {
    return FavoriteState(
      favoriteState: favoriteState ?? this.favoriteState,
      favoriteErrorMessage: favoriteErrorMessage ?? this.favoriteErrorMessage,
      favorites: favorites ?? this.favorites,
      inFavorites: inFavorites ?? this.inFavorites,
    );
  }

  @override
  List<Object> get props => [
    favoriteState,
    favoriteErrorMessage,
    favorites,
    inFavorites,
  ];
}

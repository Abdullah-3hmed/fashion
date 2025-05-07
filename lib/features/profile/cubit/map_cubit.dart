import 'package:e_fashion_flutter/core/utils/assets_manager.dart';
import 'package:e_fashion_flutter/features/profile/cubit/map_state.dart';
import 'package:e_fashion_flutter/features/profile/repos/map_repo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapCubit extends Cubit<MapState> {
  MapCubit({required this.mapRepo}) : super(const MapState());
  final MapRepo mapRepo;

  Future<void> setMapStyle({required BuildContext context}) async {
    String style = await DefaultAssetBundle.of(
      context,
    ).loadString(AssetsManager.mapStyle);
    emit(state.copyWith(mapStyle: style));
  }

  Future<void> getCurrentLocation({
    required GoogleMapController mapController,
  }) async {
    final result = await mapRepo.getCurrentLocation(
      mapController: mapController,
    );
    result.fold(
      (failure) =>
          emit(state.copyWith(getLocationErrorMessage: failure.errorMessage)),
      (locationMarker) =>
          emit(state.copyWith(myLocationMarker: {locationMarker})),
    );
  }
}

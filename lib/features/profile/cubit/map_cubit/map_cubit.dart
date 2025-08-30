import 'package:e_fashion_flutter/core/enums/request_status.dart';
import 'package:e_fashion_flutter/core/utils/assets_manager.dart';
import 'package:e_fashion_flutter/features/profile/cubit/map_cubit/map_state.dart';
import 'package:e_fashion_flutter/features/profile/cubit/user_cubit/user_cubit.dart';
import 'package:e_fashion_flutter/features/profile/repos/map_repo/map_repo.dart';
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

  Future<String> getCurrentLocation({
    required GoogleMapController mapController,
  }) async {
    final result = await mapRepo.getCurrentLocation(
      mapController: mapController,
    );

    return await result.fold(
      (failure) {
        emit(
          state.copyWith(
            getLocationErrorMessage: failure.errorMessage,
            locationStatus: RequestStatus.error,
          ),
        );
        return Future.value("");
      },
      (locationMarker) async {
        emit(
          state.copyWith(
            myLocationMarker: {locationMarker},
            locationStatus: RequestStatus.success,
          ),
        );

        return await getPlaceName(location: locationMarker.position);
      },
    );
  }

  Future<String> changeLocation({
    required GoogleMapController mapController,
    required LatLng newLocation,
  }) async {
    final result = await mapRepo.changeLocation(
      mapController: mapController,
      newLocation: newLocation,
    );

    return await result.fold(
      (failure) {
        emit(
          state.copyWith(
            getLocationErrorMessage: failure.errorMessage,
            locationStatus: RequestStatus.error,
          ),
        );
        return Future.value("");
      },
      (locationMarker) async {
        emit(
          state.copyWith(
            myLocationMarker: {locationMarker},
            locationStatus: RequestStatus.success,
          ),
        );
        return await getPlaceName(location: locationMarker.position);
      },
    );
  }

  Future<String> getPlaceName({required LatLng location}) async {
    return await mapRepo.getPlaceName(location: location);
  }
}

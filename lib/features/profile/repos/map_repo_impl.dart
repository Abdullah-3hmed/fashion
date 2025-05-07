import 'package:dartz/dartz.dart';
import 'package:e_fashion_flutter/core/error/failures.dart';
import 'package:e_fashion_flutter/core/services/location_service.dart';
import 'package:e_fashion_flutter/core/services/service_locator.dart';
import 'package:e_fashion_flutter/features/profile/repos/map_repo.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapRepoImpl implements MapRepo {
  @override
  Future<Either<Failure, Marker>> getCurrentLocation({
    required GoogleMapController mapController,
  }) async {
    try {
      final locationData = await getIt<LocationService>().getCurrentLocation();
      final LatLng currentLocation = LatLng(
        locationData.latitude!,
        locationData.longitude!,
      );
      Marker myLocationMarker = Marker(
        markerId: const MarkerId("myLocation"),
        position: currentLocation,
      );
      mapController.animateCamera(CameraUpdate.newLatLng(currentLocation));
      return Right(myLocationMarker);
    } on Exception catch (e) {
      return Left(LocationFailure.fromException(e));
    }
  }
}

import 'package:dartz/dartz.dart';
import 'package:e_fashion_flutter/core/error/failures.dart';
import 'package:e_fashion_flutter/core/services/location_service.dart';
import 'package:e_fashion_flutter/core/services/service_locator.dart';
import 'package:e_fashion_flutter/features/profile/repos/map_repo/map_repo.dart';
import 'package:geocoding/geocoding.dart';
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
      await mapController.animateCamera(
        CameraUpdate.newLatLng(currentLocation),
      );
      return Right(myLocationMarker);
    } on Exception catch (e) {
      return Left(LocationFailure.fromException(e));
    }
  }

  @override
  Future<Either<Failure, Marker>> changeLocation({
    required GoogleMapController mapController,
    required LatLng newLocation,
  }) async {
    try {
      Marker myLocationMarker = Marker(
        markerId: const MarkerId("myLocation"),
        position: newLocation,
      );
      await mapController.animateCamera(CameraUpdate.newLatLng(newLocation));
      return Right(myLocationMarker);
    } on Exception catch (e) {
      return Left(LocationFailure.fromException(e));
    }
  }

  @override
  Future<String> getPlaceName({required LatLng location}) async {
    double lat = location.latitude;
    double lng = location.longitude;
    List<Placemark> placeMarks = await placemarkFromCoordinates(lat, lng);
    if (placeMarks.isNotEmpty) {
      Placemark place = placeMarks.first;
      return "${place.street}, ${place.locality}, ${place.subLocality}";
    }
    return "";
  }
}

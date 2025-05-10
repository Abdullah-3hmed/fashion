import 'package:dartz/dartz.dart';
import 'package:e_fashion_flutter/core/error/failures.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

abstract class MapRepo {
  Future<Either<Failure, Marker>> getCurrentLocation({
    required GoogleMapController mapController,
  });
  Future<Either<Failure, Marker>> changeLocation({
    required GoogleMapController mapController,
    required LatLng newLocation,
  });
  Future<String> getPlaceName({required LatLng location});
}

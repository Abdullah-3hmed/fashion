import 'package:location/location.dart';

class LocationService {
  Location location = Location();

  Future<void> checkAndRequestLocationService() async {
    bool isServiceEnabled = await location.serviceEnabled();
    if (!isServiceEnabled) {
      isServiceEnabled = await location.requestService();
      if (!isServiceEnabled) {
        throw LocationServiceException(
          errorMessage: 'Location service is not enabled',
        );
      }
    }
  }

  Future<void> checkAndRequestLocationPermission() async {
    PermissionStatus permissionStatus = await location.hasPermission();
    if (permissionStatus == PermissionStatus.deniedForever) {
      throw LocationPermissionException(
        errorMessage: 'Location permission is denied forever',
      );
    } else if (permissionStatus == PermissionStatus.denied) {
      permissionStatus = await location.requestPermission();
      if (permissionStatus != PermissionStatus.granted) {
        throw LocationPermissionException(
          errorMessage: 'Location permission is denied',
        );
      }
    }
  }

  Future<void> getRealTimeLocationData(
    void Function(LocationData)? onData,
  ) async {
    await checkAndRequestLocationService();
    await checkAndRequestLocationPermission();
    location.onLocationChanged.listen(onData);
  }

  Future<LocationData> getCurrentLocation() async {
    await checkAndRequestLocationService();
    await checkAndRequestLocationPermission();
    return await location.getLocation();
  }
}

class LocationServiceException implements Exception {
  final String errorMessage;

  LocationServiceException({required this.errorMessage});
}

class LocationPermissionException implements Exception {
  final String errorMessage;

  LocationPermissionException({required this.errorMessage});
}

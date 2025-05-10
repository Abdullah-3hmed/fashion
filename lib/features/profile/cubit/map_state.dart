import 'package:e_fashion_flutter/core/enums/request_status.dart';
import 'package:equatable/equatable.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapState extends Equatable {
  final String mapStyle;
  final String getLocationErrorMessage;
  final RequestStatus locationStatus;
  final Set<Marker> myLocationMarker;

  const MapState({
    this.mapStyle = "",
    this.getLocationErrorMessage = "",
    this.myLocationMarker = const {},
    this.locationStatus = RequestStatus.initial,
  });

  MapState copyWith({
    String? mapStyle,
    String? getLocationErrorMessage,
    Set<Marker>? myLocationMarker,
    RequestStatus? locationStatus,
  }) {
    return MapState(
      mapStyle: mapStyle ?? this.mapStyle,
      getLocationErrorMessage:
          getLocationErrorMessage ?? this.getLocationErrorMessage,
      myLocationMarker: myLocationMarker ?? this.myLocationMarker,
      locationStatus: locationStatus ?? this.locationStatus,
    );
  }

  @override
  List<Object> get props => [
    mapStyle,
    getLocationErrorMessage,
    myLocationMarker,
    locationStatus,
  ];
}

import 'package:equatable/equatable.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapState extends Equatable {
  final String mapStyle;
  final String getLocationErrorMessage;
  final Set<Marker> myLocationMarker;

  const MapState({
    this.mapStyle = "",
    this.getLocationErrorMessage = "",
    this.myLocationMarker = const {},
  });

  MapState copyWith({
    String? mapStyle,
    String? getLocationErrorMessage,
    Set<Marker>? myLocationMarker,
  }) {
    return MapState(
      mapStyle: mapStyle ?? this.mapStyle,
      getLocationErrorMessage:
          getLocationErrorMessage ?? this.getLocationErrorMessage,
      myLocationMarker: myLocationMarker ?? this.myLocationMarker,
    );
  }

  @override
  List<Object> get props => [
    mapStyle,
    getLocationErrorMessage,
    myLocationMarker,
  ];
}

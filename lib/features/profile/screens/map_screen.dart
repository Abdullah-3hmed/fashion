import 'package:auto_route/auto_route.dart';
import 'package:e_fashion_flutter/core/services/service_locator.dart';
import 'package:e_fashion_flutter/features/profile/cubit/map_cubit.dart';
import 'package:e_fashion_flutter/features/profile/cubit/map_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

@RoutePage()
class MapScreen extends StatefulWidget implements AutoRouteWrapper {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();

  @override
  Widget wrappedRoute(BuildContext context) => BlocProvider(
    create: (context) => getIt<MapCubit>()..setMapStyle(context: context),
    child: this,
  );
}

class _MapScreenState extends State<MapScreen> {
  late CameraPosition initialCameraPosition;
  late GoogleMapController mapController;

  @override
  void initState() {
    initialCameraPosition = const CameraPosition(
      target: LatLng(0, 0),
      zoom: 14,
    );
    super.initState();
  }

  @override
  void dispose() {
    mapController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<MapCubit, MapState>(
        builder: (context, state) {
          return GoogleMap(
            style: state.mapStyle,
            markers: state.myLocationMarker,
            onMapCreated: (controller) async {
              mapController = controller;
              await context.read<MapCubit>().getCurrentLocation(
                mapController: mapController,
              );
            },
            onTap: (LatLng newLocation) async {
              await context.read<MapCubit>().changeLocation(
                mapController: mapController,
                newLocation: newLocation,
              );
            },
            zoomControlsEnabled: false,
            initialCameraPosition: initialCameraPosition,
          );
        },
      ),
    );
  }
}

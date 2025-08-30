import 'package:auto_route/auto_route.dart';
import 'package:e_fashion_flutter/core/enums/request_status.dart';
import 'package:e_fashion_flutter/core/services/service_locator.dart';
import 'package:e_fashion_flutter/core/utils/show_toast.dart';
import 'package:e_fashion_flutter/core/utils/toast_states.dart';
import 'package:e_fashion_flutter/core/widgets/primary_button.dart';
import 'package:e_fashion_flutter/features/profile/cubit/map_cubit/map_cubit.dart';
import 'package:e_fashion_flutter/features/profile/cubit/map_cubit/map_state.dart';
import 'package:e_fashion_flutter/features/profile/cubit/user_cubit/user_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

@RoutePage()
class MapScreen extends StatefulWidget implements AutoRouteWrapper {
  const MapScreen({super.key, required this.userCubit});
final UserCubit userCubit;
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
      body: BlocConsumer<MapCubit, MapState>(
        listener: (context, state) {
          if (state.locationStatus == RequestStatus.error) {
            context.pop();
            showToast(
              message: state.getLocationErrorMessage,
              state: ToastStates.error,
            );
          }
        },
        builder: (context, state) {
          return Stack(
            children: [
              GoogleMap(
                style: state.mapStyle,
                markers: state.myLocationMarker,
                onMapCreated: (controller) async {
                  mapController = controller;
                 final String userLocation = await context.read<MapCubit>().getCurrentLocation(
                    mapController: mapController,
                  );
                 widget.userCubit.setUserLocation(location:userLocation);
                },
                onTap: (LatLng newLocation) async {
                final String userLocation =  await context.read<MapCubit>().changeLocation(
                    mapController: mapController,
                    newLocation: newLocation,
                  );
                  widget.userCubit.setUserLocation(location:userLocation);
                },
                zoomControlsEnabled: false,
                initialCameraPosition: initialCameraPosition,
              ),
              PositionedDirectional(
                bottom: 40,
                end: 20,
                start: 20,
                child: PrimaryButton(
                  text: "Confirm Location",
                  onPressed: () {
                    context.pop();
                    showToast(
                      message: "Your Location Confirmed Successfully",
                      state: ToastStates.success,
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

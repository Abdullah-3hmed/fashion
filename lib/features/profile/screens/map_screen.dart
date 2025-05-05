import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

@RoutePage()
class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  late CameraPosition initialCameraPosition;
  GoogleMapController? mapController;
  String mapStyle = "";

  @override
  void initState() {
    initialCameraPosition = const CameraPosition(
      target: LatLng(26.61817517870546, 31.52886861007292),
      zoom: 14,
    );
    _setMapStyle();
    super.initState();
  }

  @override
  void dispose() {
    mapController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
        style: mapStyle,
        onMapCreated: (controller) {
          mapController = controller;
        },
        initialCameraPosition: initialCameraPosition,
      ),
    );
  }

  Future<void> _setMapStyle() async {
    String style = await DefaultAssetBundle.of(
      context,
    ).loadString('assets/map_style/map_style.json');
    setState(() {
      mapStyle = style;
    });
  }
}

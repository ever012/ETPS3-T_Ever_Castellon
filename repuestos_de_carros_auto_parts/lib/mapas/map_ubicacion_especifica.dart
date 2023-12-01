import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapUbicaciones extends StatefulWidget {
  final String id;
  final double latitud;
  final double longitud;
  final String nombre;

  const MapUbicaciones({required this.id, required this.latitud, required this.longitud, required this.nombre, Key? key}) : super(key: key);

  @override
  State<MapUbicaciones> createState() => _MapUbicacionesState();
}

class _MapUbicacionesState extends State<MapUbicaciones> {
  late Set<Marker> _markers;

  @override
  void initState() {
    super.initState();
    _markers = <Marker>{};
    _addMarker(widget.id, widget.latitud, widget.longitud, widget.nombre);
  }

  Future<void> _addMarker(String id, double latitud, double longitud, String nombre) async {
    _markers.add(
      Marker(
        markerId: MarkerId(id),
        position: LatLng(longitud, latitud),
        infoWindow: InfoWindow(title: nombre),
        icon: await _createCustomMarker(context),
      ),
    );
    setState(() {});
  }

  Future<BitmapDescriptor> _createCustomMarker(BuildContext context) async {
    return await BitmapDescriptor.fromAssetImage(
      const ImageConfiguration(devicePixelRatio: 5),
      "assets/Iconos/puntero-del-mapa.png",
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Google Maps'),
      ),
      body: GoogleMap(
        initialCameraPosition: const CameraPosition(target: LatLng(13.701503510208184, -89.2015454424298), zoom: 12.0),
        markers: _markers,
      ),
    );
  }
}
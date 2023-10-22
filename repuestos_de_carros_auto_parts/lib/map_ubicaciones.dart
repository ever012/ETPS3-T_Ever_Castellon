import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:repuestos_de_carros_auto_parts/menu_lateral.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'api_config.dart';

class MapUbicaciones extends StatefulWidget {
  const MapUbicaciones({super.key});

  @override
  State<MapUbicaciones> createState() => _MapUbicacionesState();
}

class _MapUbicacionesState extends State<MapUbicaciones> {
  late Set<Marker> _markers;

  @override
  void initState() {
    super.initState();
    _markers = Set<Marker>();
    _fetchLocations();
  }

  Future<void> _fetchLocations() async {
    final response = await http.get(Uri.parse('${ApiConfig.apiUrl}api/ubicacion/listaUbicacion'));
    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      for (var location in data) {
        _markers.add(
          Marker(
            markerId: MarkerId(location['cod_ubicacion']),
            position: LatLng(location['longitud'], location['latitud']),
            infoWindow: InfoWindow(title: location['nombre']),
            icon: await _createCustomMarker(context),
          ),
        );
      }
      setState(() {});
    } else {
      throw Exception('Failed to load locations');
    }
  }

  Future<BitmapDescriptor> _createCustomMarker(BuildContext context) async {
    return await BitmapDescriptor.fromAssetImage(
      ImageConfiguration(devicePixelRatio: 5),
      "assets/Iconos/puntero-del-mapa.png",
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Google Maps'),
      ),
      body: GoogleMap(
        initialCameraPosition: CameraPosition(target: LatLng(13.701503510208184, -89.2015454424298), zoom: 12.0),
        markers: _markers,
      ),
    );
  }
}
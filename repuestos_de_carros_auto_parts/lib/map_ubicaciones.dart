import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:repuestos_de_carros_auto_parts/menu_lateral.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';


class MapUbicaciones extends StatefulWidget {
  const MapUbicaciones({super.key});

  @override
  State<MapUbicaciones> createState() => _MapUbicacionesState();
}

class _MapUbicacionesState extends State<MapUbicaciones> {
  @override
  Widget build(BuildContext context) {





    return SafeArea(
        child: Scaffold(

          drawer: const MenuLateral(),
          body: SimpleMap(),
        ),
        );
  }
}





class SimpleMap extends StatefulWidget {


  @override
  _SimpleMapState createState() => _SimpleMapState();
}

class _SimpleMapState extends State<SimpleMap> {
  static final LatLng _kMapCenter = LatLng(13.701503510208184, -89.2015454424298);

  static final CameraPosition _kInitialPosition =
  CameraPosition(target: _kMapCenter, zoom: 15.0, tilt: 0, bearing: 0);








  Future<BitmapDescriptor> _createCustomMarker(BuildContext context) async {
    return await BitmapDescriptor.fromAssetImage(
      ImageConfiguration(devicePixelRatio: 5), // Ajusta el factor de escala según tus necesidades
      "assets/Iconos/puntero-del-mapa.png",
    );
  }

  Set<Marker> _markers = Set<Marker>();

  @override
  void initState() {
    super.initState();
    _createCustomMarker(context).then((icon) {
      setState(() {
        _markers.add(
          Marker(
            markerId: MarkerId('marker1'),
            position: LatLng(13.70015385285095, -89.20421310882374),
            infoWindow: InfoWindow(title: 'Hospital 1 de mayo'), //hospital 1 de mayo
            icon: icon,
          ),
        );
        _markers.add(
          Marker(
            markerId: MarkerId('marker2'),
            position: LatLng(13.701503510208184, -89.2015454424298),
            infoWindow: InfoWindow(title: 'UTEC'), //universidad tecnologica
            icon: icon,
          ),
        );
        _markers.add(
          Marker(
            markerId: MarkerId('marker3'),
            position: LatLng(13.69884453598454, -89.1994360762877),
            infoWindow: InfoWindow(title: 'fondo social para la vivienda'), //fondo social
            icon: icon,
          ),
        );
        _markers.add(
          Marker(
            markerId: MarkerId('marker4'),
            position: LatLng(13.699049330054446, -89.20287632708713),
            infoWindow: InfoWindow(title: 'repuestos excel automotriz'), //repuestos excel automotriz
            icon: icon,
          ),
        );
        _markers.add(
          Marker(
            markerId: MarkerId('marker5'),
            position: LatLng(13.69888838865025, -89.20662118978044),
            infoWindow: InfoWindow(title: 'parque cuscatlan'), //parque cuscatlan
            icon: icon,
          ),
        );
      });
    });
  }














  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Google Maps'),
      ),
      body: GoogleMap(
        initialCameraPosition: _kInitialPosition,
        markers: _markers,
      ),
    );
  }
}
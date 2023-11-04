import 'package:flutter/material.dart';
import 'package:repuestos_de_carros_auto_parts/menu_lateral_admin.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../api_config.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.black38),
        useMaterial3: true,
        scaffoldBackgroundColor: const Color.fromARGB(255, 238, 238, 238),
      ),
      routes: {
        '/': (context) => const UbicacionesPage(),
      },
    );
  }
}

class UbicacionesPage extends StatefulWidget {
  const UbicacionesPage({super.key});

  @override
  _UbicacionesPageState createState() => _UbicacionesPageState();
}

class _UbicacionesPageState extends State<UbicacionesPage> {
  final TextEditingController _idController = TextEditingController();
  final TextEditingController _codigoController = TextEditingController();
  final TextEditingController _nombreController = TextEditingController();
  final TextEditingController _coordenadasLongitudController = TextEditingController();
  final TextEditingController _coordenadasLatitudController = TextEditingController();
  String? nombreUsuario;
  String? tokenCompartido;

// Crear una notificación en la parte inferior de la app
  void _showNotification(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  @override
  void initState() {
    super.initState();
    _loadSharedPreferences();
  }

  Future<void> _loadSharedPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? tokenShared = prefs.getString('token');
    final String? nombreShared = prefs.getString('usuario');

    setState(() {
      nombreUsuario = nombreShared;
      tokenCompartido = tokenShared;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            "Ubicaciones",
            style: TextStyle(fontSize: 30, fontWeight: FontWeight.w500),
          ),
          centerTitle: true,
        ),
        drawer: const MenuLateralAdmin(),
        body: SingleChildScrollView(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 30.0),
                _idTextField(),
                const SizedBox(height: 30.0),
                _codigoTextField(),
                const SizedBox(height: 15.0),
                _nombreTextField(),
                const SizedBox(height: 15.0),
                _coordenadasLongitudTextField(),
                const SizedBox(height: 15.0),
                _coordenadasLatitudTextField(),
                const SizedBox(height: 20.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _botonGuardar(),
                    _botonEliminar(),
                    _botonModificar(),
                  ],
                ),
                const SizedBox(height: 20.0),
              ],
            ),
          ),
        ),
      ),
    );
  }


  Widget _idTextField() {
    return StreamBuilder(
        stream: null,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          return Container(
            padding: const EdgeInsets.symmetric(horizontal: 5.0),
            child: TextField(
              controller: _idController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(15)),),
                //icon: Icon(Icons.numbers),
                hintText: 'Id Ubicacion',
                labelText: 'ID',
                labelStyle: TextStyle(color: Colors.black),
                focusColor: Colors.teal,
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(15)),
                  borderSide: BorderSide(
                      color: Colors.black),

                ),
              ),

              onChanged: (value) {},
            ),
          );
        });
  }


  Widget _codigoTextField() {
    return StreamBuilder(
        stream: null,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          return Container(
            padding: const EdgeInsets.symmetric(horizontal: 5.0),
            child: TextField(
              controller: _codigoController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(15)),),
                //icon: Icon(Icons.numbers),
                hintText: 'Codigo Ubicacion',
                labelText: 'Codigo',
                labelStyle: TextStyle(color: Colors.black),
                focusColor: Colors.teal,
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(15)),
                  borderSide: BorderSide(
                      color: Colors.black),

                ),
              ),

              onChanged: (value) {},
            ),
          );
        });
  }


  Widget _nombreTextField() {
    return StreamBuilder(
        stream: null,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          return Container(
            padding: const EdgeInsets.symmetric(horizontal: 5.0),
            child: TextField(
              controller: _nombreController,
              keyboardType: TextInputType.text,
              decoration: const InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(15)),),
                //icon: Icon(Icons.numbers),
                hintText: 'Ingrese Nombre',
                labelText: 'Nombre',
                labelStyle: TextStyle(color: Colors.black),
                focusColor: Colors.teal,
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(15)),
                  borderSide: BorderSide(
                      color: Colors.black),

                ),
              ),

              onChanged: (value) {},
            ),
          );
        });
  }

  Widget _coordenadasLongitudTextField() {
    return StreamBuilder(
        stream: null,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          return Container(
            padding: const EdgeInsets.symmetric(horizontal: 5.0),
            child: TextField(
              controller: _coordenadasLongitudController,
              keyboardType: TextInputType.text,
              decoration: const InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(15)),),
                //icon: Icon(Icons.numbers),
                hintText: 'Longitud',
                labelText: 'Longitud',
                labelStyle: TextStyle(color: Colors.black),
                focusColor: Colors.teal,
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(15)),
                  borderSide: BorderSide(
                      color: Colors.black),

                ),
              ),

              onChanged: (value) {


              },
            ),
          );
        });
  }


  Widget _coordenadasLatitudTextField() {
    return StreamBuilder(
        stream: null,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          return Container(
            padding: const EdgeInsets.symmetric(horizontal: 5.0),
            child: TextField(
              controller: _coordenadasLatitudController,
              keyboardType: TextInputType.text,
              decoration: const InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(15)),),
                //icon: Icon(Icons.numbers),
                hintText: 'Latitud',
                labelText: 'Latitud',
                labelStyle: TextStyle(color: Colors.black),
                focusColor: Colors.teal,
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(15)),
                  borderSide: BorderSide(
                      color: Colors.black),

                ),
              ),

              onChanged: (value) {},
            ),
          );
        });
  }

  Widget _botonGuardar() {
    return StreamBuilder(
      stream: null,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return GestureDetector(
          onTap: () async {
            String codigo = _codigoController.text;
            String nombre = _nombreController.text;
            String longitud = _coordenadasLongitudController.text;
            String latitud = _coordenadasLatitudController.text;

            // Crea un mapa con los datos a enviar al servidor
            Map<String, dynamic> data = {
              "cod_ubicacion": codigo,
              "nombre": nombre,
              "longitud": longitud,
              "latitud": latitud,
            };

            // Convierte el mapa a un JSON
            String jsonData = jsonEncode(data);

            // URL del endpoint
            String apiUrl = "${ApiConfig.apiUrl}api/ubicacion/crearUbicacion";

            //encabezado de autorización
            var response = await http.post(
              Uri.parse(apiUrl),
              headers: {
                "Content-Type": "application/json",
                "Authorization": "Bearer $tokenCompartido",
              },
              body: jsonData,
            );

            if (response.statusCode == 200) {
              // Si la solicitud fue exitosa
              _showNotification("Ubicación agregada con éxito.");
            } else {
              // Si la solicitud falla
              _showNotification("Error al agregar la ubicación. Código de estado: ${response
                  .statusCode}");
            }
          },
          child: Container(
            width: 80.0,
            height: 80.0,
            decoration: BoxDecoration(
              color: const Color(0xff229743),
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Center(
              child: Image.asset("assets/Iconos/guardar.png"),
            ),
          ),
        );
      },
    );
  }


  Widget _botonEliminar() {
    return StreamBuilder(
      stream: null,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return GestureDetector(
          onTap: () async {
            String id = _idController.text;

            String apiUrl = "${ApiConfig.apiUrl}api/ubicacion/eliminarUbicacion?id=$id";

            var response = await http.delete(
              Uri.parse(apiUrl),
              headers: {
                "Authorization": "Bearer $tokenCompartido",
              },
            );

            if (response.statusCode == 200) {
              _showNotification("Ubicación eliminada con éxito.");
            } else {
              _showNotification("Error al eliminar la ubicación. Código de estado: ${response.statusCode}");
            }
          },
          child: Container(
            width: 80.0,
            height: 80.0,
            decoration: BoxDecoration(
              color: const Color(0xffF02121),
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Center(
              child: Image.asset("assets/Iconos/elimina.png"),
            ),
          ),
        );
      },
    );
  }


  Widget _botonModificar() {
    return StreamBuilder(
      stream: null,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return GestureDetector(
          onTap: () async {
            String id = _idController.text;
            String codigo = _codigoController.text;
            String nombre = _nombreController.text;
            String longitud = _coordenadasLongitudController.text;
            String latitud = _coordenadasLatitudController.text;

            // Crea un mapa con los datos a enviar al servidor
            Map<String, dynamic> data = {
              "cod_ubicacion": codigo,
              "nombre": nombre,
              "longitud": longitud,
              "latitud": latitud,
            };

            // Convierte el mapa a un JSON
            String jsonData = jsonEncode(data);

            String apiUrl = "${ApiConfig.apiUrl}api/ubicacion/actualizaUbicacion?id=$id";

            // encabezado de autorización
            var response = await http.put(
              Uri.parse(apiUrl),
              headers: {
                "Content-Type": "application/json",
                "Authorization": "Bearer $tokenCompartido",
              },
              body: jsonData,
            );

            if (response.statusCode == 200) {
              // Si la solicitud fue exitosa
              _showNotification("Ubicación modificada con éxito.");
            } else {
              // Si la solicitud falla
              _showNotification("Error al modificar la ubicación. Código de estado: ${response
                  .statusCode}");
            }
          },
          child: Container(
            width: 80.0,
            height: 80.0,
            decoration: BoxDecoration(
              color: const Color(0xff290BE7), // Cambia el color de fondo
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Center(
              child: Image.asset("assets/Iconos/update.png"),
            ),
          ),
        );
      },
    );
  }


}




















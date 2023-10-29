import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:repuestos_de_carros_auto_parts/menu_lateral_admin.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'api_config.dart';



void main() {
  runApp(const MyApp());
}

//archivo aparte
class Ubicacion {
  final int idUbicacion;
  final String nombre;

  Ubicacion({required this.idUbicacion, required this.nombre});

  factory Ubicacion.fromJson(Map<String, dynamic> json) {
    return Ubicacion(
      idUbicacion: json['id_ubicacion'],
      nombre: json['nombre'],
    );
  }
}//

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
        '/': (context) =>  const NuevaSucursalPage(),
      },
    );
  }
}




class NuevaSucursalPage extends StatefulWidget {
  const NuevaSucursalPage({super.key});

  @override
  _NuevaSucursalPageState createState() => _NuevaSucursalPageState();
}

class _NuevaSucursalPageState extends State<NuevaSucursalPage> {
  final TextEditingController _idController = TextEditingController();
  final TextEditingController _codigoController = TextEditingController();
  final TextEditingController _nombreController = TextEditingController();
  List<Ubicacion> ubicaciones = [];
  String ubicacionDropdownValue = 'Seleccione Ubicación';
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
    _fetchUbicaciones();
  }

  Future<void> _fetchUbicaciones() async {
    final response =
    await http.get(Uri.parse('${ApiConfig.apiUrl}api/ubicacion/listaUbicacion'));

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      setState(() {
        ubicaciones = data.map((item) => Ubicacion.fromJson(item)).toList();
      });
    } else {
      throw Exception('Failed to load ubicaciones');
    }
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
        appBar: AppBar(title: const Text("Sucursal",
          style: TextStyle(fontSize: 30, fontWeight: FontWeight.w500),),
          centerTitle: true,),
        drawer: const MenuLateralAdmin(),
        body: SingleChildScrollView(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 30.0,),
                _idTextField(),
                const SizedBox(height: 30.0,),
                _codigoTextField(),
                const SizedBox(height: 15.0,),
                _nombreTextField(),
                const SizedBox(height: 15.0,),
                DropdownMenuUbicaciones(
                  ubicaciones: ubicaciones, // Lista de ubicaciones obtenidas de la API
                  onSelected: (int? value) {
                    setState(() {
                      ubicacionDropdownValue = value?.toString() ?? 'Seleccione Ubicación';
                    });
                  },
                ),
                const SizedBox(height: 20.0,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  // Ajusta la alineación según tus necesidades
                  children: [
                    _botonGuardar(),
                    _botonEliminar(),
                    _botonModificar(),
                  ],
                ),
                const SizedBox(height: 20.0,),
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
              //pone por defecto el teclado con arroba y demas
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
                      color: Colors.black), // Cambio de color a negro

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
              keyboardType: TextInputType.number, //pone por defecto el teclado con arroba y demas
              decoration: const InputDecoration(
                border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(15)),),
                //icon: Icon(Icons.numbers),
                hintText: 'Ingrese un Codigo',
                labelText: 'Codigo',
                labelStyle: TextStyle(color: Colors.black),
                focusColor: Colors.teal,
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(15)),
                  borderSide: BorderSide(color: Colors.black), // Cambio de color a negro

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
              keyboardType: TextInputType.text, //pone por defecto el teclado con arroba y demas
              decoration: const InputDecoration(
                border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(15))),
                //icon: Icon(Icons.numbers),
                hintText: 'Ingrese Nombre',
                labelText: 'Nombre',
                labelStyle: TextStyle(color: Colors.black),
                focusColor: Colors.teal,
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(15)),
                  borderSide: BorderSide(color: Colors.black), // Cambio de color a negro

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
            // Obtén los valores de los controladores de texto
            String codigo = _codigoController.text;
            String nombre = _nombreController.text;
            String ubicacion = ubicacionDropdownValue;

            // Crea un mapa con los datos que quieres enviar al servidor
            Map<String, dynamic> data = {
              "cod_sucursal": codigo,
              "nombre": nombre,
              "id_ubicacion": ubicacion,
              "ubicacion": {}
            };

            // Convierte el mapa a un JSON
            String jsonData = jsonEncode(data);
debugPrint("ubicacion:$jsonData");
            // URL del endpoint de la API donde deseas enviar los datos
            String apiUrl = "${ApiConfig.apiUrl}api/sucursal/crearSucursal";

            // Realiza la solicitud HTTP POST con el encabezado de autorización
            var response = await http.post(
              Uri.parse(apiUrl),
              headers: {
                "Content-Type": "application/json",
                "Authorization": "Bearer $tokenCompartido",
              },
              body: jsonData,
            );

            // Verifica el estado de la respuesta
            if (response.statusCode == 200) {
              // Si la solicitud fue exitosa, imprime la respuesta del servidor
              _showNotification("Sucursal agregada con éxito.");
            } else {
              // Si la solicitud falla, imprime el código de estado
              _showNotification("Error al agregar la Sucursal Código de estado: ${response.statusCode}");
            }
          },
          child: Container(
            width: 80.0,
            height: 80.0,
            decoration: BoxDecoration(
              color: const Color(0xff229743), // Cambia el color de fondo a verde
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
            // Obtén el ID del controlador
            String id = _idController.text;

            // URL del endpoint de la API donde deseas enviar la solicitud DELETE
            String apiUrl = "${ApiConfig.apiUrl}api/sucursal/eliminarSucursal?id=$id";
            debugPrint("IDDDDDD:$apiUrl");
            // Realiza la solicitud HTTP DELETE con el encabezado de autorización
            var response = await http.delete(
              Uri.parse(apiUrl),
              headers: {
                "Authorization": "Bearer $tokenCompartido",
              },
            );

            // Verifica el estado de la respuesta
            if (response.statusCode == 200) {
              // Si la solicitud fue exitosa, imprime la respuesta del servidor
              _showNotification("Sucursal eliminada con éxito");
            } else {
              // Si la solicitud falla, imprime el código de estado
              _showNotification("Error al eliminar la Sucursal Código de estado: ${response.statusCode}");
            }
          },
          child: Container(
            width: 80.0, // Ajusta el ancho según tus necesidades
            height: 80.0, // Ajusta el alto según tus necesidades
            decoration: BoxDecoration(
              color: const Color(0xffF02121), // Cambia el color de fondo a verde
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
            // Obtén los valores de los controladores de texto
            String id = _idController.text;
            String codigo = _codigoController.text;
            String nombre = _nombreController.text;
            String ubicacion = ubicacionDropdownValue;

            // Crea un mapa con los datos que quieres enviar al servidor
            Map<String, dynamic> data = {
              "cod_ubicacion": codigo,
              "nombre": nombre,
              "id_ubicacion": ubicacion,
              "ubicacion": {}
            };

            // Convierte el mapa a un JSON
            String jsonData = jsonEncode(data);

            // URL del endpoint de la API donde deseas enviar los datos
            String apiUrl = "${ApiConfig.apiUrl}api/sucursal/actualizaSucursal?id=$id";

            // Realiza la solicitud HTTP POST con el encabezado de autorización
            var response = await http.put(
              Uri.parse(apiUrl),
              headers: {
                "Content-Type": "application/json",
                "Authorization": "Bearer $tokenCompartido",
              },
              body: jsonData,
            );

            // Verifica el estado de la respuesta
            if (response.statusCode == 200) {
              // Si la solicitud fue exitosa, imprime la respuesta del servidor
              _showNotification("Sucursal agregada con éxito.");
            } else {
              // Si la solicitud falla, imprime el código de estado
              _showNotification("Error al agregar la Sucursal Código de estado: ${response
                  .statusCode}");
            }
          },
          child: Container(
            width: 80.0, // Ajusta el ancho según tus necesidades
            height: 80.0, // Ajusta el alto según tus necesidades
            decoration: BoxDecoration(
              color: const Color(0xff290BE7), // Cambia el color de fondo a verde
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



//const List<String> list = <String>['Seleccione Ubicación','One', 'Two', 'Three', 'Four'];
class DropdownMenuUbicaciones extends StatefulWidget {
  final List<Ubicacion> ubicaciones;
  final ValueChanged<int?> onSelected;

  const DropdownMenuUbicaciones({
    required this.ubicaciones,
    required this.onSelected,
    Key? key,
  }) : super(key: key);

  @override
  State<DropdownMenuUbicaciones> createState() => _DropdownMenuUbicacionesState();
}

class _DropdownMenuUbicacionesState extends State<DropdownMenuUbicaciones> {
  int? dropdownValue;

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<int>(
      value: dropdownValue,
      onChanged: (int? value) {
        setState(() {
          dropdownValue = value;
        });
        widget.onSelected(value);
      },
      items: [
        DropdownMenuItem<int>(
          value: null, // Indicador visual sin valor real asociado
          child: Text('Seleccione una ubicación'),
        ),
        ...widget.ubicaciones.map((Ubicacion ubicacion) {
          return DropdownMenuItem<int>(
            value: ubicacion.idUbicacion,
            child: Text(ubicacion.nombre),
          );
        }).toList(),
      ],
    );
  }
}


















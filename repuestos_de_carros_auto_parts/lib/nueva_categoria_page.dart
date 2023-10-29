import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:repuestos_de_carros_auto_parts/menu_lateral_admin.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'api_config.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Nueva Categoria',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        // This is the theme of your application.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.black38),
        useMaterial3: true,
        scaffoldBackgroundColor: const Color.fromARGB(255, 238, 238, 238),
      ),

      routes: {
        '/': (context) => const CategoriasPage(),

      },

      //home: const MyHomePage(title: 'Flutter Demoo Home Page'),
    );
  }
}


class CategoriasPage extends StatefulWidget {
  const CategoriasPage({super.key});

  @override
  _CategoriasPageState createState() => _CategoriasPageState();
}

class _CategoriasPageState extends State<CategoriasPage> {
final TextEditingController _idController = TextEditingController();
final TextEditingController _codigoController = TextEditingController();
final TextEditingController _nombreController = TextEditingController();
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
            appBar: AppBar(title: const Text("Categoría",style: TextStyle(fontSize: 30, fontWeight: FontWeight.w500),),
              centerTitle: true, ),
            drawer: const MenuLateralAdmin(), //solo agregar esta linea para agregar el menu desplegable
            body: SingleChildScrollView( //este metodo permite que el contenido sea desplazable si ocupa más espacio vertical del disponible.
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
                    const SizedBox(height: 20.0,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly, // Ajusta la alineación según tus necesidades
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
            )
        )
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
              keyboardType: TextInputType.number, //pone por defecto el teclado con arroba y demas
              decoration: const InputDecoration(
                border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(15)),),
                //icon: Icon(Icons.numbers),
                hintText: 'Id Categoria',
                labelText: 'Id',
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
              hintText: 'Codigo Rol',
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
              border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(15)),),
              //icon: Icon(Icons.numbers),
              hintText: 'Descripcion',
              labelText: 'Descripcion',
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
          // valores de los controladores de texto
          String codigo = _codigoController.text;
          String nombre = _nombreController.text;


          Map<String, dynamic> data = { // datos que quieres enviar al servidor
            "cod_categoria": codigo,
            "nombre": nombre,
          };


          String jsonData = jsonEncode(data);// Convierte el mapa a un JSON
          String apiUrl = "${ApiConfig.apiUrl}api/categoria/crearCategoria";

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
            _showNotification("Categoria agregada con éxito");
          } else {
            // Si la solicitud falla, imprime el código de estado
            _showNotification("Error al agregar la Categoria. Código de estado: ${response.statusCode}");
          }
        },
        child: Container(
          width: 80.0, // Ajusta el ancho según tus necesidades
          height: 80.0, // Ajusta el alto según tus necesidades
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
          // ID del controlador
          String id = _idController.text;

          // solicitud DELETE
          String apiUrl = "${ApiConfig.apiUrl}api/categoria/eliminarCategoria?id=$id";
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
            _showNotification("Ubicación eliminada con éxito.");
          } else {
            // Si la solicitud falla, imprime el código de estado
            _showNotification("Error al eliminar la ubicación. Código de estado: ${response.statusCode}");
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

          // Crea un mapa con los datos que quieres enviar al servidor
          Map<String, dynamic> data = {
            "cod_categoria": codigo,
            "nombre": nombre,
          };

          // Convierte el mapa a un JSON
          String jsonData = jsonEncode(data);

          // URL del endpoint de la API donde deseas enviar los datos
          String apiUrl = "${ApiConfig.apiUrl}api/categoria/actualizaCategoria?id=$id";

          //  solicitud HTTP PUT con el encabezado de autorización
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
            _showNotification("Ubicación modificada con éxito");
          } else {
            // Si la solicitud falla, imprime el código de estado
            _showNotification("Error al modificar la ubicación. Código de estado: ${response
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





















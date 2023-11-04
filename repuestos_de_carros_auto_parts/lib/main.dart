import 'package:flutter/material.dart';
import 'package:repuestos_de_carros_auto_parts/appBar.dart';
import 'package:repuestos_de_carros_auto_parts/interfaces/info_producto_page.dart';
import 'package:repuestos_de_carros_auto_parts/mapas/map_ubicaciones.dart';
import 'package:repuestos_de_carros_auto_parts/interfaces/productos_x_id_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:repuestos_de_carros_auto_parts/interfaces/login_page.dart';
import 'package:repuestos_de_carros_auto_parts/menu_lateral.dart';
import 'package:repuestos_de_carros_auto_parts/menu_lateral_admin.dart';
import 'package:repuestos_de_carros_auto_parts/mantenimientos/nueva_categoria_page.dart';
import 'package:repuestos_de_carros_auto_parts/mantenimientos/nueva_sucursal_page.dart';
import 'package:repuestos_de_carros_auto_parts/mantenimientos/nueva_ubicacion_page.dart';
import 'package:repuestos_de_carros_auto_parts/mantenimientos/nuevo_producto_page.dart';
import 'package:repuestos_de_carros_auto_parts/interfaces/productos_page.dart';
import 'package:repuestos_de_carros_auto_parts/mantenimientos/registrar_usuario_page.dart';
import 'package:repuestos_de_carros_auto_parts/interfaces/sucursales_page.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Repuestos de Carros Auto Parts',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        // This is the theme of your application.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.white),
        useMaterial3: true,
        scaffoldBackgroundColor: Colors.white,
      ),

      initialRoute: '/',
      routes: {
        '/': (context) => const MyHomePage(),
        '/registrar_usuario_page': (context) => const RegistrarPage(),
        '/login_page': (context) => const LoginPage(), //primera forma de hacerlo
        //LoginPage.id: (context) => LoginPage(), //segundo forma de hacerlo
        '/sucursales_Page': (context) => const SucursalesPage(),
        '/productos_page': (context) => const ProductosPage(),
        '/productos_x_id_page': (context) => const ProductosXID(),
        '/nuevo_producto_page': (context) => const NuevoProductoPage(),
        '/nueva_sucursal_page': (context) => const NuevaSucursalPage(),
        '/info_page': (context) => const InfoProductosPage(productoId: '123'), //necesita argumentos
        '/nueva_ubicacion_page': (context) => const UbicacionesPage(),
        '/nueva_categoria_page': (context) => const CategoriasPage(),
        '/map_ubicaciones_page': (context) => const MapUbicaciones(),
      },

      //home: const MyHomePage(title: 'Flutter Demoo Home Page'),
    );
  }
}



class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String? nombre;

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
      nombre = nombreShared;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (nombre != null && nombre!.isNotEmpty) {
      // Las variables de SharedPreferences existen, carga este código
      return SafeArea(
          child: Scaffold(
            appBar:PreferredSize(
              preferredSize: const Size.fromHeight(210.0),
              child: AppBar(
                foregroundColor: Colors.white,
                backgroundColor: const Color.fromARGB(255, 238, 238, 238),
                title: const Text(""),
                actions: const [],
                flexibleSpace: ClipRRect(
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(0.0),
                    bottomRight: Radius.circular(0.0),
                  ),
                  child: FractionallySizedBox(
                    widthFactor: 1.0, // Esto permite que la imagen ocupe todo el ancho disponible
                    child: Image.asset(
                      'assets/imagenes/logoautoparts.png',
                      fit: BoxFit.fitWidth, // Ajusta la imagen al ancho del espacio disponible
                    ),
                  ),
                ),
              ),
            ),

            drawer: const MenuLateralAdmin(),
            body:  Center(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                    child: Text("BIENVENIDO $nombre "),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [

                      Column(
                        children: [

                          const SizedBox(height: 35.0,), //espacio superior de la imagen
                          InkWell(
                            onTap: () {
                              Navigator.pushNamed(context, '/sucursales_Page'); // Navegar a la página Sucursal1
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: const BorderRadius.all(Radius.circular(34)),
                                boxShadow: [ // Agrega una sombra en la parte inferior
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.5),
                                    spreadRadius: 1,
                                    blurRadius: 2, //para neblina en los bordes
                                    offset: const Offset(0, 3),
                                  ),
                                ],
                              ),
                              padding: const EdgeInsets.all(12),
                              child: Column(
                                children: [
                                  Image.asset('assets/Iconos/tienda.png',
                                    width: 90,fit: BoxFit.cover,),
                                ],
                              ),
                            ),

                          ),
                          Container(
                            padding: const EdgeInsets.all(5.0),
                            child: const Text("SUCURSALES"),
                          )
                        ],
                      ),
                      const SizedBox(width: 20), // Espacio entre las imágenes y los textos
                      Column(
                        children: [
                          const SizedBox(height: 30.0,), //espacio superior de la imagen
                          InkWell(
                            onTap: () {
                              Navigator.pushNamed(context, '/map_ubicaciones_page'); // Navegar a la página Sucursal2
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: const BorderRadius.all(Radius.circular(34)),
                                boxShadow: [ // Agrega una sombra en la parte inferior
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.5),
                                    spreadRadius: 1,
                                    blurRadius: 2, //para neblina en los bordes
                                    offset: const Offset(0, 3),
                                  ),
                                ],
                              ),
                              padding: const EdgeInsets.all(12),
                              child: Column(
                                children: [
                                  Image.asset('assets/Iconos/ubicacion2.png',
                                    width: 90,fit: BoxFit.cover,),
                                ],
                              ),
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.all(5.0),
                            child: const Text("UBICACIONES"),
                          )
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),

          )
      );
    } else {
      // Las variables de SharedPreferences NO existen, carga este otro código
      return SafeArea(
          child: Scaffold(
            appBar: const AppBarPersonalizada(),
            drawer: const MenuLateral(),
            body:  Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    children: [
                      const SizedBox(height: 50.0,), //espacio superior de la imagen
                      InkWell(
                        onTap: () {
                          Navigator.pushNamed(context, '/sucursales_Page'); // Navegar a la página Sucursal1
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: const BorderRadius.all(Radius.circular(34)),
                            boxShadow: [ // Agrega una sombra en la parte inferior
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 1,
                                blurRadius: 2, //para neblina en los bordes
                                offset: const Offset(0, 3),
                              ),
                            ],
                          ),
                          padding: const EdgeInsets.all(12),
                          child: Column(
                            children: [
                              Image.asset('assets/Iconos/tienda.png',
                                width: 90,fit: BoxFit.cover,),
                            ],
                          ),
                        ),

                      ),
                      Container(
                        padding: const EdgeInsets.all(5.0),
                        child: const Text("SUCURSALES"),
                      )
                    ],
                  ),
                  const SizedBox(width: 20), // Espacio entre las imágenes y los textos
                  Column(
                    children: [
                      const SizedBox(height: 50.0,), //espacio superior de la imagen
                      InkWell(
                        onTap: () {
                          Navigator.pushNamed(context, '/map_ubicaciones_page'); // Navegar a la página Sucursal2
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: const BorderRadius.all(Radius.circular(34)),
                            boxShadow: [ // Agrega una sombra en la parte inferior
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 1,
                                blurRadius: 2, //para neblina en los bordes
                                offset: const Offset(0, 3),
                              ),
                            ],
                          ),
                          padding: const EdgeInsets.all(12),
                          child: Column(
                            children: [
                              Image.asset('assets/Iconos/ubicacion2.png',
                                width: 90,fit: BoxFit.cover,),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.all(5.0),
                        child: const Text("UBICACIONES"),
                      )
                    ],
                  ),
                ],
              ),
            ),

          )
      );
    }
  }
}












Widget getCardItem() {
  return Center(
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: 100,
        width: 105,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 5,
              blurRadius: 7,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  child: const Icon(Icons.supervisor_account,
                      size: 24, color: Colors.blueAccent),
                ),
                Container(
                  padding: const EdgeInsets.all(12),
                  child: const Text(
                    "2100",
                    style: TextStyle(
                      color: Colors.blueAccent,
                    ),
                  ),
                ),
              ],
            ),
            Container(
              decoration: const BoxDecoration(
                  color: Colors.blueAccent,
                  borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(12),
                      bottomLeft: Radius.circular(12))),
              padding: const EdgeInsets.all(12),
              child: const Text("Student"),
            )
          ],
        ),
      ),
    ),
  );
}


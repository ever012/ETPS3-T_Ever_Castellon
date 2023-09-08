import 'package:flutter/material.dart';
import 'package:repuestos_de_carros_auto_parts/appBar.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:repuestos_de_carros_auto_parts/login_page.dart';
import 'package:repuestos_de_carros_auto_parts/menu_lateral.dart';
import 'package:repuestos_de_carros_auto_parts/menu_lateral_admin.dart';
import 'package:repuestos_de_carros_auto_parts/nueva_categoria_page.dart';
import 'package:repuestos_de_carros_auto_parts/nueva_sucursal_page.dart';
import 'package:repuestos_de_carros_auto_parts/nueva_ubicacion_page.dart';
import 'package:repuestos_de_carros_auto_parts/nuevo_producto_page.dart';
import 'package:repuestos_de_carros_auto_parts/productos_page.dart';
import 'package:repuestos_de_carros_auto_parts/nuevos_roles_page.dart';
import 'package:repuestos_de_carros_auto_parts/registrar_usuario_page.dart';
import 'package:repuestos_de_carros_auto_parts/sucursales_page.dart';
import 'package:repuestos_de_carros_auto_parts/nueva_ubicacion_page.dart';
import 'package:repuestos_de_carros_auto_parts/usuarios_page.dart';
import 'info_producto_page.dart';


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
        '/productos_page': (context) => const ProductosPage(), //sucursal especifica
        //'/Todos_productos_page': (context) => const TodosProductosPage(), //todos los que existan
        '/nuevo_producto_page': (context) => const NuevoProductoPage(), //quitar al terminar
        '/nueva_sucursal_page': (context) => const NuevaSucursalPage(), //quitar al terminar
        '/ubicaciones_page': (context) => const UbicacionesPage(), //quitar al terminar
        '/roles_page': (context) => const RolesPage(), //quitar al terminar
        '/usuarios_page': (context) => const UsuariosPage(),
        '/info_page': (context) => InfoProductosPage(), //necesita argumentos
        '/nueva_ubicacion_page': (context) => const UbicacionesPage(),
        '/nueva_categoria_page': (context) => const RegistrarPage(),
      },

      //home: const MyHomePage(title: 'Flutter Demoo Home Page'),
    );
  }
}



class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key});

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
    final int? idShared = prefs.getInt('id');
    final String? nombreShared = prefs.getString('nombre');

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
                actions: [],
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
                                borderRadius: BorderRadius.all(Radius.circular(34)),
                                boxShadow: [ // Agrega una sombra en la parte inferior
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.5),
                                    spreadRadius: 1,
                                    blurRadius: 2, //para neblina en los bordes
                                    offset: Offset(0, 3),
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
                            child: Text("SUCURSALES"),
                          )
                        ],
                      ),
                      const SizedBox(width: 20), // Espacio entre las imágenes y los textos
                      Column(
                        children: [
                          const SizedBox(height: 30.0,), //espacio superior de la imagen
                          InkWell(
                            onTap: () {
                              //Navigator.pushNamed(context, '/ubicaciones'); // Navegar a la página Sucursal2
                              debugPrint("imagen ubicaciones presionado");
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.all(Radius.circular(34)),
                                boxShadow: [ // Agrega una sombra en la parte inferior
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.5),
                                    spreadRadius: 1,
                                    blurRadius: 2, //para neblina en los bordes
                                    offset: Offset(0, 3),
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
                            child: Text("UBICACIONES"),
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
            appBar: AppBarPersonalizada(),
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
                            borderRadius: BorderRadius.all(Radius.circular(34)),
                            boxShadow: [ // Agrega una sombra en la parte inferior
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 1,
                                blurRadius: 2, //para neblina en los bordes
                                offset: Offset(0, 3),
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
                        child: Text("SUCURSALES"),
                      )
                    ],
                  ),
                  const SizedBox(width: 20), // Espacio entre las imágenes y los textos
                  Column(
                    children: [
                      const SizedBox(height: 50.0,), //espacio superior de la imagen
                      InkWell(
                        onTap: () {
                          //Navigator.pushNamed(context, '/ubicaciones'); // Navegar a la página Sucursal2
                          debugPrint("imagen ubicaciones presionado");
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.all(Radius.circular(34)),
                            boxShadow: [ // Agrega una sombra en la parte inferior
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 1,
                                blurRadius: 2, //para neblina en los bordes
                                offset: Offset(0, 3),
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
                        child: Text("UBICACIONES"),
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
              offset: Offset(0, 3),
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
                  child: Icon(Icons.supervisor_account,
                      size: 24, color: Colors.blueAccent),
                  padding: const EdgeInsets.all(12),
                ),
                Container(
                  child: Text(
                    "2100",
                    style: TextStyle(
                      color: Colors.blueAccent,
                    ),
                  ),
                  padding: const EdgeInsets.all(12),
                ),
              ],
            ),
            Container(
              decoration: const BoxDecoration(
                  color: Colors.blueAccent,
                  borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(12),
                      bottomLeft: Radius.circular(12))),
              child: Text("Student"),
              padding: const EdgeInsets.all(12),
            )
          ],
        ),
      ),
    ),
  );
}


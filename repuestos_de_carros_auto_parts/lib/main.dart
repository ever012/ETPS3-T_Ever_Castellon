import 'package:flutter/material.dart';
import 'package:repuestos_de_carros_auto_parts/login_page.dart';
import 'package:repuestos_de_carros_auto_parts/menu_lateral_admin.dart';
import 'package:repuestos_de_carros_auto_parts/nueva_sucursal_page.dart';
import 'package:repuestos_de_carros_auto_parts/nuevo_producto_page.dart';
import 'package:repuestos_de_carros_auto_parts/productos_page.dart';
import 'package:repuestos_de_carros_auto_parts/roles_page.dart';
import 'package:repuestos_de_carros_auto_parts/sucursales_page.dart';
import 'package:repuestos_de_carros_auto_parts/ubicaciones_page.dart';
import 'package:repuestos_de_carros_auto_parts/usuarios_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Repuestos de Carros Auto Parts',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        // This is the theme of your application.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.black38),
        useMaterial3: true,
        scaffoldBackgroundColor: const Color.fromARGB(255, 238, 238, 238),
      ),

      initialRoute: '/nuevo_producto_page',
      routes: {
        '/': (context) => const MyHomePage(),
        '/login_page': (context) => const LoginPage(), //primera forma de hacerlo
        //LoginPage.id: (context) => LoginPage(), //segundo forma de hacerlo
        '/sucursales_Page': (context) => const SucursalesPage(),
        '/productos_page': (context) => const ProductosPage(), //necesita recibir parametros de "sucursales_page"
        '/nuevo_producto_page': (context) => const NuevoProductoPage(), //quitar al terminar
        '/nueva_sucursal_page': (context) => const NuevaSucursalPage(), //quitar al terminar
        '/ubicaciones_page': (context) => const UbicacionesPage(), //quitar al terminar
        '/roles_page': (context) => const RolesPage(), //quitar al terminar
        '/usuarios_page': (context) => const UsuariosPage(), //quitar al terminar
      },

      //home: const MyHomePage(title: 'Flutter Demoo Home Page'),
    );
  }
}





class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(210.0),
            child: AppBar(
              foregroundColor: Colors.white,
              backgroundColor: const Color.fromARGB(255, 238, 238, 238),
              title: const Text(""),
              actions: [
                IconButton(
                  icon: const Icon(Icons.person, size: 40.0,),
                  onPressed: () {
                    // Aquí agregar la funcionalidad del botón de usuario
                    Navigator.pushNamed(context, '/login_page');
                  },
                ),
              ],
              flexibleSpace: ClipRRect(
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(30.0),
                  bottomRight: Radius.circular(30.0),
                ),
                child: Stack(
                  children: [
                    Positioned(
                      top: 0,
                      left: -4,
                      child: Image.asset(
                        'assets/imagenes/logoautoparts.png',
                        width: 370.0,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          drawer: const MenuLateralAdmin(),
          body: Center(
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
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                        padding: const EdgeInsets.all(12),
                        child: Column(
                          children: [
                            Image.asset('assets/imagenes/tienda_1.png'),
                            const Text("SUCURSALES"),
                          ],
                        ),
                      ),
                    ),
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
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                        padding: const EdgeInsets.all(12),
                        child: Column(
                          children: [
                            Image.asset('assets/imagenes/tienda_1.png'),
                            const Text("UBICACIONES"),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

        )
    );

  }
}






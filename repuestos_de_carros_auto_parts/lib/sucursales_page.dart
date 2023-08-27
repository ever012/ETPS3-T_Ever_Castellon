import 'package:flutter/material.dart';
import 'package:repuestos_de_carros_auto_parts/productos_page.dart';
import 'menu_lateral.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        // This is the theme of your application.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.black38),
        useMaterial3: true,
        scaffoldBackgroundColor: Color.fromARGB(255, 238, 238, 238),
      ),

      routes: {
        '/': (context) => SucursalesPage(),
        '/productos_page': (context) => ProductosPage(),
      },

      //home: const MyHomePage(title: 'Flutter Demoo Home Page'),
    );
  }
}












class SucursalesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
    preferredSize: Size.fromHeight(210.0),
    child: AppBar(
    foregroundColor: Colors.white,
    backgroundColor: Color.fromARGB(255, 238, 238, 238),
    title: Text(""),
    actions: [
    IconButton(
    icon: Icon(Icons.person, size: 40.0,),
    onPressed: () {
    // Aquí agregar la funcionalidad del botón de usuario
    Navigator.pushNamed(context, '/login_page');
    },
    ),
    ],
    flexibleSpace: Stack(
    children: [
    Positioned(
    top: 0,
    left: -4,
    child: Image.asset(
    'assets/imagenes/logo_1.png',
    width: 370.0,
    fit: BoxFit.cover,
    ),
    ),
    ],
    ),
    ),
    ),
      drawer: MenuLateral(), //solo agregar esta linea para agregar el menu desplegable
      body: SingleChildScrollView( //este metodo permite que el contenido sea desplazable si ocupa más espacio vertical del disponible.
      child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CardSucursal(imagen: "assets/imagenes/tienda_1.png", texto: "SUCURSAL ESCALON",),
              CardSucursal(imagen: "assets/imagenes/tienda_1.png", texto: "SUCURSAL MERLIOT",),
              CardSucursal(imagen: "assets/imagenes/tienda_1.png", texto: "SUCURSAL 29 AV",),
              CardSucursal(imagen: "assets/imagenes/tienda_1.png", texto: "S. SANTA TECLA",),
              CardSucursal(imagen: "assets/imagenes/tienda_1.png", texto: "S. SANTA TECLA",),
            ],
          ),
        ),
      )
    );
  }
}


class CardSucursal extends StatelessWidget {
  final String imagen;
  final String texto;

  CardSucursal({String? imagen, String? texto})  //en caso de no introducir los parametros
      : imagen = imagen ?? "assets/imagenes/tienda_1.png", //valor por de
        texto = texto ?? "TEXTO LEATORIO";

  @override
  Widget build(BuildContext context) {
    return Card(color: Color.fromARGB(255, 159, 172, 176),
      clipBehavior: Clip.hardEdge,
      child: InkWell(
        splashColor: Color.fromARGB(255, 71, 73, 73),
        onTap: () {
          Navigator.pushNamed(context, "/productos_page", arguments: {'sucursal': texto, });
        },
        child: SizedBox(
          width: 300,
          height: 100,
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Image.asset(imagen, width: 80, height: 80),
              ),
              Text(texto, style: TextStyle(fontSize: 20.0),),
            ],
          ),
        ),
      ),
    );
  }
}





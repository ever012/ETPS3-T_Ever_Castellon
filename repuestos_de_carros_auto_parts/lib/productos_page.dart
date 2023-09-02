import 'package:flutter/material.dart';
import 'package:repuestos_de_carros_auto_parts/menu_lateral.dart';


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
        scaffoldBackgroundColor: const Color.fromARGB(255, 238, 238, 238),
      ),

      routes: {
        '/': (context) => const ProductosPage(),

      },

      //home: const MyHomePage(title: 'Flutter Demoo Home Page'),
    );
  }
}








class ProductosPage extends StatelessWidget {
  const ProductosPage({super.key});

  @override
  Widget build(BuildContext context) {


    Map<dynamic, dynamic>? parametros = ModalRoute.of(context)?.settings.arguments as Map<dynamic, dynamic>?; //obtener todos los argumentos
    // Comprueba si los argumentos son no nulos y del tipo esperado
    if (parametros != null && parametros.containsKey('sucursal')) {
      final String sucursal = parametros['sucursal'] as String;
    return SafeArea(
          child: Scaffold(
              appBar: AppBar(),
              drawer: const MenuLateral(), //solo agregar esta linea para agregar el menu desplegable
              body: SingleChildScrollView( //este metodo permite que el contenido sea desplazable si ocupa más espacio vertical del disponible.
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Productos $sucursal"),
                      const Divider(
                        height: 20,
                        thickness: 5,
                        indent: 20,
                        endIndent: 10,
                        color: Colors.black,
                      ),
                      const CardSucursal(imagen: "assets/imagenes/tienda_1.png",texto: "NOMBRE PRODUCTO",descripcion: "descripcion del producto", precio: "10.50"),
                      const CardSucursal(imagen: "assets/imagenes/tienda_1.png",texto: "NOMBRE PRODUCTO2",descripcion: "descripcion del producto", precio: "10.50"),
                      const CardSucursal(imagen: "assets/imagenes/tienda_1.png",texto: "NOMBRE PRODUCTO3",descripcion: "descripcion del producto", precio: "10.50"),
                      const CardSucursal(imagen: "assets/imagenes/tienda_1.png",texto: "NOMBRE PRODUCTO4",descripcion: "descripcion del producto", precio: "10.50"),
                      const CardSucursal(imagen: "assets/imagenes/tienda_1.png",texto: "NOMBRE PRODUCTO5",descripcion: "descripcion del producto", precio: "10.50"),
                      const CardSucursal(imagen: "assets/imagenes/tienda_1.png",texto: "NOMBRE PRODUCTO6",descripcion: "descripcion del producto", precio: "10.50"),
                      const CardSucursal(imagen: "assets/imagenes/tienda_1.png",texto: "NOMBRE PRODUCTO7",descripcion: "descripcion del producto", precio: "10.50"),
                      const CardSucursal(imagen: "assets/imagenes/tienda_1.png",texto: "NOMBRE PRODUCTO8",descripcion: "descripcion del producto", precio: "10.50"),
                      const CardSucursal(imagen: "assets/imagenes/tienda_1.png",texto: "NOMBRE PRODUCTO9",descripcion: "descripcion del producto", precio: "10.50"),
                      const CardSucursal(imagen: "assets/imagenes/tienda_1.png",texto: "NOMBRE PRODUCTO10",descripcion: "descripcion del producto", precio: "10.50"),


                    ],
                  ),
                ),
              )
          )
    );


    }else {
      // En caso de que los argumentos no sean válidos, muestra un mensaje de error o regresa a la página anterior
      return SafeArea(
          child: Scaffold(
            appBar: AppBar(title: const Text('Error')),
            body: const Center(
              child: Text('Error al recibir los argumentos'),

            ),
          )
      );

    }
  }
}




class CardSucursal extends StatelessWidget {
  final String imagen;
  final String texto;
  final String descripcion;
  final String precio;

  const CardSucursal({super.key, String? imagen, String? texto, String? descripcion, String? precio})  //en caso de no introducir los parametros
      : imagen = imagen ?? "assets/imagenes/tienda_1.png", //valor por de
        texto = texto ?? "TEXTO LEATORIO",
        descripcion = descripcion ?? "0",
        precio = precio ?? "0";

  @override
  Widget build(BuildContext context) {
    return Card(

      // Con esta propiedad modificamos la forma de nuestro card
      // Aqui utilizo RoundedRectangleBorder para proporcionarle esquinas circulares al Card
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),

      // Con esta propiedad agregamos margen a nuestro Card
      // El margen es la separación entre widgets o entre los bordes del widget padre e hijo
      margin: const EdgeInsets.all(15),

      // Con esta propiedad agregamos elevación a nuestro card
      // La sombra que tiene el Card aumentará
      elevation: 10,

    // Envolver el contenido de la Card con InkWell para detectar el clic
      child: InkWell(
        splashColor: const Color.fromARGB(255, 71, 73, 73),
        onTap: () {
          debugPrint('se abre el google maps 😀');
        },
        child: SizedBox(
          width: 300,
          child: Column(
            children: <Widget>[

              // Usamos ListTile para ordenar la información del card como titulo, subtitulo e icono
              ListTile(
                contentPadding: const EdgeInsets.fromLTRB(1, 1, 5, 0),
                title: const Text('Nombre Producto'),
                subtitle: Text(descripcion),
                leading: Image.asset(imagen),
              ),

              // Usamos una fila para ordenar los botones del card
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Text('\$$precio', style: const TextStyle(fontSize: 24.0)),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}






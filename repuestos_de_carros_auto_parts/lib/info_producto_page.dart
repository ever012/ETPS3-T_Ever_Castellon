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
        scaffoldBackgroundColor: Color.fromARGB(255, 238, 238, 238),
      ),

      routes: {
        '/': (context) => InfoProductosPage(),

      },

      //home: const MyHomePage(title: 'Flutter Demoo Home Page'),
    );
  }
}


class InfoProductosPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {


    Map<dynamic, dynamic>? parametros = ModalRoute.of(context)?.settings.arguments as Map<dynamic, dynamic>?; //obtener todos los argumentos
    // Comprueba si los argumentos son no nulos y del tipo esperado
    if (parametros != null && parametros.containsKey('id') && parametros.containsKey('nombre') && parametros.containsKey('precio')) {
      final String id = parametros['id'] as String;
      final String nombre = parametros['nombre'] as String;
      final String precio = parametros['precio'] as String;
      return Scaffold(
          appBar: AppBar(),
          drawer: const MenuLateral(), //solo agregar esta linea para agregar el menu desplegable
          body: SingleChildScrollView( //este metodo permite que el contenido sea desplazable si ocupa más espacio vertical del disponible.
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 350,
                    decoration: BoxDecoration(
                      color: Color(0xffECF5F8),
                      border: Border.all(color: Color(0xff223335)),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 15.0,vertical: 5.0), // Espacio alrededor del texto
                      child: const Text("Informacion General",
                        style: TextStyle(
                          fontSize: 24.0,
                          color: Color(0xffD64747), // Texto en color blanco
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
              InkWell(
                onTap: () {debugPrint("redirige al google maps 😀");},
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20.0),
                  child: Image.asset('assets/Iconos/imagen_uno.png',
                      width: 310.0, height: 310.0),
                ),
              ),
                  const SizedBox(height: 10),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 0),
                      child: Text(nombre,style: TextStyle(fontSize: 24),),
                    ),
                  ),
                  const Divider(
                    height: 10,
                    thickness: 1,
                    indent: 10,
                    endIndent: 10,
                    color: Colors.black,
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(20, 8, 0, 0),//left, top, right, bottom
                      child: Text("\$$precio",style: TextStyle(fontSize: 24,color: Color(0xffD64747)),),
                    ),
                  ),
                  const Divider(
                    height: 10,
                    thickness: 1,
                    indent: 10,
                    endIndent: 10,
                    color: Colors.black,
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 0),
                      child: Text("DESCRIPCIÓN",style: TextStyle(fontSize: 24,color: Color(0xff95A4BB)),),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 8),
                    child: Text("La función del filtro de combustible en motores que funcionan con gasolina es distinta a la de los que lo hacen con diésel. No obstante, en cualquiera de los dos casos actúa como barrera para que las impurezas lleguen al circuito de inyección, a la bomba de presión, a los inyectores o al circuito de alimentación.",
                      style: TextStyle(fontSize: 15,color: Color(0xff95A4BB)),),
                  )
                ],
              ),

            ),
          )
      );

    }else {
      // En caso de que los argumentos no sean válidos, muestra un mensaje de error o regresa a la página anterior
      return Scaffold(
        appBar: AppBar(title: Text('Error')),
        body: Center(
          child: Text('Error al recibir los argumentos'),

        ),
      );
    }
  }
}




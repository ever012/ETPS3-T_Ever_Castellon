import 'package:flutter/material.dart';
import 'package:repuestos_de_carros_auto_parts/menu_lateral.dart';
import 'package:repuestos_de_carros_auto_parts/menu_lateral_admin.dart';


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
        '/': (context) => const UbicacionesPage(),

      },

      //home: const MyHomePage(title: 'Flutter Demoo Home Page'),
    );
  }
}


class UbicacionesPage extends StatelessWidget {
  const UbicacionesPage({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController _codigoController = TextEditingController();
    final TextEditingController _nombreController = TextEditingController();
    final TextEditingController _coordenadasController = TextEditingController();

    return SafeArea(
        child: Scaffold(
            appBar: AppBar(title: const Text("Ubicaciones",style: TextStyle(fontSize: 30, fontWeight: FontWeight.w500),),
              centerTitle: true, ),
            drawer: const MenuLateralAdmin(), //solo agregar esta linea para agregar el menu desplegable
            body: SingleChildScrollView( //este metodo permite que el contenido sea desplazable si ocupa más espacio vertical del disponible.
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(height: 30.0,),
                    _codigoTextField(),
                    const SizedBox(height: 15.0,),
                    _nombreTextField(),
                    const SizedBox(height: 15.0,),
                    _coordenadasTextField(),
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
}



Widget _codigoTextField() {
  return StreamBuilder(
      stream: null,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 5.0),
          child: TextField(
            //controller: _codigoController,
            keyboardType: TextInputType.number, //pone por defecto el teclado con arroba y demas
            decoration: const InputDecoration(
              border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(15)),),
              //icon: Icon(Icons.numbers),
              hintText: 'Codigo Ubicacion',
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
            //controller: _nombreController,
            keyboardType: TextInputType.text, //pone por defecto el teclado con arroba y demas
            decoration: const InputDecoration(
              border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(15)),),
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

Widget _coordenadasTextField() {
  return StreamBuilder(
      stream: null,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 5.0),
          child: TextField(
            //controller: _coordenadasController,
            keyboardType: TextInputType.text, //pone por defecto el teclado con arroba y demas
            decoration: const InputDecoration(
              border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(15)),),
              //icon: Icon(Icons.numbers),
              hintText: 'Coordenadas',
              labelText: 'Coordenadas',
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
        onTap: () {
          print("Me oprimiste ✅");
        },
        child: Container(
          width: 80.0, // Ajusta el ancho según tus necesidades
          height: 80.0, // Ajusta el alto según tus necesidades
          decoration: BoxDecoration(
            color: Color(0xff229743), // Cambia el color de fondo a verde
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
        onTap: () {
          print("se elimino ❌");
        },
        child: Container(
          width: 80.0, // Ajusta el ancho según tus necesidades
          height: 80.0, // Ajusta el alto según tus necesidades
          decoration: BoxDecoration(
            color: Color(0xffF02121), // Cambia el color de fondo a verde
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
        onTap: () {
          print("se modifico 🔄");
        },
        child: Container(
          width: 80.0, // Ajusta el ancho según tus necesidades
          height: 80.0, // Ajusta el alto según tus necesidades
          decoration: BoxDecoration(
            color: Color(0xff290BE7), // Cambia el color de fondo a verde
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

























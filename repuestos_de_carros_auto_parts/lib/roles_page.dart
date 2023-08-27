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
        '/': (context) => RolesPage(),

      },

      //home: const MyHomePage(title: 'Flutter Demoo Home Page'),
    );
  }
}


class RolesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final TextEditingController _codigoController = TextEditingController();
    final TextEditingController _descripcionController = TextEditingController();
    final TextEditingController _rolController = TextEditingController();

    return Scaffold(
        appBar: AppBar(),
        drawer: MenuLateral(), //solo agregar esta linea para agregar el menu desplegable
        body: SingleChildScrollView( //este metodo permite que el contenido sea desplazable si ocupa más espacio vertical del disponible.
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Align(
                  alignment: Alignment.bottomLeft, // Alinea el texto a la izquierda
                  child: Text("   roles..", style: TextStyle(fontSize: 24, color: Colors.red),),
                ),
                const Divider(
                  height: 20,
                  thickness: 5,
                  indent: 20,
                  endIndent: 10,
                  color: Colors.grey,
                ),
                _codigoTextField(),
                SizedBox(height: 15.0,),
                _rolTextField(),
                SizedBox(height: 15.0,),
                _descripcionTextField(),
                SizedBox(height: 15.0,),
                _botonGuardar(),
                SizedBox(height: 15.0,),
                _botonEliminar(),
                SizedBox(height: 15.0,),
                _botonModificar(),
                SizedBox(height: 15.0,),
              ],
            ),
          ),
        )
    );


  }
}



Widget _codigoTextField() {
  return StreamBuilder(
      stream: null,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 5.0),
          child: TextField(
            //controller: _codigoController,
            keyboardType: TextInputType.number, //pone por defecto el teclado con arroba y demas
            decoration: InputDecoration(
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

Widget _descripcionTextField() {
  return StreamBuilder(
      stream: null,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 5.0),
          child: TextField(
            //controller: _descripcionController,
            keyboardType: TextInputType.text, //pone por defecto el teclado con arroba y demas
            decoration: InputDecoration(
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

Widget _rolTextField() {
  return StreamBuilder(
      stream: null,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 5.0),
          child: TextField(
            //controller: _rolController,
            keyboardType: TextInputType.text, //pone por defecto el teclado con arroba y demas
            decoration: InputDecoration(
              border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(15)),),
              //icon: Icon(Icons.numbers),
              hintText: 'Ingrese Rol',
              labelText: 'Rol',
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
        final ButtonStyle raisedButtonStyle = ElevatedButton.styleFrom(
          backgroundColor: Color.fromARGB(255, 39, 83, 89),
          foregroundColor: Colors.white,
          minimumSize: Size(88, 36),
          padding: EdgeInsets.symmetric(horizontal: 16),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(30)),
          ),
          elevation: 10.0, //da como un sombredado al boton
        );

        return ElevatedButton(
          style: raisedButtonStyle,
          onPressed: (){
            debugPrint("se guardo ✅");
          },
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 80.0, vertical: 15.0),
            child: Text(
              'GUARDAR',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        );
      });
}

Widget _botonEliminar() {
  return StreamBuilder(
      stream: null,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        final ButtonStyle raisedButtonStyle = ElevatedButton.styleFrom(
          backgroundColor: Color.fromARGB(255, 39, 83, 89),
          foregroundColor: Colors.white,
          minimumSize: Size(88, 36),
          padding: EdgeInsets.symmetric(horizontal: 16),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(30)),
          ),
          elevation: 10.0, //da como un sombredado al boton
        );

        return ElevatedButton(
          style: raisedButtonStyle,
          onPressed: (){
            debugPrint("se elimino ❌");
          },
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 80.0, vertical: 15.0),
            child: Text(
              'ELIMINAR',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        );
      });
}


Widget _botonModificar() {
  return StreamBuilder(
      stream: null,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        final ButtonStyle raisedButtonStyle = ElevatedButton.styleFrom(
          backgroundColor: Color.fromARGB(255, 39, 83, 89),
          foregroundColor: Colors.white,
          minimumSize: Size(88, 36),
          padding: EdgeInsets.symmetric(horizontal: 16),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(30)),
          ),
          elevation: 10.0, //da como un sombredado al boton
        );

        return ElevatedButton(
          style: raisedButtonStyle,
          onPressed: (){
            debugPrint("se modifico 🔄");
          },
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 80.0, vertical: 15.0),
            child: Text(
              'MODIFICAR',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        );
      });
}

























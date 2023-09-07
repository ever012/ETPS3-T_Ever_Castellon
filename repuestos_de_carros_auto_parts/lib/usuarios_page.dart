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
      title: 'Nuevo Usuario',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        // This is the theme of your application.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.black38),
        useMaterial3: true,
        scaffoldBackgroundColor: const Color.fromARGB(255, 238, 238, 238),
      ),

      routes: {
        '/': (context) => const UsuariosPage(),

      },

      //home: const MyHomePage(title: 'Flutter Demoo Home Page'),
    );
  }
}


class UsuariosPage extends StatelessWidget {
  const UsuariosPage({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController codigoController = TextEditingController();
    final TextEditingController correoController = TextEditingController();
    final TextEditingController contraseniaController = TextEditingController();
    final TextEditingController repetirContraseniaController = TextEditingController();


    return SafeArea(
        child: Scaffold(
            appBar: AppBar(title: const Text("Usuario",style: TextStyle(fontSize: 30, fontWeight: FontWeight.w500),),
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
                    _usuarioTextField(),
                    const SizedBox(height: 15.0,),

                    _correoTextField(),
                    const SizedBox(height: 15.0,),
                    _contraseniaTextField(),
                    const SizedBox(height: 15.0,),
                    _repetirContraseniaTextField(),
                    const SizedBox(height: 15.0,),
                    const DropdownMenuRol(),
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
            keyboardType: TextInputType.number,
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


Widget _usuarioTextField() {
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
              hintText: 'nombre usuario',
              labelText: 'Usuario',
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




Widget _correoTextField() {
  return StreamBuilder(
      stream: null,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 5.0),
          child: TextField(
            //controller: _correoController,
            keyboardType: TextInputType.emailAddress, //pone por defecto el teclado con arroba y demas
            decoration: const InputDecoration(
              border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(15))),
              //icon: Icon(Icons.numbers),
              hintText: 'Correo',
              labelText: 'Correo',
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


Widget _contraseniaTextField() {
  return StreamBuilder(
      stream: null,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 5.0),
          child: TextField(
            //controller: _contraseniaController,
            keyboardType: TextInputType.text,
            //obscureText: true, //hace que la contraseña se vea ****
            decoration: const InputDecoration(
              border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(15)),),
              //icon: Icon(Icons.numbers),
              hintText: 'Contraseña',
              labelText: 'Contraseña',
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

Widget _repetirContraseniaTextField() {
  return StreamBuilder(
      stream: null,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 5.0),
          child: TextField(
            //controller: _repetirContraseniaController,
            keyboardType: TextInputType.text,
            decoration: const InputDecoration(
              border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(15)),),
              //icon: Icon(Icons.numbers),
              hintText: 'Confirmar Contraseña',
              labelText: 'Confirmar Contraseña',
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


const List<String> list = <String>['Seleccione Rol','One', 'Two', 'Three', 'Four'];
class DropdownMenuRol extends StatefulWidget {
  const DropdownMenuRol({super.key});

  @override
  State<DropdownMenuRol> createState() => _DropdownMenuRolState();
}

class _DropdownMenuRolState extends State<DropdownMenuRol> {
  String dropdownValue = list.first;

  @override
  Widget build(BuildContext context) {
    return DropdownMenu<String>(
      initialSelection: list.first,
      onSelected: (String? value) {
        // This is called when the user selects an item.
        setState(() {
          dropdownValue = value!;
        });
      },
      dropdownMenuEntries: list.map<DropdownMenuEntry<String>>((String value) {
        return DropdownMenuEntry<String>(value: value, label: value);
      }).toList(),
      width: 350,
    );
  }
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

























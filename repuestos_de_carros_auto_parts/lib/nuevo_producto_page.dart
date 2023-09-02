import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
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
        '/': (context) => const NuevoProductoPage(),

      },

      //home: const MyHomePage(title: 'Flutter Demoo Home Page'),
    );
  }
}


class NuevoProductoPage extends StatelessWidget {
  const NuevoProductoPage({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController codigoController = TextEditingController();
    final TextEditingController nombreController = TextEditingController();
    final TextEditingController descripcionController = TextEditingController();
    final TextEditingController precioController = TextEditingController();
    final String imagePath = "";

      return SafeArea(
        child: Scaffold(
            appBar: AppBar(),
            drawer: const MenuLateral(), //solo agregar esta linea para agregar el menu desplegable
            body: SingleChildScrollView( //este metodo permite que el contenido sea desplazable si ocupa más espacio vertical del disponible.
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Align(
                      alignment: Alignment.bottomLeft, // Alinea el texto a la izquierda
                      child: Text("   Nuevos Productos", style: TextStyle(fontSize: 24, color: Colors.red),),
                    ),
                    const Divider(
                      height: 20,
                      thickness: 5,
                      indent: 20,
                      endIndent: 10,
                      color: Colors.grey,
                    ),
                    _codigoTextField(),
                    const SizedBox(height: 15.0,),
                    _nombreTextField(),
                    const SizedBox(height: 15.0,),
                    _descripcionTextField(),
                    const SizedBox(height: 15.0,),
                    _precioTextField(),
                    const SizedBox(height: 15.0,),
                    _imagenImagePicker(),
                    const SizedBox(height: 20.0,),
                    const DropdownMenuExample(),
                    const SizedBox(height: 15.0,),
                    _botonGuardar(),
                    const SizedBox(height: 15.0,),
                    _botonEliminar(),
                    const SizedBox(height: 15.0,),
                    _botonModificar(),
                    const SizedBox(height: 15.0,),
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
              border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(15))),
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


Widget _descripcionTextField() {
  return StreamBuilder(
      stream: null,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 5.0),
          child: TextField(
            //controller: _descripcionController,
            keyboardType: TextInputType.text, //pone por defecto el teclado con arroba y demas
            decoration: const InputDecoration(
              border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(15)),),
              //icon: Icon(Icons.numbers),
              hintText: 'Ingrese Descripcion',
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

Widget _precioTextField() {
  return StreamBuilder(
      stream: null,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 5.0),
          child: TextField(
            //controller: _precioController,
            keyboardType: TextInputType.text, //pone por defecto el teclado con arroba y demas
            decoration: const InputDecoration(
              border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(15)),),
              //icon: Icon(Icons.numbers),
              hintText: 'Ingrese Precio',
              labelText: 'Precio',
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


const List<String> list = <String>['Seleccione Sucursal','One', 'Two', 'Three', 'Four'];
class DropdownMenuExample extends StatefulWidget {
  const DropdownMenuExample({super.key});

  @override
  State<DropdownMenuExample> createState() => _DropdownMenuExampleState();
}

class _DropdownMenuExampleState extends State<DropdownMenuExample> {
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







class _imagenImagePicker extends StatefulWidget {
  @override
  _ImagePickerWidgetState createState() => _ImagePickerWidgetState();
}

class _ImagePickerWidgetState extends State<_imagenImagePicker> {
  String? imagePath_;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 5.0),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            const Text("Seleccione imagen: "),
            (imagePath_ == null) ? Container() : Image.file(File(imagePath_!)),
            ElevatedButton(
              child: const Text("Cargar imagen"),
              onPressed: () async {
                final ImagePicker _picker = ImagePicker();
                XFile? _pickedFile =
                await _picker.pickImage(source: ImageSource.gallery);
                if (_pickedFile != null) {
                  setState(() {
                    imagePath_ = _pickedFile.path;
                    debugPrint("imagen: ${imagePath_!}");
                  });
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}









Widget _botonGuardar() {
  return StreamBuilder(
      stream: null,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        final ButtonStyle raisedButtonStyle = ElevatedButton.styleFrom(
          backgroundColor: const Color.fromARGB(255, 39, 83, 89),
          foregroundColor: Colors.white,
          minimumSize: const Size(88, 36),
          padding: const EdgeInsets.symmetric(horizontal: 16),
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
            padding: const EdgeInsets.symmetric(horizontal: 80.0, vertical: 15.0),
            child: const Text(
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
          backgroundColor: const Color.fromARGB(255, 39, 83, 89),
          foregroundColor: Colors.white,
          minimumSize: const Size(88, 36),
          padding: const EdgeInsets.symmetric(horizontal: 16),
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
            padding: const EdgeInsets.symmetric(horizontal: 80.0, vertical: 15.0),
            child: const Text(
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
          backgroundColor: const Color.fromARGB(255, 39, 83, 89),
          foregroundColor: Colors.white,
          minimumSize: const Size(88, 36),
          padding: const EdgeInsets.symmetric(horizontal: 16),
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
            padding: const EdgeInsets.symmetric(horizontal: 80.0, vertical: 15.0),
            child: const Text(
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

























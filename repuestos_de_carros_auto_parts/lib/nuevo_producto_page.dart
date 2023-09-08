import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
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
            appBar: AppBar(title: const Text("Producto",style: TextStyle(fontSize: 30, fontWeight: FontWeight.w500),),
            centerTitle: true, ),
            drawer: const MenuLateralAdmin(), //solo agregar esta linea para agregar el menu desplegable
            body: SingleChildScrollView( //este metodo permite que el contenido sea desplazable si ocupa más espacio vertical del disponible.
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _imagenImagePicker(),
                    _codigoTextField(),
                    const SizedBox(height: 15.0,),
                    _codigoBarrasTextField(),
                    const SizedBox(height: 15.0,),
                    _nombreTextField(),
                    const SizedBox(height: 15.0,),
                    _descripcionTextField(),
                    const SizedBox(height: 15.0,),
                    _precioTextField(),
                    const SizedBox(height: 15.0,),

                    const DropdownMenuSucursal(),
                    const SizedBox(height: 15.0,),
                    const DropdownMenuCategoria(),
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


Widget _codigoBarrasTextField() {
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
              hintText: 'Codigo barra',
              labelText: 'Codigo Barra',
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
            keyboardType: TextInputType.multiline,
            maxLines: null,
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
class DropdownMenuSucursal extends StatefulWidget {
  const DropdownMenuSucursal({super.key});

  @override
  State<DropdownMenuSucursal> createState() => _DropdownMenuSucursalState();
}

class _DropdownMenuSucursalState extends State<DropdownMenuSucursal> {
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


const List<String> list2 = <String>['Seleccione Categoria','One', 'Two', 'Three', 'Four'];
class DropdownMenuCategoria extends StatefulWidget {
  const DropdownMenuCategoria({super.key});

  @override
  State<DropdownMenuCategoria> createState() => _DropdownMenuCategoriaState();
}

class _DropdownMenuCategoriaState extends State<DropdownMenuCategoria> {
  String dropdownValue = list2.first;

  @override
  Widget build(BuildContext context) {
    return DropdownMenu<String>(
      initialSelection: list2.first,
      onSelected: (String? value) {
        // This is called when the user selects an item.
        setState(() {
          dropdownValue = value!;
        });
      },
      dropdownMenuEntries: list2.map<DropdownMenuEntry<String>>((String value) {
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
























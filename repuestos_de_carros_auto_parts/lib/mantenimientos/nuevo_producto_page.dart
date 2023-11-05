import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:repuestos_de_carros_auto_parts/menu_lateral_admin.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../api_config.dart';


void main() {
  runApp(const MyApp());
}

//archivo aparte
class Sucursal {
  final int idSucursal;
  final String nombre;

  Sucursal({required this.idSucursal, required this.nombre});

  factory Sucursal.fromJson(Map<String, dynamic> json) {
    return Sucursal(
      idSucursal: json['id_sucursal'],
      nombre: json['nombre'],
    );
  }
}//
//archivo aparte2
class Categoria {
  final int idCategoria;
  final String nombre;

  Categoria({required this.idCategoria, required this.nombre});

  factory Categoria.fromJson(Map<String, dynamic> json) {
    return Categoria(
      idCategoria: json['id_categoria'],
      nombre: json['nombre'],
    );
  }
}//

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

class NuevoProductoPage extends StatefulWidget {
  const NuevoProductoPage({super.key});

  @override
  _NuevoProductoPageState createState() => _NuevoProductoPageState();
}

class _NuevoProductoPageState extends State<NuevoProductoPage> {
  final TextEditingController _codigoController = TextEditingController();
  final TextEditingController _codigobarraController = TextEditingController();
  final TextEditingController _nombreController = TextEditingController();
  final TextEditingController _descripcionController = TextEditingController();
  final TextEditingController _precioController = TextEditingController();
  final TextEditingController _idController = TextEditingController();
  String? nombreUsuario;
  String? tokenCompartido;
  XFile? pickedFile;
  List<Sucursal> sucursales = [];
  String sucursalDropdownValue = 'Seleccione Sucursal';
  List<Categoria> categorias = [];
  String categoriaDropdownValue = 'Seleccione categoria';


// Crear una notificación en la parte inferior de la app
  void _showNotification(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  @override
  void initState() {
    super.initState();
    _loadSharedPreferences();
    _fetchSucursales();
    _fetchCategorias();
  }

  Future<void> _fetchSucursales() async {
    final response =
    await http.get(Uri.parse('${ApiConfig.apiUrl}api/sucursal/listaSucursal'));

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      setState(() {
        sucursales = data.map((item) => Sucursal.fromJson(item)).toList();
      });
    } else {
      throw Exception('Failed to load sucursales');
    }
  }
  Future<void> _fetchCategorias() async {
    final response =
    await http.get(Uri.parse('${ApiConfig.apiUrl}api/categoria/listaCategoria'));

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      setState(() {
        categorias = data.map((item) => Categoria.fromJson(item)).toList();
      });
    } else {
      throw Exception('Failed to load categorias');
    }
  }
  Future<void> _loadSharedPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? tokenShared = prefs.getString('token');
    final String? nombreShared = prefs.getString('usuario');

    setState(() {
      nombreUsuario = nombreShared;
      tokenCompartido = tokenShared;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            appBar: AppBar(title: const Text("Producto",style: TextStyle(fontSize: 30, fontWeight: FontWeight.w500),),
              centerTitle: true, ),
            drawer: const MenuLateralAdmin(), //solo agregar esta linea para agregar el menu desplegable
            body: SingleChildScrollView( //este metodo permite que el contenido sea scroll si ocupa más espacio vertical del disponible.
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    (pickedFile == null)
                        ? Container()
                        : Image.file(File(pickedFile!.path), width: 200,), // Mostrar la imagen seleccionada
                    ElevatedButton(
                      child: const Text("SELECCIONAR IMAGEN"),
                      onPressed: () async {
                        final ImagePicker picker = ImagePicker();
                        XFile? file = await picker.pickImage(source: ImageSource.gallery);
                        setState(() {
                          pickedFile = file; // Almacena la imagen seleccionada en la variable pickedFile
                        });
                      },
                    ),
                    _idTextField(),
                    const SizedBox(height: 15.0,),
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
                    DropdownMenuSucursales(
                      sucursales: sucursales, // Lista de sucursales obtenidas de la API
                      onSelected: (int? value) {
                        setState(() {
                          sucursalDropdownValue = value?.toString() ?? 'Seleccione Ubicación';
                        });
                      },
                    ),
                    const SizedBox(height: 15.0,),
                    DropdownMenuCategoria(
                      categorias: categorias, // Lista de categorias obtenidas de la API
                      onSelected: (int? value) {
                        setState(() {
                          categoriaDropdownValue = value?.toString() ?? 'Seleccione Categoria';
                        });
                      },
                    ),
                    const SizedBox(height: 20.0,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly, // Ajusta la alineación de los botones
                      children: [
                        _botonGuardar(),
                        _botonEliminar(),
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


  Widget _idTextField() {
    return StreamBuilder(
        stream: null,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          return Container(
            padding: const EdgeInsets.symmetric(horizontal: 5.0),
            child: TextField(
              controller: _idController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(15)),),
                //icon: Icon(Icons.numbers),
                hintText: 'Id Producto',
                labelText: 'ID',
                labelStyle: TextStyle(color: Colors.black),
                focusColor: Colors.teal,
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(15)),
                  borderSide: BorderSide(
                      color: Colors.black), // Cambio de color a negro

                ),
              ),

              onChanged: (value) {},
            ),
          );
        });
  }

  Widget _codigoTextField() {
    return StreamBuilder(
        stream: null,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          return Container(
            padding: const EdgeInsets.symmetric(horizontal: 5.0),
            child: TextField(
              controller: _codigoController,
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


  Widget _codigoBarrasTextField() {
    return StreamBuilder(
        stream: null,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          return Container(
            padding: const EdgeInsets.symmetric(horizontal: 5.0),
            child: TextField(
              controller: _codigobarraController,
              keyboardType: TextInputType.number,
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
              controller: _nombreController,
              keyboardType: TextInputType.text,
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
              controller: _descripcionController,
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
              controller: _precioController,
              keyboardType: TextInputType.text,
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






  Widget _botonGuardar() {
    return StreamBuilder(
      stream: null,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return GestureDetector(
          onTap: () async {
            String codigo = _codigoController.text;
            String codigoBarra = _codigobarraController.text;
            String nombre = _nombreController.text;
            String descripcion = _descripcionController.text;
            String precio = _precioController.text;
            String sucursal = sucursalDropdownValue;
            String categoria = categoriaDropdownValue;

            // Crea un objeto de tipo MultipartRequest
            var request = http.MultipartRequest(
              'POST',
              Uri.parse("${ApiConfig.apiUrl}api/producto/crearProductoImage?cod_prod=$codigo&cod_barr=$codigoBarra&nom=$nombre&desc=$descripcion&prec=$precio&id_cat=$categoria&id_suc=$sucursal"),
            );

            // Verifica si se seleccionó una imagen
            if (pickedFile != null) {
              // Crea un MultipartFile desde el archivo seleccionado
              http.MultipartFile imageFile = await http.MultipartFile.fromPath(
                'file', // Nombre del campo en la solicitud
                pickedFile!.path, // Ruta del archivo seleccionado
              );

              // Agrega el archivo a la solicitud
              request.files.add(imageFile);
            }
            request.headers['Authorization'] = 'Bearer $tokenCompartido';

            try {
              var response = await request.send();

              var responseData = await response.stream.toBytes();
              var responseString = String.fromCharCodes(responseData);

              // Verifica el estado de la respuesta
              if (response.statusCode == 200) {
                _showNotification("Producto agregada con éxito.");
              } else {
                // Si la solicitud falla, imprime el código de estado
                _showNotification("Error al agregar la Producto Código de estado: ${response.statusCode}");
              }
            } catch (error) {
              _showNotification("Error al enviar la solicitud: $error");
            }
          },
          child: Container(
            width: 80.0,
            height: 80.0,
            decoration: BoxDecoration(
              color: const Color(0xff229743), // color de fondo verde
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
          onTap: () async {
            String id = _idController.text;

            String apiUrl = "${ApiConfig.apiUrl}api/producto/eliminarUbicacion?id=$id";

            var response = await http.delete(
              Uri.parse(apiUrl),
              headers: {
                "Authorization": "Bearer $tokenCompartido",
              },
            );

            if (response.statusCode == 200) {
              _showNotification("Producto eliminado con éxito.");
            } else {

              _showNotification("Error al eliminar el Producto Código de estado: ${response.statusCode}");
            }
          },
          child: Container(
            width: 80.0,
            height: 80.0,
            decoration: BoxDecoration(
              color: const Color(0xffF02121), // color de fondo a verde
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







}



class DropdownMenuSucursales extends StatefulWidget {
  final List<Sucursal> sucursales;
  final ValueChanged<int?> onSelected;

  const DropdownMenuSucursales({
    required this.sucursales,
    required this.onSelected,
    Key? key,
  }) : super(key: key);

  @override
  State<DropdownMenuSucursales> createState() => _DropdownMenuSucursalesState();
}

class _DropdownMenuSucursalesState extends State<DropdownMenuSucursales> {
  int? dropdownValue;

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<int>(
      value: dropdownValue,
      onChanged: (int? value) {
        setState(() {
          dropdownValue = value;
        });
        widget.onSelected(value);
      },
      items: [
        const DropdownMenuItem<int>(
          value: null, // Indicador visual sin valor real asociado
          child: Text('Seleccione una ubicación'),
        ),
        ...widget.sucursales.map((Sucursal sucursal) {
          return DropdownMenuItem<int>(
            value: sucursal.idSucursal,
            child: Text(sucursal.nombre),
          );
        }).toList(),
      ],
    );
  }
}

class DropdownMenuCategoria extends StatefulWidget {
  final List<Categoria> categorias;
  final ValueChanged<int?> onSelected;

  const DropdownMenuCategoria({
    required this.categorias,
    required this.onSelected,
    Key? key,
  }) : super(key: key);

  @override
  State<DropdownMenuCategoria> createState() => _DropdownMenuCategoriaState();
}

class _DropdownMenuCategoriaState extends State<DropdownMenuCategoria> {
  int? dropdownValue;

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<int>(
      value: dropdownValue,
      onChanged: (int? value) {
        setState(() {
          dropdownValue = value;
        });
        widget.onSelected(value);
      },
      items: [
        const DropdownMenuItem<int>(
          value: null, // Indicador visual sin valor real asociado
          child: Text('Seleccione una categoria'),
        ),
        ...widget.categorias.map((Categoria categoria) {
          return DropdownMenuItem<int>(
            value: categoria.idCategoria,
            child: Text(categoria.nombre),
          );
        }).toList(),
      ],
    );
  }
}
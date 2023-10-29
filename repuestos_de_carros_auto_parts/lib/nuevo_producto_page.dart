import 'dart:io';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:repuestos_de_carros_auto_parts/menu_lateral_admin.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'api_config.dart';


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
  String? imagePath = "";
  String? _imagen64 = "";
  String sucursalDropdownValue = 'Seleccione Sucursal';
  String categoriaDropdownValue = 'Seleccione categoria';
  String? nombreUsuario;
  String? tokenCompartido;


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
            body: SingleChildScrollView( //este metodo permite que el contenido sea desplazable si ocupa más espacio vertical del disponible.
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    (imagePath == null)? Container() : Image.file(File(imagePath!), width: 100,),
                    ElevatedButton(
                      child: const Text("SELECCIONAR IMAGEN"),
                        onPressed: () async {
                          final ImagePicker picker = ImagePicker();
                          XFile? pickedFile = await picker.pickImage(source: ImageSource.gallery);
                          if (pickedFile != null) {
                            setState(() {
                              imagePath = pickedFile.path;
                            });
                            List<int> bytes = File(imagePath!).readAsBytesSync();
                            _imagen64 = base64.encode(bytes);
                          } else {
                            // El usuario canceló la selección de la imagen.

                          }
                        }
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
                    DropdownMenuSucursal(
                      onSelected: (String? value) {
                        setState(() {
                          sucursalDropdownValue = value ?? 'Seleccione Sucursal';
                        });
                      },
                    ),
                    const SizedBox(height: 15.0,),
                    DropdownMenuCategoria(
                      onSelected: (String? value) {
                        setState(() {
                          categoriaDropdownValue = value ?? 'Seleccione Categoria';
                        });
                      },
                    ),
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


  Widget _idTextField() {
    return StreamBuilder(
        stream: null,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          return Container(
            padding: const EdgeInsets.symmetric(horizontal: 5.0),
            child: TextField(
              controller: _idController,
              keyboardType: TextInputType.number,
              //pone por defecto el teclado con arroba y demas
              decoration: const InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(15)),),
                //icon: Icon(Icons.numbers),
                hintText: 'Id Ubicacion',
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
              controller: _codigobarraController,
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
              controller: _nombreController,
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






  Widget _botonGuardar() {
    return StreamBuilder(
      stream: null,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return GestureDetector(
          onTap: () async {
            // Obtén los valores de los controladores de texto
            String codigo = _codigoController.text;
            String codigoBarra = _codigobarraController.text;
            String nombre = _nombreController.text;
            String descripcion = _descripcionController.text;
            String precio = _precioController.text;
            String sucursal = sucursalDropdownValue;
            String categoria = categoriaDropdownValue;
            debugPrint("SUCURSAL:$sucursal");
debugPrint("IMAGEEEN:${_imagen64!}");
            // Crea un objeto de tipo MultipartRequest
            var request = http.MultipartRequest(
              'POST',
              Uri.parse("${ApiConfig.apiUrl}api/producto/crearProductoImage?cod_prod=$codigo&cod_barr=$codigoBarra&nom=$nombre&desc=$descripcion&prec=$precio&id_cat=$categoria&id_suc=$sucursal"),
            );

            // Agrega el archivo a la solicitud con el nombre "file"
            http.MultipartFile multipartFile = http.MultipartFile.fromString(
              'file',
              _imagen64!,
              filename: 'file',
            );
            request.files.add(multipartFile);

            // Realiza la solicitud HTTP POST con el encabezado de autorización
            request.headers['Authorization'] = 'Bearer $tokenCompartido';

            try {
              // Envia la solicitud y obtén la respuesta
              var response = await request.send();

              // Lee la respuesta del servidor
              var responseData = await response.stream.toBytes();
              var responseString = String.fromCharCodes(responseData);

              // Verifica el estado de la respuesta
              if (response.statusCode == 200) {
                // Si la solicitud fue exitosa, imprime la respuesta del servidor
                _showNotification("Producto agregada con éxito.");
              } else {
                // Si la solicitud falla, imprime el código de estado
                _showNotification("Error al agregar la Producto Código de estado: ${response.statusCode}");
              }
            } catch (error) {
              // Maneja cualquier error que ocurra durante la solicitud
              _showNotification("Error al enviar la solicitud: $error");
            }
          },
          child: Container(
            width: 80.0, // Ajusta el ancho según tus necesidades
            height: 80.0, // Ajusta el alto según tus necesidades
            decoration: BoxDecoration(
              color: const Color(0xff229743), // Cambia el color de fondo a verde
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
              _showNotification("Producto eliminada con éxito.");
            } else {

              _showNotification("Error al eliminar la Producto Código de estado: ${response.statusCode}");
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


  Widget _botonModificar() {
    return StreamBuilder(
      stream: null,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return GestureDetector(
          onTap: () {
            print("se modifico 🔄");
          },
          child: Container(
            width: 80.0,
            height: 80.0,
            decoration: BoxDecoration(
              color: const Color(0xff290BE7), // color de fondo a verde
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








}



const List<String> list_1 = <String>['Seleccione Sucursal','5', 'Two', 'Three', 'Four'];
class DropdownMenuSucursal extends StatefulWidget {
  final ValueChanged<String?> onSelected;

  const DropdownMenuSucursal({required this.onSelected, Key? key}) : super(key: key);

  @override
  State<DropdownMenuSucursal> createState() => _DropdownMenuSucursalState();
}

class _DropdownMenuSucursalState extends State<DropdownMenuSucursal> {
  String dropdownValue = list_1.first;

  @override
  Widget build(BuildContext context) {
    return DropdownMenu<String>(
      initialSelection: dropdownValue,
      onSelected: (String? value) {
        setState(() {
          dropdownValue = value!;
          widget.onSelected(value); // Llama a la función proporcionada por el padre
        });
      },
      dropdownMenuEntries: list_1.map<DropdownMenuEntry<String>>((String value) {
        return DropdownMenuEntry<String>(value: value, label: value);
      }).toList(),
      width: 350,
    );
  }
}


const List<String> list = <String>['Seleccione Categoria','1', 'Two', 'Three', 'Four'];
class DropdownMenuCategoria extends StatefulWidget {
  final ValueChanged<String?> onSelected;

  const DropdownMenuCategoria({required this.onSelected, Key? key}) : super(key: key);

  @override
  State<DropdownMenuCategoria> createState() => _DropdownMenuCategoriaState();
}

class _DropdownMenuCategoriaState extends State<DropdownMenuCategoria> {
  String dropdownValue = list.first;

  @override
  Widget build(BuildContext context) {
    return DropdownMenu<String>(
      initialSelection: dropdownValue,
      onSelected: (String? value) {
        setState(() {
          dropdownValue = value!;
          widget.onSelected(value); // Llama a la función proporcionada por el padre
        });
      },
      dropdownMenuEntries: list.map<DropdownMenuEntry<String>>((String value) {
        return DropdownMenuEntry<String>(value: value, label: value);
      }).toList(),
      width: 350,
    );
  }
}







class ImagePickerWidget extends StatefulWidget {
  final Function(String)? onImageSelected;

  const ImagePickerWidget({super.key, required this.onImageSelected});

  @override
  _ImagePickerWidgetState createState() => _ImagePickerWidgetState();
}

class _ImagePickerWidgetState extends State<ImagePickerWidget> {
  late File _imageFile;

  @override
  void initState() {
    super.initState();
    _imageFile = File(''); // Inicializa el archivo de imagen como vacío
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 5.0),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            const Text("Seleccione imagen: "),
            (_imageFile.path.isEmpty) ? Container() : Image.file(_imageFile),
            ElevatedButton(
              child: const Text("Cargar imagen"),
              onPressed: () async {
                final ImagePicker picker = ImagePicker();
                XFile? pickedFile =
                await picker.pickImage(source: ImageSource.gallery);
                if (pickedFile != null) {
                  setState(() {
                    _imageFile = File(pickedFile.path);
                    debugPrint("imagen: ${_imageFile.path}");

                    // Convierte la imagen a base64
                    List<int> imageBytes = _imageFile.readAsBytesSync();
                    String base64Image = base64Encode(imageBytes);

                    // Llama a la función de retorno de llamada y pasa la imagen en base64
                    widget.onImageSelected?.call(base64Image);
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
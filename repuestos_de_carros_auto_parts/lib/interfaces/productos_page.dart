import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:repuestos_de_carros_auto_parts/api_config.dart';
import 'package:repuestos_de_carros_auto_parts/interfaces/info_producto_page.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

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

class ProductosPage extends StatefulWidget {
  const ProductosPage({super.key});

  @override
  _ProductosPageState createState() => _ProductosPageState();
}

class _ProductosPageState extends State<ProductosPage> {
  final TextEditingController _searchController = TextEditingController();
  List<Map<String, dynamic>> filteredProductos = [];

  @override
  void initState() {
    super.initState();
    _fetchProductos().then((productos) {
      setState(() {
        filteredProductos = productos;
      });
    });
  }

  Future<List<Map<String, dynamic>>> _fetchProductos() async {
    final response = await http.get(Uri.parse('${ApiConfig.apiUrl}api/producto/listaProducto'));

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      List<Map<String, dynamic>> productos = [];

      for (var producto in data) {
        productos.add({
          'id_producto': producto['id_producto'],
          'nombre': producto['nombre'],
          'descripcion': producto['descripcion'],
          'precio': producto['precio'].toString(),
          'imagen': producto['image'],
        });
      }

      return productos;
    } else {
      throw Exception('Failed to load products');
    }
  }

  void _filterProductos(String query) {
    setState(() {
      filteredProductos = filteredProductos
          .where((producto) => producto['nombre'].toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          foregroundColor: Colors.black,
          backgroundColor: Colors.white,
          title: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              color: Colors.white,
              border: Border.all(color: const Color(0xff95A4BB), style: BorderStyle.solid, width: 1.0),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Row(
              children: [
                const Icon(Icons.search),
                Expanded(
                  child: TextField(
                    controller: _searchController,
                    onChanged: _filterProductos,
                    decoration: const InputDecoration(
                      hintText: "Buscar producto...",
                      border: InputBorder.none,
                    ),
                    textCapitalization: TextCapitalization.none,
                    autofocus: false,
                  ),
                ),
                if (_searchController.text.isNotEmpty)
                  IconButton(
                    icon: const Icon(Icons.clear),
                    onPressed: () {
                      setState(() {
                        _searchController.clear();
                        filteredProductos = [];
                      });
                    },
                  ),
              ],
            ),
          ),
        ),
        body: FutureBuilder<List<Map<String, dynamic>>>(
          future: _fetchProductos(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Center(child: Text('No se encontraron productos.'));
            } else {
              List<Map<String, dynamic>> productos = snapshot.data!;
              return SingleChildScrollView(
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(height: 20),
                      ...productos
                          .where((producto) =>
                          producto['nombre']
                              .toLowerCase()
                              .contains(_searchController.text.toLowerCase()))
                          .map(
                            (producto) => CardProducto(
                          imagen: producto['imagen'] ?? 'https://i.ibb.co/bPcw0ZQ/tienda-1.png',
                          nombre: producto['nombre'],
                          id_producto: producto['id_producto'].toString(),
                          descripcion: producto['descripcion'],
                          precio: producto['precio'],
                        ),
                      )
                          .toList(),
                    ],
                  ),
                ),
              );
            }
          },
        ),
      ),
    );
  }
}

class CardProducto extends StatelessWidget {
  final dynamic imagen;
  final String nombre;
  final String descripcion;
  final String precio;
  final String id_producto;

  const CardProducto({Key? key, required this.imagen, required this.id_producto,required this.nombre, required this.descripcion, required this.precio}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget imageWidget;

    if (imagen != null && imagen.isNotEmpty) {
      if (imagen.startsWith('http')) {
        // Si la imagen es una URL, carga la imagen desde la red
        imageWidget = Image.network(imagen, width: 80, height: 80, fit: BoxFit.cover);
      } else {
        // Si la imagen está en formato Base64, decodifica y muestra la imagen
        Uint8List bytes = base64.decode(imagen);
        imageWidget = Image.memory(bytes, width: 80, height: 80, fit: BoxFit.cover);
      }
    } else {
      // Si no hay imagen, muestra una imagen predeterminada
      imageWidget = Image.asset('assets/imagenes/tienda_1.png', width: 80, height: 80, fit: BoxFit.cover);
    }

    return Card(
      surfaceTintColor: Colors.white,
      clipBehavior: Clip.hardEdge,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(10.0)),
        side: BorderSide(color: Colors.black, width: 1.0),
      ),
      margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 1),
      elevation: 5,
      child: InkWell(
        splashColor: const Color.fromARGB(255, 71, 73, 73),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => InfoProductosPage(productoId: id_producto), // Establece el valor del productoId aquí
            ),
          );
        },
        child: SizedBox(
          width: 340,
          child: Column(
            children: <Widget>[
              ListTile(
                contentPadding: const EdgeInsets.fromLTRB(1, 1, 5, 0),
                title: Text(nombre),
                subtitle: Text(descripcion.length >= 50 ? "${descripcion.substring(0, 50)}..." : descripcion),
                leading: SizedBox(
                  width: 80,
                  child: imageWidget,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Text('\$$precio', style: const TextStyle(fontSize: 24.0)),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}




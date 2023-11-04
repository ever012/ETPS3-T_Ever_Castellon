import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:repuestos_de_carros_auto_parts/api_config.dart';
import 'package:repuestos_de_carros_auto_parts/mapas/map_ubicacion_especifica.dart';
import 'dart:convert';



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
        '/': (context) => const InfoProductosPage(productoId: ''),

      },


      //home: const MyHomePage(title: 'Flutter Demoo Home Page'),
    );
  }
}

class InfoProductosPage extends StatefulWidget {
  final String productoId; // Define el parámetro productoId

  const InfoProductosPage({super.key, required this.productoId}); // Constructor que acepta productoId

  @override
  _InfoProductosPageState createState() => _InfoProductosPageState();
}

class _InfoProductosPageState extends State<InfoProductosPage> {
  Future<Map<String, dynamic>> _fetchProducto() async {
    final response = await http.get(
        Uri.parse('${ApiConfig.apiUrl}api/producto/descripcionProductoId?id=${widget.productoId}'));

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load product details');
    }
  }

  Widget _buildImageWidget(String imageUrl) {
    if (imageUrl.isNotEmpty) {
      if (imageUrl.startsWith('http')) {
        // Si la imagen es una URL, carga la imagen desde la red
        return Image.network(
          imageUrl,
          width: 100.0,
          height: 100.0,
          fit: BoxFit.cover,
        );
      } else {
        // Si la imagen está en formato Base64, decodifica y muestra la imagen
        Uint8List bytes = base64.decode(imageUrl);
        return Image.memory(
          bytes,
          width: 100.0,
          height: 100.0,
          fit: BoxFit.cover,
        );
      }
    } else {
      // Si no hay imagen o es nula, muestra una imagen predeterminada
      return Image.asset(
        'assets/imagenes/tienda_1.png',
        width: 100.0,
        height: 100.0,
        fit: BoxFit.cover,
      );
    }
  }







  @override
  Widget build(BuildContext context) {
    Widget imageWidget;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detalles del Producto'),
      ),
      body: FutureBuilder<Map<String, dynamic>>(
        future: _fetchProducto(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No se encontraron detalles del producto.'));
          } else {
            Map<String, dynamic> producto = snapshot.data!;
            return SingleChildScrollView(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 350,
                      decoration: BoxDecoration(
                        color: const Color(0xffECF5F8),
                        border: Border.all(color: const Color(0xff223335)),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 5.0),
                        child: Text(
                          "Informacion General",
                          style: TextStyle(
                            fontSize: 24.0,
                            color: Color(0xffD64747),
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 20),
                    producto['image'] != null && producto['image'].isNotEmpty
                        ? _buildImageWidget(producto['image'])
                        : Center(
                          child: Image.asset("assets/imagenes/tienda_1.png",width: 100.0,height: 100.0,fit: BoxFit.cover,),
                    ),
                    const SizedBox(height: 10),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
                        child: Text(producto['nombre'], style: const TextStyle(fontSize: 24)),
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
                        padding: const EdgeInsets.fromLTRB(20, 8, 0, 0),
                        child: Text("\$${producto['precio']}",
                          style: const TextStyle(fontSize: 24, color: Color(0xffD64747)),
                        ),
                      ),
                    ),
                    const Divider(
                      height: 10,
                      thickness: 1,
                      indent: 10,
                      endIndent: 10,
                      color: Colors.black,
                    ),
                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 0),
                        child: Text(
                          "DESCRIPCIÓN",
                          style: TextStyle(fontSize: 24, color: Color(0xff95A4BB)),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                      child: Text(
                        producto['descripcion'],
                        style: const TextStyle(fontSize: 15, color: Color(0xff95A4BB)),
                      ),
                    ),
                    OutlinedButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                            builder: (context) => MapUbicaciones(id: producto['sucursal']["ubicacion"]["id_ubicacion"].toString(),latitud: producto['sucursal']["ubicacion"]["latitud"],longitud: producto['sucursal']["ubicacion"]["longitud"],nombre: producto['sucursal']["ubicacion"]["nombre"],), // Establece el valor del productoId aquí
                        ),);
                      },
                      child: const Text("¿DÓNDE PUEDO ENCONTRARLO EN EL MAPA?"),
                    ),

                  ],
                ),
              ),
            );
          }
        },
      ),
    );
  }



}


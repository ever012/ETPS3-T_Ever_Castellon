import 'package:flutter/material.dart';
import 'package:repuestos_de_carros_auto_parts/interfaces/productos_page.dart';
import 'package:repuestos_de_carros_auto_parts/menu_lateral.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

import '../api_config.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sucursales',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.white),
        useMaterial3: true,
        scaffoldBackgroundColor: Colors.white,
      ),
      routes: {
        '/': (context) => const SucursalesPage(),
        '/productos_page': (context) => const ProductosPage(),
      },
    );
  }
}

class SucursalesPage extends StatefulWidget {
  const SucursalesPage({super.key});

  @override
  _SucursalesPageState createState() => _SucursalesPageState();
}

class _SucursalesPageState extends State<SucursalesPage> {
  final TextEditingController _searchController = TextEditingController();
  List<Map<String, dynamic>> sucursales = [];
  List<Map<String, dynamic>> filteredSucursales = [];

  @override
  void initState() {
    super.initState();
    _fetchSucursales().then((sucursalesData) {
      setState(() {
        sucursales = sucursalesData;
        filteredSucursales = sucursales;
      });
    });
  }

  Future<List<Map<String, dynamic>>> _fetchSucursales() async {
    final response = await http.get(Uri.parse('${ApiConfig.apiUrl}api/sucursal/listaSucursal'));

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      List<Map<String, dynamic>> sucursalesList = [];

      for (var sucursal in data) {
        sucursalesList.add({
          'nombre': sucursal['nombre'],
          'id_sucursal': sucursal['id_sucursal']
        });
      }

      return sucursalesList;
    } else {
      throw Exception('Failed to load sucursales');
    }
  }

  void _filterSucursales(String query) {
    setState(() {
      filteredSucursales = sucursales
          .where((sucursal) =>
          sucursal['nombre'].toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          foregroundColor: Colors.black, //color de los iconos
          backgroundColor: Colors.white,  //backround del appBar(menu)
          title: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              color: Colors.white,
                border: Border.all(color: const Color(0xff95A4BB),style: BorderStyle.solid,width: 1.0)
            ),
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Row(
              children: [
                const Icon(Icons.search),
                Expanded(
                  child: TextField(
                    controller: _searchController,
                    onChanged: _filterSucursales,
                    decoration: const InputDecoration(
                      hintText: "Buscar sucursal...",
                      border: InputBorder.none,
                    ),
                    textCapitalization: TextCapitalization.none, // Acepta mayúsculas y minúsculas
                    autofocus: false, // Quita el enfoque automático
                  ),
                ),
                if (_searchController.text.isNotEmpty)
                  IconButton(
                    icon: const Icon(Icons.clear),
                    onPressed: () {
                      setState(() {
                        _searchController.clear();
                        filteredSucursales = sucursales;
                      });
                    },
                  ),
              ],
            ),
          ),
        ),
        drawer: const MenuLateral(),
        body: SingleChildScrollView(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: filteredSucursales
                  .map((texto) => CardSucursal(imagen: "assets/imagenes/tienda_1.png", texto: texto['nombre'], id: texto['id_sucursal']))
                  .toList(),
            ),
          ),
        ),
      ),
    );
  }
}

class CardSucursal extends StatelessWidget {
  final String imagen;
  final String texto;
  final int id;

  const CardSucursal({Key? key, required this.imagen, required this.texto, required this.id})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      surfaceTintColor: Colors.white, //background
      clipBehavior: Clip.hardEdge,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10.0),),
        side: BorderSide(color: Colors.black, width: 1.0,), //grosor y color de los bordes
      ),
      child: InkWell(
        splashColor: Colors.black, //color que aparece al dar clic a una sucursal
        onTap: () {
          Navigator.pushNamed(context, "/productos_x_id_page",
              arguments: {'sucursal': id.toString()});
        },
        child: SizedBox(
          width: 300,
          height: 100,
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Image.asset(imagen, width: 80, height: 80),
              ),
              Text(
                texto,
                style: const TextStyle(fontSize: 20.0,color: Color(0xffF02121)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}




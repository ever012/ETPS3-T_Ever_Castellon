import 'package:flutter/material.dart';
import 'package:repuestos_de_carros_auto_parts/productos_page.dart';
import 'package:repuestos_de_carros_auto_parts/menu_lateral.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key});

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
  const SucursalesPage({Key? key});

  @override
  _SucursalesPageState createState() => _SucursalesPageState();
}

class _SucursalesPageState extends State<SucursalesPage> {
  TextEditingController _searchController = TextEditingController();
  List<String> sucursales = [
    "COLONIA ESCALON",
    "SANTA TECLA",
    "29 AV. NORTE",
    "APOPA",
    "CHALATENANGO",
    "SAN BENITO",
    "AHUACHAPAN",
  ];

  List<String> filteredSucursales = [];

  @override
  void initState() {
    super.initState();
    filteredSucursales = sucursales;
  }

  void _filterSucursales(String query) {
    setState(() {
      filteredSucursales = sucursales
          .where((sucursal) =>
          sucursal.toLowerCase().contains(query.toLowerCase()))
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
                border: Border.all(color: Color(0xff95A4BB),style: BorderStyle.solid,width: 1.0)
            ),
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Row(
              children: [
                Icon(Icons.search),
                Expanded(
                  child: TextField(
                    controller: _searchController,
                    onChanged: _filterSucursales,
                    decoration: InputDecoration(
                      hintText: "Buscar sucursal...",
                      border: InputBorder.none,
                    ),
                    textCapitalization: TextCapitalization.none, // Acepta mayúsculas y minúsculas
                    autofocus: false, // Quita el enfoque automático
                  ),
                ),
                if (_searchController.text.isNotEmpty)
                  IconButton(
                    icon: Icon(Icons.clear),
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
                  .map((texto) => CardSucursal(imagen: "assets/imagenes/tienda_1.png", texto: texto,))
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

  const CardSucursal({Key? key, required this.imagen, required this.texto})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      surfaceTintColor: Colors.white, //background
      clipBehavior: Clip.hardEdge,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10.0),),
        side: BorderSide(color: Colors.black, width: 1.0,), //grosor y color de los bordes
      ),
      child: InkWell(
        splashColor: Colors.black, //color que aparece al dar clic a una sucursal
        onTap: () {
          Navigator.pushNamed(context, "/productos_page",
              arguments: {'sucursal': texto});
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




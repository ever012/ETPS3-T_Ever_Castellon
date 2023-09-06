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
  const ProductosPage({Key? key});

  @override
  _ProductosPageState createState() => _ProductosPageState();
}

class _ProductosPageState extends State<ProductosPage> {
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
                  .map((texto) => CardProducto(imagen: "assets/imagenes/tienda_1.png",texto: "NOMBRE PRODUCTO",descripcion: "descripcion del producto", precio: "10.50"),)
                  .toList(),
            ),
          ),
        ),
      ),
    );
  }
}




class CardProducto extends StatelessWidget {
  final String imagen;
  final String texto;
  final String descripcion;
  final String precio;

  const CardProducto({super.key, String? imagen, String? texto, String? descripcion, String? precio})  //en caso de no introducir los parametros
      : imagen = imagen ?? "assets/imagenes/tienda_1.png", //valor por de
        texto = texto ?? "TEXTO LEATORIO",
        descripcion = descripcion ?? "0",
        precio = precio ?? "0";

  @override
  Widget build(BuildContext context) {
    return Card(

      // Con esta propiedad modificamos la forma de nuestro card
      // Aqui utilizo RoundedRectangleBorder para proporcionarle esquinas circulares al Card
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),

      // Con esta propiedad agregamos margen a nuestro Card
      // El margen es la separación entre widgets o entre los bordes del widget padre e hijo
      margin: const EdgeInsets.all(15),

      // Con esta propiedad agregamos elevación a nuestro card
      // La sombra que tiene el Card aumentará
      elevation: 10,

    // Envolver el contenido de la Card con InkWell para detectar el clic
      child: InkWell(
        splashColor: const Color.fromARGB(255, 71, 73, 73),
        onTap: () {
          debugPrint('se abre el google maps 😀');
        },
        child: SizedBox(
          width: 300,
          child: Column(
            children: <Widget>[

              // Usamos ListTile para ordenar la información del card como titulo, subtitulo e icono
              ListTile(
                contentPadding: const EdgeInsets.fromLTRB(1, 1, 5, 0),
                title: const Text('Nombre Producto'),
                subtitle: Text(descripcion),
                leading: Image.asset(imagen),
              ),

              // Usamos una fila para ordenar los botones del card
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Text('\$$precio', style: const TextStyle(fontSize: 24.0)),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}






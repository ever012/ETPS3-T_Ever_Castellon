import 'package:flutter/material.dart';
import 'package:repuestos_de_carros_auto_parts/info_producto_page.dart';
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
        '/info_page': (context) => InfoProductosPage(),

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
  List<String> productos = [
    "Filtro Aire",
    "Filtro Combustible",
    "Filtro de Cabina",
    "Filtro de Aceite",
    "Filtro de Transmision",
    "Filtro Trampa Agua",
    "Filtro PVC",
  ];

  List<String> descripciones = [
    "Descripción del producto 1",
    "Descripción del producto 2",
    "Descripción del producto 3",
    "Descripción del producto 4",
    "Descripción del producto 5",
    "Descripción del producto 6",
    "Descripción del producto 7",
  ];

  List<String> precios = [
    "57.50",
    "57.50",
    "10.50",
    "80.50",
    "50.50",
    "40.00",
    "57.00",
  ];

  List<String> filteredProductos = [];

  @override
  void initState() {
    super.initState();
    filteredProductos = productos;
  }

  void _filterProductos(String query) {
    setState(() {
      filteredProductos = productos
          .where((producto) =>
          producto.toLowerCase().contains(query.toLowerCase()))
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
                    onChanged: _filterProductos,
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
                        filteredProductos = productos;
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
              children: [
                Container(
                  width: 350,
                  decoration: BoxDecoration(
                    color: Color(0xffECF5F8),
                    border: Border.all(color: Color(0xff223335)),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15.0,vertical: 5.0), // Espacio alrededor del texto
                    child: const Text(
                      "Productos...",
                      style: TextStyle(
                        fontSize: 24.0,
                        color: Color(0xffD64747), // Texto en color blanco
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20), // Espacio entre el texto y los productos
                ...filteredProductos
                    .asMap()
                    .entries
                    .map(
                      (entry) => CardProducto(
                    imagen: "assets/imagenes/tienda_1.png",
                    texto: entry.value,
                    descripcion: descripciones[entry.key], // Usamos la lista de descripciones
                    precio: precios[entry.key], // Usamos la lista de precios
                  ),
                )
                    .toList(),
              ],
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
      surfaceTintColor: Colors.white, //background
      clipBehavior: Clip.hardEdge,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10.0),),
        side: BorderSide(color: Colors.black, width: 1.0,), //grosor y color de los bordes
      ),
      margin: const EdgeInsets.symmetric(vertical: 5,horizontal: 1),

      // Con esta propiedad agregamos elevación a nuestro card
      // La sombra que tiene el Card aumentará
      elevation: 5,

    // Envolver el contenido de la Card con InkWell para detectar el clic
      child: InkWell(
        splashColor: const Color.fromARGB(255, 71, 73, 73),
        onTap: () {
          Navigator.pushNamed(context,"/info_page",arguments: {'id': "1","nombre":texto,"precio":precio},
          );
        },
        child: SizedBox(
          width: 340,
          child: Column(
            children: <Widget>[

              // Usamos ListTile para ordenar la información del card como titulo, subtitulo e icono
              ListTile(
                contentPadding: const EdgeInsets.fromLTRB(1, 1, 5, 0),
                title: Text(texto),
                subtitle: Text(descripcion),
                leading: Image.asset(imagen),
              ),

              // Usamos una fila para ordenar los botones del card
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






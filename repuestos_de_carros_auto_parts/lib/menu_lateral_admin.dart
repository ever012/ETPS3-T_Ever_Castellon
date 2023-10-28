import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MenuLateralAdmin extends StatefulWidget {
  const MenuLateralAdmin({super.key});

  @override
  _MenuLateralAdminState createState() => _MenuLateralAdminState();
}

class _MenuLateralAdminState extends State<MenuLateralAdmin> {
  String? email;
  @override
  void initState() {
    super.initState();
    _loadSharedPreferences();
  }

  Future<void> _loadSharedPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? emailShared = prefs.getString('email');

    setState(() {
      email = emailShared;
    });
  }


  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: ListView(
          children: <Widget>[
            Container(
              height: 200, // Ajusta la altura de la imagen como desees
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/imagenes/logoautoparts.png'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Ink(
              color: const Color(0xffD64747),
              child: ListTile(
                leading: Image.asset('assets/Iconos/user_wite.png'),
                title: Text(email ?? "correo@gmail.com", style: const TextStyle(color: Colors.white),),
                onTap: (){
                //Navigator.pushNamed(context, '/');
              },
              ),
            ),
            ListTile(
              leading: const Icon(Icons.home_outlined, color: Colors.black),
              title: const Text("HOME"),
              onTap: (){
                Navigator.pushNamed(context, '/');
              },
            ),
            ListTile(
              leading: const Icon(Icons.list_outlined, color: Colors.black),
              title: const Text("CATEGORIAS"),
              onTap: (){
                Navigator.pushNamed(context, '/nueva_categoria_page');
              },
            ),
            ListTile(
              leading: const Icon(Icons.location_on_outlined, color: Colors.black),
              title: const Text("UBICACIONES"),
              onTap: (){
                Navigator.pushNamed(context, '/nueva_ubicacion_page');
              },
            ),
            ListTile(
              leading: const Icon(Icons.business_outlined, color: Colors.black),
              title: const Text("SUCURSALES"),
              onTap: (){
                Navigator.pushNamed(context, '/nueva_sucursal_page');
              },
            ),
            ListTile(
              leading: const Icon(Icons.production_quantity_limits_outlined, color: Colors.black),
              title: const Text("PRODUCTOS"),
              onTap: (){
                Navigator.pushNamed(context, '/nuevo_producto_page'); //cambia a este productos_page
              },
            ),
            ListTile(
              leading: const Icon(Icons.settings_outlined, color: Colors.black),
              title: const Text("CERRAR SESION"),
              onTap: (){
                eliminarSharedPreferences();
                Navigator.pushNamed(context, '/');
              },
            )

          ],
        ) ,
    );
  }
}




Future<void> eliminarSharedPreferences() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.clear(); // Esto eliminará todas las variables almacenadas en SharedPreferences
}
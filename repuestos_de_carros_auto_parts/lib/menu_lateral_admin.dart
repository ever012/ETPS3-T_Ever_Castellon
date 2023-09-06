import 'package:flutter/material.dart';

class MenuLateralAdmin extends StatelessWidget {
  const MenuLateralAdmin({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: ListView(
          children: <Widget>[
            Container(
              height: 200, // Ajusta la altura de la imagen como desees
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/imagenes/logoautoparts.png'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Ink(
              color: Color(0xffD64747),
              child: ListTile(
                leading: Image.asset('assets/Iconos/user_wite.png'),
                title: const Text("usuario1@gmail.com", style: TextStyle(color: Colors.white),),
                onTap: (){
                Navigator.pushNamed(context, '/');
              },
              ),
            ),
            ListTile(
              leading: Icon(Icons.home_outlined, color: Colors.black),
              title: const Text("HOME"),
              onTap: (){
                Navigator.pushNamed(context, '/');
              },
            ),
            ListTile(
              leading: Icon(Icons.list_outlined, color: Colors.black),
              title: const Text("CATEGORIAS"),
              onTap: (){
                Navigator.pushNamed(context, '/');
              },
            ),
            ListTile(
              leading: Icon(Icons.location_on_outlined, color: Colors.black),
              title: const Text("UBICACIONES"),
              onTap: (){
                Navigator.pushNamed(context, '/');
              },
            ),
            ListTile(
              leading: Icon(Icons.business_outlined, color: Colors.black),
              title: const Text("SUCURSALES"),
              onTap: (){
                Navigator.pushNamed(context, '/');
              },
            ),
            ListTile(
              leading: Icon(Icons.production_quantity_limits_outlined, color: Colors.black),
              title: const Text("PRODUCTOS"),
              onTap: (){
                Navigator.pushNamed(context, '/');
              },
            ),
            ListTile(
              leading: Icon(Icons.people_outlined, color: Colors.black),
              title: const Text("USUARIOS"),
              onTap: (){
                Navigator.pushNamed(context, '/');
              },
            ),
            ListTile(
              leading: Icon(Icons.settings_outlined, color: Colors.black),
              title: const Text("ROLES"),
              onTap: (){
                Navigator.pushNamed(context, '/');
              },
            )

          ],
        ) ,
    );
  }
}
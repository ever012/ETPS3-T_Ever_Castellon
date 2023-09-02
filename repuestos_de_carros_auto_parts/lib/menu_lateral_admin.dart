import 'package:flutter/material.dart';

class MenuLateralAdmin extends StatelessWidget {
  const MenuLateralAdmin({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: ListView(
          children: <Widget>[
            const UserAccountsDrawerHeader(
              accountName: Text("AUTO PARTS"),
              accountEmail: Text("repuestos.support@gmail.com"),
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/imagenes/logoautoparts.png'),
                      fit: BoxFit.cover
                  )
              ),
            ),
            Ink(
              color: Colors.indigo,
              child: ListTile(
                title: const Text("INICIO", style: TextStyle(color: Colors.white),),
                onTap: (){
                Navigator.pushNamed(context, '/');
              },
              ),
            ),
            ListTile(
              title: const Text("NUEVO PRODUCTO"),
              onTap: (){
                Navigator.pushNamed(context, '/nuevo_producto_page');
              },
            ),
            ListTile(
              title: const Text("NUEVA SUCURSAL"),
              onTap: (){
                Navigator.pushNamed(context, '/nueva_sucursal_page');
              },
            ),
            ListTile(
              title: const Text("UBICACIONES"),
              onTap: (){
                Navigator.pushNamed(context, '/ubicaciones_page');
              },
            ),
            ListTile(
              title: const Text("ROLES"),
              onTap: (){
                Navigator.pushNamed(context, '/roles_page');
              },
            ),
            ListTile(
              title: const Text("USUARIOS"),
              onTap: (){
                Navigator.pushNamed(context, '/usuarios_page');
              },
            )

          ],
        ) ,
    );
  }
}
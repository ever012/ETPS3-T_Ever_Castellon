import 'package:flutter/material.dart';

class MenuLateralAdmin extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: ListView(
          children: <Widget>[
            new UserAccountsDrawerHeader(
              accountName: Text("AUTO PARTS"),
              accountEmail: Text("repuestos.support@gmail.com"),
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/imagenes/logo_1.png'),
                      fit: BoxFit.cover
                  )
              ),
            ),
            Ink(
              color: Colors.indigo,
              child: new ListTile(
                title: Text("INICIO", style: TextStyle(color: Colors.white),),
                onTap: (){
                Navigator.pushNamed(context, '/');
              },
              ),
            ),
            new ListTile(
              title: Text("NUEVO PRODUCTO"),
              onTap: (){
                Navigator.pushNamed(context, '/nuevo_producto_page');
              },
            ),
            new ListTile(
              title: Text("NUEVA SUCURSAL"),
              onTap: (){
                Navigator.pushNamed(context, '/nueva_sucursal_page');
              },
            ),
            new ListTile(
              title: Text("UBICACIONES"),
              onTap: (){
                Navigator.pushNamed(context, '/ubicaciones_page');
              },
            ),
            new ListTile(
              title: Text("ROLES"),
              onTap: (){
                Navigator.pushNamed(context, '/roles_page');
              },
            ),
            new ListTile(
              title: Text("USUARIOS"),
              onTap: (){
                Navigator.pushNamed(context, '/usuarios_page');
              },
            )

          ],
        ) ,
    );
  }
}
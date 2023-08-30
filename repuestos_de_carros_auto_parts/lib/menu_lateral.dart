import 'package:flutter/material.dart';

class MenuLateral extends StatelessWidget {
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
            title: Text("SUCURSALES"),
            onTap: (){
              Navigator.pushNamed(context, '/sucursales_Page');
            },
          ),
          new ListTile(
            title: Text("PRODUCTOS"),
            onTap: (){
              Navigator.pushNamed(context, '/productos_page');
            },
          )

        ],
      ) ,
    );
  }
}
import 'package:flutter/material.dart';

class MenuLateral extends StatelessWidget {
  const MenuLateral({super.key});

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
            title: const Text("SUCURSALES"),
            onTap: (){
              Navigator.pushNamed(context, '/sucursales_Page');
            },
          ),
          ListTile(
            title: const Text("PRODUCTOS"),
            onTap: (){
              Navigator.pushNamed(context, '/productos_page');
            },
          )

        ],
      ) ,
    );
  }
}
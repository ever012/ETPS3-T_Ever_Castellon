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
                title: Text("MENU 1", style: TextStyle(color: Colors.white),),
              ),
            ),
            new ListTile(
              title: Text("MENU 2"),
              onTap: (){},
            ),
            new ListTile(
              title: Text("MENU 3"),
            ),
            new ListTile(
              title: Text("MENU 4"),
            )

          ],
        ) ,
    );
  }
}
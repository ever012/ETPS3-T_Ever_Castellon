import 'package:flutter/material.dart';

class AppBarPersonalizada extends StatelessWidget implements PreferredSizeWidget {
  @override
  Size get preferredSize => const Size.fromHeight(210.0);

  @override
  Widget build(BuildContext context) {
    return PreferredSize(
      preferredSize: const Size.fromHeight(210.0),
      child: AppBar(
        foregroundColor: Colors.white,
        backgroundColor: const Color.fromARGB(255, 238, 238, 238),
        title: const Text(""),
        actions: [
          IconButton(
            icon: const Icon(Icons.person, size: 40.0,),
            onPressed: () {
              // Aquí agregar la funcionalidad del botón de usuario
              Navigator.pushNamed(context, '/login_page');
            },
          ),
        ],
        flexibleSpace: ClipRRect(
          borderRadius: const BorderRadius.only(
            bottomLeft: Radius.circular(0.0),
            bottomRight: Radius.circular(0.0),
          ),
          child: Stack(
            children: [
              Positioned(
                top: 0,
                left: -4,
                child: Image.asset('assets/imagenes/logoautoparts.png',
                  fit: BoxFit.cover,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

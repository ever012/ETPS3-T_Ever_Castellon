import 'package:flutter/material.dart';
import 'package:repuestos_de_carros_auto_parts/menu_lateral.dart';

class LoginPage extends StatefulWidget {
  static String id = "login_page";

  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late TextEditingController _emailController;
  late TextEditingController _passwordController;
  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController(text: "correo@gmail.com");
    _passwordController = TextEditingController(text: "123456");
  }

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }



  //crear una notificacion en la parte inferior de la app
  void _showNotification(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            appBar: PreferredSize(
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
                flexibleSpace: Stack(
                  children: [
                    Positioned(
                      top: 0,
                      left: -4,
                      child: Image.asset(
                        'assets/imagenes/logoautoparts.png',
                        width: 370.0,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            drawer: const MenuLateral(),
            body: SingleChildScrollView(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center, //lo deja todo como centrado son necesidad de darle padding top
                  children: [
                    const SizedBox(height: 15.0,),
                    const Text("Iniciar Sesión", style: TextStyle(fontSize: 30.0,color: Colors.red),),
                    const SizedBox(height: 15.0,),
                    _userTextField(),
                    const SizedBox(height: 15.0,),
                    _passwordTextField(),
                    const SizedBox(height: 15.0,),
                    _botonLogin(),
                    const SizedBox(height: 15.0,),
                    const Align(alignment: Alignment.centerRight,
                      child: Text("Ir al inicio...",
                        style: TextStyle(fontSize: 20.0, color: Colors.grey),),
                    ),
                    const SizedBox(height: 140.0,),
                    const Align(alignment: Alignment.bottomLeft,
                      child: Text("Crear Cuenta...",
                        style: TextStyle(fontSize: 20.0, color: Colors.grey),),
                    ),
                    const Align(alignment: Alignment.bottomLeft,
                      child: Text("Recuperar Contraseña...",
                        style: TextStyle(fontSize: 15.0, color: Colors.grey),),
                    ),
                  ],
                ),
              ),
            )


        )
    );


  }

  Widget _userTextField() {
    return StreamBuilder(
        stream: null,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          return Container(
            padding: const EdgeInsets.symmetric(horizontal: 5.0),
            child: TextField(
              controller: _emailController,
              keyboardType: TextInputType.emailAddress, //pone por defecto el teclado con arroba y demas
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                icon: Icon(Icons.email),
                hintText: 'Usuario/Correo',
                labelText: 'Correo electronico',
                labelStyle: TextStyle(color: Colors.black),
                focusColor: Colors.teal,
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black), // Cambio de color a negro

                ),
              ),

              onChanged: (value) {},

            ),
          );
        });
  }

  Widget _passwordTextField() {
    return StreamBuilder(
        stream: null,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          return Container(
            padding: const EdgeInsets.symmetric(horizontal: 5.0),
            child: TextField(
              controller: _passwordController,
              keyboardType: TextInputType.text,
              obscureText: true,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                icon: Icon(Icons.lock),
                hintText: 'Contraseña',
                labelText: 'Contraseña',
                labelStyle: TextStyle(color: Colors.black),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black), // Cambio de color a negro
                ),
              ),
              onChanged: (value) {},
            ),
          );
        });
  }

  Widget _botonLogin() {
    return StreamBuilder(
        stream: null,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          final ButtonStyle raisedButtonStyle = ElevatedButton.styleFrom(
              backgroundColor: const Color.fromARGB(255, 39, 83, 89),
              foregroundColor: Colors.white,
              minimumSize: const Size(88, 36),
            padding: const EdgeInsets.symmetric(horizontal: 16),
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(30)),
            ),
            elevation: 10.0, //da como un sombredado al boton
          );

          return ElevatedButton(
            style: raisedButtonStyle,
            onPressed: (){
              if (_emailController.text == "" || _passwordController.text == "") {
                _showNotification('Ingrese correo y/o contraseña');
              }else {
                if (_emailController.text == 'correo@gmail.com' &&
                    _passwordController.text == '123456') {
                  _showNotification('Datos correctos');
                } else {
                  _showNotification('Credenciales incorrectas');
                }
              }
            },
            child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 40.0, vertical: 15.0),
                width: 200,
                child: const Row(
                  children: [
                    Icon(
                      Icons.arrow_forward, // Cambia este valor por el icono que desees usar
                      size: 30.0,
                      color: Colors.blue, // Cambia el color del icono si es necesario
                    ),
                    SizedBox(width: 10.0), // Agregamos un espacio entre el icono y el texto
                    Text(
                      'Iniciar',
                      style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
            ),
          );
        });
  }
}

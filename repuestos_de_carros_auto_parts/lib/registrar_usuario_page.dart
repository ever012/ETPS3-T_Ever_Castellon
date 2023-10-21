import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:repuestos_de_carros_auto_parts/appBar.dart';
import 'package:repuestos_de_carros_auto_parts/menu_lateral.dart';

import 'api_config.dart';

class RegistrarPage extends StatefulWidget {
  static String id = "login_page";

  const RegistrarPage({super.key});

  @override
  State<RegistrarPage> createState() => _RegistrarPageState();
}

class _RegistrarPageState extends State<RegistrarPage> {
  late TextEditingController _userController;
  late TextEditingController _emailController;
  late TextEditingController _passwordController;
  bool passwordVisible=false;

  @override
  void initState() {
    super.initState();
    passwordVisible=true;
    _userController = TextEditingController(text: "ever");
    _emailController = TextEditingController(text: "correo@gmail.com");
    _passwordController = TextEditingController(text: "123456789");
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
            appBar: AppBarPersonalizada(),
            drawer: const MenuLateral(),
            body: SingleChildScrollView(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(height: 15.0,),
                    const Text("Regístrate", style: TextStyle(fontSize: 30.0,color: Colors.black,fontWeight: FontWeight.bold),),
                    const SizedBox(height: 15.0,),
                    const Align(alignment: Alignment.center,
                      child: Text("Registrate con tu correo electronico",
                        style: TextStyle(fontSize: 16.0, color: Color(0xff7B8799)),),
                    ),
                    const SizedBox(height: 15.0,),
                    _userTextField(),
                    const SizedBox(height: 15.0,),
                    _passwordTextField(),
                    const SizedBox(height: 15.0,),
                    _EmailTextField(),
                    const SizedBox(height: 15.0,),
                    _botonRegistrar(),
                    const SizedBox(height: 15.0,),
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
              controller: _userController,
              keyboardType: TextInputType.text, //pone por defecto el teclado con arroba y demas
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                prefixIcon: Image.asset('assets/Iconos/correo.png'),
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
              obscureText: passwordVisible,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                prefixIcon: Image.asset('assets/Iconos/candado.png'),
                suffixIcon: IconButton(
                  icon: Icon(passwordVisible
                      ? Icons.visibility
                      : Icons.visibility_off),
                  onPressed: () {
                    setState(
                          () {
                        passwordVisible = !passwordVisible;
                      },
                    );
                  },
                ),
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



  Widget _EmailTextField() {
    return StreamBuilder(
        stream: null,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          return Container(
            padding: const EdgeInsets.symmetric(horizontal: 5.0),
            child: TextField(
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                prefixIcon: Image.asset('assets/Iconos/candado.png'),
                hintText: 'Email',
                labelText: 'Email',
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



  Widget _botonRegistrar() {
    return StreamBuilder(
        stream: null,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          final ButtonStyle raisedButtonStyle = ElevatedButton.styleFrom(
            backgroundColor: Colors.black,
            foregroundColor: Colors.white,
            minimumSize: const Size(350, 30),
            padding: const EdgeInsets.symmetric(horizontal: 16),
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
            elevation: 10.0, //da como un sombredado al boton
          );

          return ElevatedButton(
            style: raisedButtonStyle,
            onPressed: () async {
              if (_emailController.text == "" || _passwordController.text == "") {
                _showNotification('Ingrese correo y/o contraseña');
              } else {
                // Obtener el usuario y la contraseña del controlador de texto
                String usuario = _userController.text;
                String password = _passwordController.text;
                String email = _emailController.text;

                // Construir el URI de la solicitud POST con los parámetros
                var uri = Uri.parse('${ApiConfig.apiUrl}api/login/registroUsuario?usuario=$usuario&password=$password&email=$email');

                // Realizar la solicitud POST a la API
                var response = await http.post(uri, headers: {'Content-Type': 'application/json'});
debugPrint("HOLAAA:" +uri.toString());
                // Verificar el código de estado de la respuesta
                if (response.statusCode == 200) {
                  // Analizar la respuesta JSON
                  var jsonResponse = response.body;
                  _showNotification('USUARIO CREADO CORRECTAMENTE');
                  // Navegar a la página principal con los datos del usuario
                  Navigator.pushNamed(context, '/login_page');
                } else {
                  _showNotification('Credenciales incorrectas');
                }
              }
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 15.0),
              width: 200,
              child: Row(
                children: [

                  SizedBox(width: 10.0), // Agregamos un espacio entre el icono y el texto
                  Text(
                    'Registrarse',
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(width: 15.0),
                  Image.asset("assets/Iconos/ingresar.png",),
                ],
              ),
            ),
          );
        });
  }
}

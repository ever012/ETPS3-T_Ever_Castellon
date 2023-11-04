import 'package:flutter/material.dart';
import 'package:repuestos_de_carros_auto_parts/appBar.dart';
import 'package:repuestos_de_carros_auto_parts/menu_lateral.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../api_config.dart';

class LoginPage extends StatefulWidget {
  static String id = "login_page";

  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late TextEditingController _emailController;
  late TextEditingController _passwordController;
  bool passwordVisible = false;
  late SharedPreferences _prefs;

  @override
  void initState() {
    super.initState();
    passwordVisible = true;
    _emailController = TextEditingController(text: "");
    _passwordController = TextEditingController(text: "");
    SharedPreferences.getInstance().then((prefs) {
      _prefs = prefs;
    });
  }

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  // Crear una notificación en la parte inferior de la app
  void _showNotification(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(

            drawer: const MenuLateral(),
            body: CustomScrollView(
              slivers: <Widget>[
                const SliverAppBar(
                  title: Text(""),
                  floating: true,
                  expandedHeight: 210.0,
                  backgroundColor: Color.fromARGB(255, 238, 238, 238),
                  flexibleSpace: AppBarPersonalizada(),
                ),
                SliverToBoxAdapter(
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const SizedBox(height: 15.0,),
                        const Text("Iniciar Sesión", style: TextStyle(fontSize: 32),),
                        const SizedBox(height: 15.0,),
                        _userTextField(),
                        const SizedBox(height: 15.0,),
                        _passwordTextField(),
                        const SizedBox(height: 15.0,),
                        _botonLogin(),
                        const SizedBox(height: 15.0,),
                        _IrAInicioTextField(),
                        const SizedBox(height: 15.0,),
                              _crearCuentaTextField(),
                          const Align(
                            alignment: Alignment.bottomLeft,
                            child: Text(
                              "Recuperar Contraseña...",
                            style: TextStyle(fontSize: 15.0, color: Colors.grey),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
        ));
  }

  Widget _userTextField() {
    return StreamBuilder(
        stream: null,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          return Container(
            padding: const EdgeInsets.symmetric(horizontal: 5.0),
            child: TextField(
              controller: _emailController,
              keyboardType: TextInputType.text, //pone por defecto el teclado con arroba y demas
              decoration: InputDecoration(
                border: const OutlineInputBorder(),
                prefixIcon: Image.asset('assets/Iconos/correo.png'),
                hintText: 'Usuario',
                labelText: 'Usuario',
                labelStyle: const TextStyle(color: Colors.black),

                focusColor: Colors.teal,
                focusedBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black), // Cambio de color a negro

                ),
              ),

              onChanged: (value) {

              },

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
                border: const OutlineInputBorder(),
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
                labelStyle: const TextStyle(color: Colors.black),
                focusedBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black), // Cambio de color a negro
                ),
              ),
              onChanged: (value) {},
            ),
          );
        });
  }


  Widget _crearCuentaTextField() {
    return StreamBuilder(
        stream: null,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          return Container(
            padding: const EdgeInsets.symmetric(horizontal: 5.0),
            child: InkWell(
              onTap: () {
                Navigator.pushNamed(context, '/registrar_usuario_page');
              },
              child: const Align(alignment: Alignment.bottomLeft,
                child: Text("Crear Cuenta...",
                  style: TextStyle(fontSize: 20.0, color: Colors.grey),),
              ),
            ),
          );
        });
  }



  Widget _IrAInicioTextField() {
    return StreamBuilder(
        stream: null,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          return Container(
            padding: const EdgeInsets.symmetric(horizontal: 5.0),
            child: InkWell(
              onTap: () {
                Navigator.pushNamed(context, '/');
              },
              child: const Align(alignment: Alignment.centerRight,
                child: Text("Ir al inicio...",
                  style: TextStyle(fontSize: 20.0, color: Colors.grey),),
              ),
            ),
          );
        });
  }



  Widget _botonLogin() {
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
                // Construir el cuerpo de la solicitud POST
                Map<String, dynamic> body = {
                  'usuario': _emailController.text,
                  'password': _passwordController.text,
                };

                // Realizar la solicitud POST a la API
                var response = await http.post(Uri.parse('${ApiConfig.apiUrl}api/login'),
                    body: json.encode(body),
                    headers: {'Content-Type': 'application/json'});

                // Verificar el código de estado de la respuesta
                if (response.statusCode == 200) {
                  // Analizar la respuesta JSON
                  var jsonResponse = json.decode(response.body);

                  // Guardar el token y el usuario en SharedPreferences
                  await _prefs.setString('token', jsonResponse['token']);
                  await _prefs.setString('usuario', jsonResponse['usuario']);
                  await _prefs.setString('email', jsonResponse['email']);

                  _showNotification('Inicio de sesión exitoso');

                  // Navegar a la página principal con los datos del usuario
                  Navigator.pushNamed(context, '/', arguments: {
                    'id': 1,
                    'nombre': jsonResponse['usuario'],
                    'token': jsonResponse['token'],
                  });
                } else {
                  _showNotification('Credenciales incorrectas');
                }
              }
            },
            child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 40.0, vertical: 15.0),
                width: 200,
                child: Row(
                  children: [

                    const SizedBox(width: 10.0), // Agregamos un espacio entre el icono y el texto
                    const Text(
                      'Iniciar',
                      style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(width: 1.0),
                    Image.asset("assets/Iconos/ingresar.png",),
                  ],
                ),
            ),
          );
        });
  }
}

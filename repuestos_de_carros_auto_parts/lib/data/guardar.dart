import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiHelper {
  final String apiUrl;

  ApiHelper(this.apiUrl);

  Future<void> enviarDatos({
    required TextEditingController codigoController,
    required TextEditingController nombreController,
    required TextEditingController longitudController,
    required TextEditingController latitudController,
    required Function(String) showNotification,
  }) async {
    final Map<String, dynamic> datos = {
      'codigo': codigoController,
      'nombre': nombreController,
      'longitud': longitudController,
      'latitud': latitudController,
    };

    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        body: jsonEncode(datos),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        showNotification('Datos guardados correctamente');
      } else {
        showNotification('Error al guardar los datos. Por favor, inténtalo de nuevo.');
      }
    } catch (e) {
      print('Error: $e');
      showNotification('Error al enviar la solicitud. Por favor, verifica tu conexión a internet.');
    }
  }
}
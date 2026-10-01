import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:sistema_fichajes/models/fichaje.dart';

class AlmacenFichajes {
  static const _clave = 'fichajes';

  Future<void> guardar(List<Fichaje> fichajes) async {
    final prefs = await SharedPreferences.getInstance();
    final jsonTexto = jsonEncode(
      fichajes.map((fichaje) => fichaje.toJson()).toList(),
    );
    await prefs.setString(_clave, jsonTexto);
  }

  Future<List<Fichaje>> cargar() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonText = prefs.getString(_clave) ?? '[]';
    return (jsonDecode(jsonText) as List<dynamic>)
        .map((fichaje) => Fichaje.fromJson(fichaje as Map<String, dynamic>))
        .toList();
  }
}

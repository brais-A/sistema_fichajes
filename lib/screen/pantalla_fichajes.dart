import 'package:flutter/material.dart';
import 'package:sistema_fichajes/models/Fichaje.dart';
import 'package:sistema_fichajes/utils/formato.dart';

class PantallaFichajes extends StatefulWidget {
  const PantallaFichajes({Key? key}) : super(key: key);
  @override
  State<PantallaFichajes> createState() => _PantallaFichajesState();
}

class _PantallaFichajesState extends State<PantallaFichajes> {
  final List<Fichaje> _fichajes = [];
  bool get _tocaEntrar => _fichajes.isEmpty || _fichajes.last.isFinished;

  void _fichar() {
    setState(() {
      if (_tocaEntrar) {
        _fichajes.add(Fichaje(entrada: DateTime.now()));
      } else {
        _fichajes.last.salida = DateTime.now();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Fichajes', textAlign: TextAlign.center),
      ),
      body: _fichajes.isEmpty
          ? const Center(
              child: Text(
                'Aún no hay fichajes.Pulsa el botón para añadir un fichaje.',
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.only(bottom: 80),
              itemCount: _fichajes.length,
              itemBuilder: (context, index) {
                final fichaje = _fichajes[index];
                return ListTile(
                  title: Text(formatearHora(fichaje.entrada)),
                  subtitle: Text(
                    fichaje.isFinished
                        ? formatearHora(fichaje.salida!)
                        : 'En curso',
                  ),
                  trailing: Text(formatearDuration(fichaje.duracion)),
                );
              },
            ),
      floatingActionButton: FloatingActionButton.extended(
        label: Text(_tocaEntrar ? 'Entrar' : 'Terminar'),
        onPressed: _fichar,
      ),
    );
  }
}

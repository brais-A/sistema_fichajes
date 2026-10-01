import 'package:flutter/material.dart';
import 'package:sistema_fichajes/models/fichaje.dart';
import 'package:sistema_fichajes/services/almacen_fichajes.dart';
import 'package:sistema_fichajes/utils/formato.dart';

import "dart:async";

class PantallaFichajes extends StatefulWidget {
  const PantallaFichajes({Key? key}) : super(key: key);
  @override
  State<PantallaFichajes> createState() => _PantallaFichajesState();
}

class _PantallaFichajesState extends State<PantallaFichajes> {
  List<Fichaje> _fichajes = [];
  late Timer _timer;
  final _almacen = AlmacenFichajes();

  Future<void> _cargarFichajes() async {
    _fichajes = await _almacen.cargar();
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    _cargarFichajes();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (!_tocaEntrar) {
        setState(() {});
      }
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  bool get _tocaEntrar => _fichajes.isEmpty || _fichajes.last.isFinished;

  Duration get _totalHoy {
    var total = Duration.zero;
    for (final fichaje in _fichajes) {
      if (fichaje.esDeHoy) {
        total += fichaje.duracion;
      }
    }
    return total;
  }

  void _fichar() {
    setState(() {
      //Si toca entrar, se añade un fichaje
      if (_tocaEntrar) {
        _fichajes.add(Fichaje(entrada: DateTime.now()));
      } else {
        _fichajes.last.salida = DateTime.now();
      }
    });
    _almacen.guardar(_fichajes);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Fichajes')),
      body: Column(
        children: [
          if (_fichajes.isNotEmpty)
            Padding(
              padding: const EdgeInsets.all(16),
              child: Text(
                'Hoy llevas ${formatearDuracion(_totalHoy)}',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
            ),
          Expanded(
            child: _fichajes.isEmpty
                ? const Center(
                    child: Text(
                      'Aún no hay fichajes. Pulsa el botón para añadir un fichaje.',
                      textAlign: TextAlign.center,
                    ),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.only(bottom: 80),
                    itemCount: _fichajes.length,
                    itemBuilder: (context, index) {
                      final fichaje = _fichajes[index];
                      return ListTile(
                        title: Row(
                          children: [
                            Icon(Icons.login, color: Colors.green, size: 20),
                            const SizedBox(width: 5),
                            Text(formatearHora(fichaje.entrada)),
                          ],
                        ),
                        subtitle: Row(
                          children: [
                            Icon(
                              fichaje.isFinished ? Icons.logout : Icons.timer,
                              color: fichaje.isFinished
                                  ? Colors.grey
                                  : Colors.orange,
                              size: 20,
                            ),
                            SizedBox(width: 5),
                            Text(
                              fichaje.isFinished
                                  ? formatearHora(fichaje.salida!)
                                  : 'En curso',
                            ),
                          ],
                        ),
                        trailing: Text(formatearDuracion(fichaje.duracion)),
                      );
                    },
                  ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        label: Text(_tocaEntrar ? 'Entrar' : 'Terminar'),
        onPressed: _fichar,
      ),
    );
  }
}

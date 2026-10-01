import 'package:flutter/material.dart';
import 'package:sistema_fichajes/models/fichaje.dart';
import 'package:sistema_fichajes/utils/formato.dart';

class PantallaHistorial extends StatelessWidget {
  final List<Fichaje> fichajes;
  const PantallaHistorial({super.key, required this.fichajes});

  @override
  Widget build(BuildContext context) {
    final Map<DateTime, List<Fichaje>> fichajesPorDia = {};
    for (final fichaje in fichajes) {
      final dia = fichaje.dia;
      if (!fichajesPorDia.containsKey(dia)) {
        fichajesPorDia[dia] = [];
      }
      fichajesPorDia[dia]!.add(fichaje);
    }

    final dias = fichajesPorDia.keys.toList();
    dias.sort((a, b) => b.compareTo(a));

    return ListView.builder(
      itemCount: dias.length,
      itemBuilder: (context, index) {
        final dia = dias[index];
        final fichajesDia = fichajesPorDia[dia]!;
        var total = Duration.zero;
        for (final fichaje in fichajesDia) {
          total += fichaje.duracion;
        }

        return ListTile(
          title: Text(formatearFecha(dia)),
          trailing: Text(formatearDuracion(total)),
        );
      },
    );
  }
}

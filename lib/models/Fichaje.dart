///El fichaje representa el tramo de entrada y de salida, no de un dia entero
class Fichaje {
  final DateTime entrada;

  ///Salida siempre es null mientras el fichaje está en curso,ke rellena al fichar la salida
  DateTime? salida;

  Fichaje({required this.entrada, this.salida});

  ///Si aun no se ha fichado la salida, cuenta hasta aquí
  Duration get duracion {
    final fin = salida ?? DateTime.now();
    return fin.difference(entrada);
  }

  bool get isFinished => salida != null;

  ///Hay que comparar también mes y año; si no dos días de diferente mes pueden contar en el mismo día
  bool get esDeHoy {
    final hoy = DateTime.now();
    return entrada.day == hoy.day &&
        entrada.month == hoy.month &&
        entrada.year == hoy.year;
  }
}

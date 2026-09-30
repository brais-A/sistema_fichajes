class Fichaje {
  final DateTime entrada;
  DateTime? salida;

  Fichaje({required this.entrada, this.salida});

  Duration get duration {
    final fin = salida ?? DateTime.now();
    //Devolvemos a diferencia entre las dos horas
    return fin.difference(entrada);
  }

  bool get isFinished => salida != null;
}

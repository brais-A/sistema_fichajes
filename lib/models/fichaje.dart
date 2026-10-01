///El fichaje representa el tramo de entrada y de salida, no de un dia entero
class Fichaje {
  final DateTime entrada;

  ///Salida siempre es null mientras el fichaje está en curso,se rellena al fichar la salida
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

  Map<String, dynamic> toJson() {
    return {
      'entrada': entrada.toIso8601String(),
      'salida': salida?.toIso8601String(),
    };
  }

  factory Fichaje.fromJson(Map<String, dynamic> json) {
    return Fichaje(
      //Convierte json de texto a DateTime
      ///Crea un fichaje a partir del Map generado por el toJson
      entrada: DateTime.parse(json['entrada'] as String),
      //Lo mismo pero salida puede ser null
      salida: json['salida'] != null
          ? DateTime.parse(json['salida'] as String)
          : null,
    );
  }
}

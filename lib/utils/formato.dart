String ponerCeros(int n) => n.toString().padLeft(2, '0');

String formatearHora(DateTime fecha) {
  return '${ponerCeros(fecha.hour)}:${ponerCeros(fecha.minute)}';
}

String formatearDuration(Duration duracion) {
  final segundos = duracion.inSeconds % 60;
  final minutos = duracion.inMinutes % 60;
  final horas = duracion.inHours;
  return '${ponerCeros(horas)}:${ponerCeros(minutos)}:${ponerCeros(segundos)}';
}

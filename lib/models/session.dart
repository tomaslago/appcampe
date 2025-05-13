class SesionAcampe {
  final DateTime inicio;
  final DateTime fin;

  SesionAcampe({required this.inicio, required this.fin});

  Duration get duracion => fin.difference(inicio);
  double get horas => duracion.inMinutes / 60;
}

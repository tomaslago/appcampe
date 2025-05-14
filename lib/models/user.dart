import 'session.dart';

class AcampeUser {
  final String name;
  final List<SesionAcampe> sesiones;

  AcampeUser({required this.name, List<SesionAcampe>? sesiones})
      : sesiones = sesiones ?? [];

  void agregarSesion(SesionAcampe sesion) {
    sesiones.add(sesion);
  }

 double get horasTotales {
  if (sesiones.isEmpty) return 0;

  // Ordenamos por inicio
  final ordenadas = List<SesionAcampe>.from(sesiones)
    ..sort((a, b) => a.inicio.compareTo(b.inicio));

  final List<SesionAcampe> unificadas = [];
  var actual = ordenadas.first;

  for (var i = 1; i < ordenadas.length; i++) {
    final siguiente = ordenadas[i];

    if (siguiente.inicio.isBefore(actual.fin)) {
      // Se superpone o toca: extendemos el bloque actual
      final nuevoFin = siguiente.fin.isAfter(actual.fin) ? siguiente.fin : actual.fin;
      actual = SesionAcampe(inicio: actual.inicio, fin: nuevoFin);
    } else {
      unificadas.add(actual);
      actual = siguiente;
    }
  }

  unificadas.add(actual); // Agregamos el último bloque

  return unificadas.fold(0.0, (suma, s) => suma + s.horas);
}

}

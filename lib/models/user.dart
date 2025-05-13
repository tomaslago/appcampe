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
    return sesiones.fold(0, (suma, s) => suma + s.horas);
  }
}

import 'user.dart';

class Carp {
  final String name;
  final List<AcampeUser> users;
  final DateTime inicioAcampe;

  Carp({required this.name, required this.users, required this.inicioAcampe});

  List<AcampeUser> get ranking {
    final sorted = [...users];
    sorted.sort((a, b) => b.horasTotales.compareTo(a.horasTotales));
    return sorted;
  }

  int get diasTotales => DateTime.now().isAfter(inicioAcampe)
      ? DateTime.now().difference(inicioAcampe).inDays + 1
      : 0;

  int diasRestantes(DateTime showDate) {
    return showDate.difference(DateTime.now()).inDays;
  }

  double progreso(DateTime showDate) {
  final hoy = DateTime.now();
  final total = showDate.difference(inicioAcampe).inDays;

  if (hoy.isBefore(inicioAcampe)) return 0;
  if (hoy.isAfter(showDate)) return 1;

  final transcurridos = hoy.difference(inicioAcampe).inDays;
  return (transcurridos / total).clamp(0.0, 1.0);
}

}


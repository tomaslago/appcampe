import 'user.dart';

class Carp {
  final String name;
  final List<AcampeUser> users;

  Carp({required this.name, required this.users});

  void addUser(AcampeUser user) {
    users.add(user);
  }

  // Esta función ya no se usa con la lógica nueva (horas se calculan desde sesiones)
  void addHorasToUser(String name, double horas) {
    // se podría registrar como una sesión real en el futuro si querés
  }

  List<AcampeUser> get ranking {
    final sorted = [...users];
    sorted.sort((a, b) => b.horasTotales.compareTo(a.horasTotales));
    return sorted;
  }
}

import 'package:flutter/material.dart';
import '../models/carp.dart';
import '../models/user.dart';
import '../models/session.dart';

class SesionesCalendarScreen extends StatelessWidget {
  final Carp carpa;

  const SesionesCalendarScreen({super.key, required this.carpa});

  @override
  Widget build(BuildContext context) {
    final sesionesPorUsuario = carpa.users;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Historial de sesiones'),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: sesionesPorUsuario.length,
        itemBuilder: (context, index) {
          final user = sesionesPorUsuario[index];
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(user.name, style: Theme.of(context).textTheme.titleLarge),
              const SizedBox(height: 8),
              Column(
                children: user.sesiones.map((sesion) {
                  return Row(
                    children: [
                      const Icon(Icons.timer, size: 16),
                      const SizedBox(width: 8),
                      Text(
                        '${sesion.inicio.day}/${sesion.inicio.month} ${sesion.inicio.hour}:${sesion.inicio.minute.toString().padLeft(2, '0')}'
                        ' → '
                        '${sesion.fin.hour}:${sesion.fin.minute.toString().padLeft(2, '0')}',
                      ),
                    ],
                  );
                }).toList(),
              ),
              const Divider(height: 32),
            ],
          );
        },
      ),
    );
  }
}

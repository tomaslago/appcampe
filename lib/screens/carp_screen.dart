import 'package:flutter/material.dart';
import '../models/recital.dart';
import '../models/user.dart';
import '../models/carp.dart';
import '../models/session.dart';
import 'add_sesion_screen.dart';

class CarpScreen extends StatefulWidget {
  final Recital recital;

  const CarpScreen({super.key, required this.recital});

  @override
  State<CarpScreen> createState() => _CarpScreenState();
}

class _CarpScreenState extends State<CarpScreen> {
  late Carp carpa;

  @override
  void initState() {
    super.initState();
    carpa = Carp(
      name: widget.recital.nombre,
      users: [
        AcampeUser(name: "Lucía"),
        AcampeUser(name: "Nico"),
        AcampeUser(name: "Rami"),
      ],
    );
  }

  void _agregarSesion(AcampeUser user) async {
    final sesion = await Navigator.of(context).push<SesionAcampe>(
      MaterialPageRoute(builder: (ctx) => const AddSesionScreen()),
    );

    if (sesion != null) {
      setState(() {
        user.agregarSesion(sesion);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final ranking = carpa.ranking;

    return Scaffold(
      appBar: AppBar(title: Text(widget.recital.nombre)),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView.builder(
          itemCount: ranking.length,
          itemBuilder: (context, index) {
            final user = ranking[index];
            return Card(
              margin: const EdgeInsets.only(bottom: 16),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 24,
                      backgroundColor: Colors.indigo.shade100,
                      child: Text('${index + 1}'),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(user.name, style: Theme.of(context).textTheme.titleLarge),
                          const SizedBox(height: 4),
                          Text('Horas acumuladas: ${user.horasTotales.toStringAsFixed(1)}'),
                        ],
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.timer),
                      onPressed: () => _agregarSesion(user),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          // futuro: cargar sesión propia
        },
        icon: const Icon(Icons.access_time),
        label: const Text('Cargar sesión'),
      ),
    );
  }
}

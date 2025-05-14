import 'package:flutter/material.dart';
import '../models/recital.dart';
import '../models/user.dart';
import '../models/carp.dart';
import '../models/session.dart';
import 'add_sesion_screen.dart';
import 'sesiones_calendar_screen.dart';

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
        AcampeUser(name: "Pato"),
        AcampeUser(name: "Guido"),
        AcampeUser(name: "Gastón"),
      ],
      inicioAcampe: DateTime(2025, 5, 1),
    );
  }

  void _abrirFormularioSesion() async {
    await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (ctx) => AddSesionScreen(usuarios: carpa.users),
      ),
    );
    setState(() {});
  }

  void _mostrarDialogoAgregarUsuario() {
    final controller = TextEditingController();

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text("Nuevo acampante"),
        content: TextField(
          controller: controller,
          decoration: const InputDecoration(labelText: "Nombre"),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(),
            child: const Text("Cancelar"),
          ),
          ElevatedButton(
            onPressed: () {
              final nombre = controller.text.trim();
              if (nombre.isNotEmpty) {
                setState(() {
                  carpa.users.add(AcampeUser(name: nombre));
                });
                Navigator.of(ctx).pop();
              }
            },
            child: const Text("Agregar"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final ranking = carpa.ranking;
    final diasRestantes = carpa.diasRestantes(widget.recital.fecha);
    final progreso = carpa.progreso(widget.recital.fecha);

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.recital.nombre),
        actions: [
          IconButton(
            icon: const Icon(Icons.calendar_month),
            tooltip: 'Ver historial',
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (ctx) => SesionesCalendarScreen(carpa: carpa),
                ),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.person_add),
            tooltip: 'Agregar persona',
            onPressed: _mostrarDialogoAgregarUsuario,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "⛺ El acampe comenzó el ${carpa.inicioAcampe.day}/${carpa.inicioAcampe.month}",
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 8),
            Text("Progreso del acampe: ${(progreso * 100).toStringAsFixed(1)}%"),
            const SizedBox(height: 8),
            LinearProgressIndicator(value: progreso),
            const SizedBox(height: 16),
            Text(
              diasRestantes > 0
                  ? "🕒 ¡Faltan $diasRestantes días!"
                  : "🎸 ¡Es hoy!",
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 24),
            Expanded(
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
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _abrirFormularioSesion,
        icon: const Icon(Icons.access_time),
        label: const Text('Cargar sesión'),
      ),
    );
  }
}

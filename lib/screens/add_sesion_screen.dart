import 'package:flutter/material.dart';
import '../models/session.dart';
import '../models/user.dart';

class AddSesionScreen extends StatefulWidget {
  final List<AcampeUser> usuarios;

  const AddSesionScreen({super.key, required this.usuarios});

  @override
  State<AddSesionScreen> createState() => _AddSesionScreenState();
}

class _AddSesionScreenState extends State<AddSesionScreen> {
  DateTime? _inicio;
  DateTime? _fin;
  final Set<AcampeUser> _seleccionados = {};

  Future<void> _seleccionarFechaHora(bool esInicio) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2024),
      lastDate: DateTime(2030),
    );

    if (pickedDate != null) {
      final TimeOfDay? pickedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
      );

      if (pickedTime != null) {
        final seleccion = DateTime(
          pickedDate.year,
          pickedDate.month,
          pickedDate.day,
          pickedTime.hour,
          pickedTime.minute,
        );

        setState(() {
          esInicio ? _inicio = seleccion : _fin = seleccion;
        });
      }
    }
  }

  String _formatear(DateTime? dt) {
    if (dt == null) return 'Sin seleccionar';
    return '${dt.day}/${dt.month} ${dt.hour.toString().padLeft(2, '0')}:${dt.minute.toString().padLeft(2, '0')}';
  }

  void _guardar() {
    if (_inicio != null && _fin != null && _inicio!.isBefore(_fin!) && _seleccionados.isNotEmpty) {
      final sesion = SesionAcampe(inicio: _inicio!, fin: _fin!);
      for (final user in _seleccionados) {
        user.agregarSesion(sesion);
      }
      Navigator.of(context).pop(); // No devolvemos nada, porque ya se aplica directo
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Completá todos los campos")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Cargar sesión grupal')),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            const Text(
              'Seleccioná horario y personas',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 24),
            Card(
              child: ListTile(
                leading: const Icon(Icons.login),
                title: const Text('Hora de ingreso'),
                subtitle: Text(_formatear(_inicio)),
                trailing: const Icon(Icons.edit),
                onTap: () => _seleccionarFechaHora(true),
              ),
            ),
            const SizedBox(height: 12),
            Card(
              child: ListTile(
                leading: const Icon(Icons.logout),
                title: const Text('Hora de salida'),
                subtitle: Text(_formatear(_fin)),
                trailing: const Icon(Icons.edit),
                onTap: () => _seleccionarFechaHora(false),
              ),
            ),
            const SizedBox(height: 24),
            Expanded(
              child: ListView(
                children: widget.usuarios.map((user) {
                  return CheckboxListTile(
                    title: Text(user.name),
                    value: _seleccionados.contains(user),
                    onChanged: (val) {
                      setState(() {
                        val == true ? _seleccionados.add(user) : _seleccionados.remove(user);
                      });
                    },
                  );
                }).toList(),
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton.icon(
              onPressed: _guardar,
              icon: const Icon(Icons.check),
              label: const Text('Guardar sesión'),
              style: ElevatedButton.styleFrom(
                minimumSize: const Size.fromHeight(50),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

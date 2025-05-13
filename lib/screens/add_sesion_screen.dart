import 'package:flutter/material.dart';
import '../models/session.dart';

class AddSesionScreen extends StatefulWidget {
  const AddSesionScreen({super.key});

  @override
  State<AddSesionScreen> createState() => _AddSesionScreenState();
}

class _AddSesionScreenState extends State<AddSesionScreen> {
  DateTime? _inicio;
  DateTime? _fin;

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
          if (esInicio) {
            _inicio = seleccion;
          } else {
            _fin = seleccion;
          }
        });
      }
    }
  }

  void _guardarSesion() {
    if (_inicio != null && _fin != null && _inicio!.isBefore(_fin!)) {
      final sesion = SesionAcampe(inicio: _inicio!, fin: _fin!);
      Navigator.of(context).pop(sesion);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Fechas inválidas")),
      );
    }
  }

  String _formatearFecha(DateTime? dt) {
    if (dt == null) return 'Sin seleccionar';
    return '${dt.day}/${dt.month} ${dt.hour.toString().padLeft(2, '0')}:${dt.minute.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Nueva sesión')),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            const Text(
              'Cargá tu horario de acampe',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 32),
            Card(
              child: ListTile(
                leading: const Icon(Icons.login),
                title: const Text('Hora de ingreso'),
                subtitle: Text(_formatearFecha(_inicio)),
                trailing: const Icon(Icons.edit),
                onTap: () => _seleccionarFechaHora(true),
              ),
            ),
            const SizedBox(height: 16),
            Card(
              child: ListTile(
                leading: const Icon(Icons.logout),
                title: const Text('Hora de salida'),
                subtitle: Text(_formatearFecha(_fin)),
                trailing: const Icon(Icons.edit),
                onTap: () => _seleccionarFechaHora(false),
              ),
            ),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: _guardarSesion,
                icon: const Icon(Icons.check),
                label: const Text('Guardar sesión'),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

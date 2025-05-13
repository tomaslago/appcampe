import 'package:flutter/material.dart';
import '../models/recital.dart';

class AddRecitalScreen extends StatefulWidget {
  const AddRecitalScreen({super.key});

  @override
  State<AddRecitalScreen> createState() => _AddRecitalScreenState();
}

class _AddRecitalScreenState extends State<AddRecitalScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nombreController = TextEditingController();
  final _lugarController = TextEditingController();
  DateTime? _fecha;

  void _guardarRecital() {
    if (_formKey.currentState!.validate() && _fecha != null) {
      final nuevo = Recital(
        id: DateTime.now().toString(),
        nombre: _nombreController.text,
        lugar: _lugarController.text,
        fecha: _fecha!,
      );
      Navigator.of(context).pop(nuevo); // Devolvemos el nuevo recital
    }
  }

  Future<void> _seleccionarFecha() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2024),
      lastDate: DateTime(2030),
    );
    if (picked != null) {
      setState(() {
        _fecha = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Nuevo recital')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _nombreController,
                decoration: const InputDecoration(labelText: 'Nombre del recital'),
                validator: (value) => value!.isEmpty ? 'Campo obligatorio' : null,
              ),
              TextFormField(
                controller: _lugarController,
                decoration: const InputDecoration(labelText: 'Lugar'),
                validator: (value) => value!.isEmpty ? 'Campo obligatorio' : null,
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      _fecha == null
                          ? 'Sin fecha'
                          : 'Fecha: ${_fecha!.day}/${_fecha!.month}/${_fecha!.year}',
                    ),
                  ),
                  TextButton(
                    onPressed: _seleccionarFecha,
                    child: const Text('Elegir fecha'),
                  ),
                ],
              ),
              const Spacer(),
              ElevatedButton(
                onPressed: _guardarRecital,
                child: const Text('Agregar recital'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

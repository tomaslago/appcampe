import 'package:flutter/material.dart';
import '../models/data/dummy_data.dart';
import '../models/recital.dart';
import 'add_recital_screen.dart';
import 'carp_screen.dart';



class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Appcampe'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () async {
  final nuevo = await Navigator.of(context).push<Recital>(
    MaterialPageRoute(builder: (ctx) => const AddRecitalScreen()),
  );

  if (nuevo != null) {
    recitalesDummy.add(nuevo); // ⚠️ datos en memoria
    (context as Element).markNeedsBuild(); // 🔄 fuerza redibujado
  }
},

          ),
        ],
      ),
      body: ListView.builder(
        itemCount: recitalesDummy.length,
        itemBuilder: (ctx, i) {
          final Recital recital = recitalesDummy[i];
          return ListTile(
            title: Text(recital.nombre),
            subtitle: Text(
              '${recital.lugar} - ${recital.fecha.day}/${recital.fecha.month}/${recital.fecha.year}',
            ),
            onTap: () {
  Navigator.of(context).push(
    MaterialPageRoute(
      builder: (ctx) => CarpScreen(recital: recital),
    ),
  );
},

          );
        },
      ),
    );
  }
}

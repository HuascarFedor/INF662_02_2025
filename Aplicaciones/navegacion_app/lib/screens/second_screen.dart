import 'package:flutter/material.dart';
import 'package:navegacion_app/models/user.dart';

class SecondScreen extends StatelessWidget {
  final String titulo;
  final User user;

  const SecondScreen({super.key, required this.titulo, required this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(titulo)),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Nombre: ${user.nombre}'),
            Text('Edad: ${user.edad}'),
            Text('Email: ${user.email}'),
            const SizedBox(height: 24),
            Row(
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop<String>(
                      context,
                      'Usuario guardado correctamente',
                    );
                  },
                  child: const Text('Guardar y volver'),
                ),
                const SizedBox(width: 12),
                OutlinedButton(
                  onPressed: () => Navigator.pop<String>(context, ''),
                  child: const Text('Cancelar'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

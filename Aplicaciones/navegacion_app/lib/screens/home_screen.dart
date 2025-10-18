import 'package:flutter/material.dart';
import 'package:navegacion_app/models/user.dart';
import 'package:navegacion_app/routes/app_routes.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  Future<void> _irASegundaPantalla(BuildContext context) async {
    // Crear un usuario de ejemplo
    const user = User(nombre: 'Juan', edad: 25, email: 'juan@example.com');

    // Navegar a la segunda pantalla usando rutas con nombre
    final mensaje = await Navigator.of(context).pushNamed<String>(
      AppRoutes.userDetails,
      arguments: const UserDetailsArgs(
        titulo: 'Detalles del Usuario',
        user: user,
      ),
    );

    // Verificar que el widget siga montado después del await
    if (!context.mounted) return;

    // Mostrar el resultado devuelto desde la segunda pantalla
    if (mensaje != null && mensaje.isNotEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(mensaje), duration: const Duration(seconds: 4)),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Pantalla Principal')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Esta es la pantalla principal',
              style: TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => _irASegundaPantalla(context),
              child: const Text('Ir a Segunda Pantalla'),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:navegacion_app/screens/home_screen.dart';
import 'package:navegacion_app/screens/second_screen.dart';
import 'package:navegacion_app/models/user.dart';

/// Clase que centraliza las rutas de la aplicación
abstract class AppRoutes {
  static const String home = '/';
  static const String userDetails = '/user-details';

  static const _errorMsg =
      'Los argumentos para /user-details deben ser de tipo UserDetailsArgs.';

  /// Método que genera las rutas según su nombre
  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case home:
        // Ruta principal
        return MaterialPageRoute<dynamic>(builder: (_) => const HomeScreen());

      case userDetails:
        final args = settings.arguments;
        if (args is! UserDetailsArgs) {
          return _errorRoute(_errorMsg);
        }

        // 🔹 Ruta tipada: devuelve un String como resultado
        return MaterialPageRoute<String>(
          builder: (_) => SecondScreen(titulo: args.titulo, user: args.user),
        );

      default:
        return _errorRoute('Ruta no encontrada: ${settings.name}');
    }
  }

  /// Pantalla de error genérica
  static Route<dynamic> _errorRoute(String message) {
    return MaterialPageRoute<dynamic>(
      builder: (_) => Scaffold(
        appBar: AppBar(title: const Text('Error de navegación')),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Text(
              message,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 16),
            ),
          ),
        ),
      ),
    );
  }
}

/// Argumentos tipados para la ruta de detalles del usuario
class UserDetailsArgs {
  final String titulo;
  final User user;

  const UserDetailsArgs({required this.titulo, required this.user});
}

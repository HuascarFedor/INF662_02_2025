import 'package:flutter/foundation.dart';

@immutable
class User {
  final String nombre;
  final int edad;
  final String email;

  const User({required this.nombre, required this.edad, required this.email});

  Map<String, Object> toMap() => {
    'nombre': nombre,
    'edad': edad,
    'email': email,
  };

  factory User.fromMap(Map<String, Object?> map) => User(
    nombre: (map['nombre'] as String?) ?? '',
    edad: (map['edad'] as int?) ?? 0,
    email: (map['email'] as String?) ?? '',
  );
}

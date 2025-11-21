import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'providers/memo_provider.dart';
import 'pages/memo_list_page.dart';
import 'data/memo_db.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final path = await MemoDb.instance.getDatabasePath();
  print('Ruta completa de la base de datos: $path');

  runApp(
    ChangeNotifierProvider(
      create: (_) => MemoProvider(db: MemoDb.instance),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Memos con Provider + SQLite',
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.teal,
      ),
      home: const MemoListPage(),
    );
  }
}

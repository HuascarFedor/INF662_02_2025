import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'pages/memo_list_page.dart';
import 'providers/memo_provider.dart';

void main(){
  runApp(
    ChangeNotifierProvider(
      create: (_) => MemoProvider(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Memos con Provider',
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.teal,
      ),
      home: const MemoListPage(),
    );
  }
}

import 'package:flutter/material.dart';

void main() => runApp(const AnimacionesApp());

class AnimacionesApp extends StatelessWidget {
  const AnimacionesApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Laboratorio de Animaciones Implícitas',
      theme: ThemeData(useMaterial3: true, colorSchemeSeed: Colors.blue),
      home: const AnimacionesScreen(),
    );
  }
}

class AnimacionesScreen extends StatefulWidget {
  const AnimacionesScreen({super.key});

  @override
  State<AnimacionesScreen> createState() => _AnimacionesScreenState();
}

class _AnimacionesScreenState extends State<AnimacionesScreen> {
  bool _cambio = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Animaciones Implícitas')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 600),
              curve: Curves.easeInOut,
              width: _cambio ? 200 : 100,
              height: _cambio ? 100 : 200,
              decoration: BoxDecoration(
                color: _cambio ? Colors.teal : Colors.orange,
                borderRadius: BorderRadius.circular(_cambio ? 30 : 5),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: _cambio ? 0.5 : 0.7),
                    offset: _cambio ? Offset(0, 8) : Offset(8, 0),
                    blurRadius: _cambio ? 20 : 20,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 40),
            AnimatedAlign(
              alignment: _cambio ? Alignment.center : Alignment.topLeft,
              duration: const Duration(milliseconds: 600),
              curve: Curves.easeInOut,
              child: AnimatedOpacity(
                duration: const Duration(milliseconds: 600),
                opacity: _cambio ? 0.3 : 1.0,
                child: const Text(
                  'Flutter Animations',
                  style: TextStyle(fontSize: 24),
                ),
              ),
            ),
            const SizedBox(height: 40),
            AnimatedScale(
              duration: const Duration(milliseconds: 600),
              curve: Curves.easeInOut,
              scale: _cambio ? 2.0 : 1.0,
              child: const Icon(Icons.star, size: 50),
            ),
            const SizedBox(height: 40),
            AnimatedRotation(
              duration: const Duration(milliseconds: 600),
              curve: Curves.easeInOut,
              turns: _cambio ? 1.0 : 0.0,
              child: const Icon(Icons.refresh, size: 48),
            ),
            const SizedBox(height: 40),
            AnimatedCrossFade(
              firstChild: const Text(
                'Estado A',
                style: TextStyle(fontSize: 20),
              ),
              secondChild: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.check_circle, size: 22),
                  SizedBox(width: 8),
                  Text('Estado B', style: TextStyle(fontSize: 20)),
                ],
              ),
              crossFadeState: _cambio
                  ? CrossFadeState.showSecond
                  : CrossFadeState.showFirst,
              duration: const Duration(milliseconds: 600),
            ),
            const SizedBox(height: 40),
            ElevatedButton(
              onPressed: () => setState(() => _cambio = !_cambio),
              child: const Text('Animar'),
            ),
          ],
        ),
      ),
    );
  }
}

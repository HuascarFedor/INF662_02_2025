import 'package:flutter/material.dart';

void main() => runApp(const LayoutApp());

class LayoutApp extends StatelessWidget {
  const LayoutApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Laboratorio Layout',
      theme: ThemeData(useMaterial3: true, colorSchemeSeed: Colors.indigo),
      home: const LayoutHome(),
    );
  }
}

class LayoutHome extends StatelessWidget {
  const LayoutHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF3F4F9),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              HeaderSection(),
              const SizedBox(height: 20),
              BalanceCard(),
              const SizedBox(height: 20),
              TransactionsList(),
            ],
          ),
        ),
      ),
    );
  }
}

class HeaderSection extends StatelessWidget {
  const HeaderSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const CircleAvatar(
          radius: 24,
          backgroundImage: NetworkImage(
            'https://images.unsplash.com/photo-1544723795-3fb6469f5b39',
          ),
        ),
        const SizedBox(width: 12),
        const Expanded(
          child: Text(
            'Hola, Flutterista!',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
          ),
        ),
        IconButton(onPressed: () {}, icon: const Icon(Icons.more_vert)),
      ],
    );
  }
}

class BalanceCard extends StatelessWidget {
  const BalanceCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.indigo,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: const [
          Text('Balance Actuak', style: TextStyle(color: Colors.white)),
          Text(
            '\$ 1,260.50',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 22,
            ),
          ),
        ],
      ),
    );
  }
}

class TransactionsList extends StatelessWidget {
  const TransactionsList({super.key});

  @override
  Widget build(BuildContext context) {
    final items = [
      {'title': 'Depósito recibido', 'amount': '+\$300'},
      {'title': 'Pago Netflix', 'amount': '-\$45'},
      {'title': 'Compra supermercado', 'amount': '-\$120'},
    ];

    return ListView.builder(
      itemCount: items.length,
      itemBuilder: (context, i) => ListTile(
        leading: const Icon(Icons.payment),
        title: Text(items[i]['title']!),
        trailing: Text(items[i]['amount']!),
      ),
    );
  }
}

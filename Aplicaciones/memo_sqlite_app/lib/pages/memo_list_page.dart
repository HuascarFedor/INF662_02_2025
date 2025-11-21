import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/memo.dart';
import '../providers/memo_provider.dart';

class MemoListPage extends StatefulWidget {
  const MemoListPage({super.key});

  @override
  State<MemoListPage> createState() => _MemoListPageState();
}

class _MemoListPageState extends State<MemoListPage> {
  @override
  void initState() {
    super.initState();
    // Cargar los memos desde SQLite
    Future.microtask(() {
      context.read<MemoProvider>().loadMemos();
    });
  }

  void _openMemoForm(BuildContext context, {Memo? memo}) {
    final isEditing = memo != null;

    final titleController = TextEditingController(text: memo?.title ?? '');
    final contentController = TextEditingController(text: memo?.content ?? '');

    showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          title: Text(isEditing ? 'Editar memo' : 'Nuevo memo'),
          content: SingleChildScrollView(
            child: Column(
              children: [
                TextField(
                  controller: titleController,
                  decoration: const InputDecoration(
                    labelText: 'Título',
                  ),
                ),
                const SizedBox(height: 8),
                TextField(
                  controller: contentController,
                  decoration: const InputDecoration(
                    labelText: 'Contenido',
                  ),
                  maxLines: 3,
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancelar'),
            ),
            ElevatedButton(
              onPressed: () {
                final title = titleController.text.trim();
                final content = contentController.text.trim();

                if (title.isEmpty && content.isEmpty) return;

                final provider = context.read<MemoProvider>();

                if (isEditing) {
                  provider.updateMemo(memo, title, content);
                } else {
                  provider.addMemo(title, content);
                }

                Navigator.of(context).pop();
              },
              child: Text(isEditing ? 'Guardar' : 'Agregar'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final memoProvider = context.watch<MemoProvider>();
    final memos = memoProvider.items;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Memos con Provider + SQLite'),
      ),
      body: memoProvider.isLoading
        ? const Center(child: CircularProgressIndicator(),)
        : memos.isEmpty
          ? const Center(
              child: Text(
                'No hay memos aún.\nToca el botón + para agregar uno.',
                textAlign: TextAlign.center,
              ),
            )
          : ListView.builder(
              itemCount: memos.length,
              itemBuilder: (context, index) {
                final memo = memos[index];
                return ListTile(
                  title: Text(memo.title.isEmpty ? '(Sin título)' : memo.title),
                  subtitle: Text(
                    memo.content,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  onTap: () => _openMemoForm(context, memo: memo), // Editar
                  trailing: IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () {
                      memoProvider.deleteMemo(memo);
                    },
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _openMemoForm(context),
        child: const Icon(Icons.add),
      ),
    );
  }
}

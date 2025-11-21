import 'package:flutter/material.dart';
import '../models/memo.dart';
import '../data/memo_db.dart';

class MemoProvider extends ChangeNotifier {
  final MemoDb db;
  MemoProvider({ required this.db });

  List<Memo> _items = [];
  List<Memo> get items => List.unmodifiable(_items);

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  Future<void> loadMemos() async {
    _isLoading = true;
    notifyListeners();

    _items = await db.getAllMemos();

    _isLoading = false;
    notifyListeners();
  }

  Future<void> addMemo(String title, String content) async {
    final memo = Memo(
      title: title,
      content: content,
    );
    final id = await db.insertMemo(memo);
    memo.id = id;

    _items.insert(0, memo);
    notifyListeners();
  }

  Future<void> updateMemo(Memo memo, String title, String content) async {
    memo.title = title;
    memo.content = content;
    await db.updateMemo(memo);
    notifyListeners();
  }

  Future<void> deleteMemo(Memo memo) async {
    if (memo.id != null) {
      await db.deleteMemo(memo.id!);
    }
    _items.remove(memo);
    notifyListeners();
  }
}

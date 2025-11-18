import 'package:flutter/material.dart';
import '../models/memo.dart';

class MemoProvider extends ChangeNotifier {
  final List<Memo> _items = [];

  List<Memo> get items => List.unmodifiable(_items);

  void addMemo(String title, String content) {
    final newMemo = Memo(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      title: title,
      content: content,
    );
    _items.add(newMemo);
    notifyListeners();
  }

  void updateMemo(String id, String title, String content){
    final index = _items.indexWhere((m) => m.id == id);
    if (index != -1) {
      _items[index].title = title;
      _items[index].content = content;
      notifyListeners();
    }
  }

  void deleteMemo(String id) {
    _items.removeWhere((m) => m.id == id);
    notifyListeners();
  }
}
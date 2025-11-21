class Memo {
  int? id; // Lo manejará SQLite (AUTOINCREMENT)
  String title;
  String content;

  Memo({
    this.id, // Cambio
    required this.title,
    required this.content,
  });

  Map<String, dynamic> toMap() {
    final map = <String, dynamic>{
      'title': title,
      'content': content,
    };
    if (id != null) {
      map['id'] = id;
    }
    return map;
  }

  factory Memo.fromMap(Map<String, dynamic> map) {
    return Memo(
      id: map['id'] as int?,
      title: map['title'] as String? ?? '',
      content: map['content'] as String? ?? '',
    );
  }
}

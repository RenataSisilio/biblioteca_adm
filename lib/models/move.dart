import 'dart:convert';

import 'book.dart';

class Move {
  final String? id;
  final String bookId;
  final String user;
  final Status type;
  final DateTime date;

  Move({
    this.id,
    required this.bookId,
    required this.user,
    required this.type,
    required this.date,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'bookId': bookId,
      'user': user,
      'type': type.name,
      'date': date.millisecondsSinceEpoch,
    };
  }
  factory Move.fromMap(Map<String, dynamic> map) {
    return Move(
      id: map['id'] != null ? map['id'] as String : null,
      bookId: map['bookId'] as String,
      user: map['user'] as String,
      type: Status.values.firstWhere((e) => e.name == map['status']),
      date: DateTime.fromMillisecondsSinceEpoch(map['date'] as int),
    );
  }

  String toJson() => json.encode(toMap());

  factory Move.fromJson(String source) =>
      Move.fromMap(json.decode(source) as Map<String, dynamic>);

}

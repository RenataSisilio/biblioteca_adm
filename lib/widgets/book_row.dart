import 'package:flutter/material.dart';

import '../models/book.dart';

class BookRow extends StatelessWidget {
  const BookRow(this.book, {super.key});

  final Book book;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(child: Text(book.numStr)),
        Expanded(flex: 10, child: Text(book.title)),
        Expanded(flex: 5, child: Text(book.author ?? '')),
        Expanded(
          flex: 3,
          child: Text(book.status == Status.borrowed
              ? book.lastUser ?? ''
              : 'Disponível'),
        ),
      ],
    );
  }
}

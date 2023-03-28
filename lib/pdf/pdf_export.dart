import 'dart:typed_data';

import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';

import '../models/book.dart';

Future<Uint8List> makePdf(
    {required bool splitByCategory,
    List<Book>? books,
    List<MapEntry<String, List<Book>>>? splitted}) async {
  assert((splitByCategory && splitted != null) || books != null);
  final pdf = Document();
  pdf.addPage(
    MultiPage(
      pageFormat: PdfPageFormat.a4,
      maxPages: 100,
      footer: (context) => SizedBox(
        width: double.infinity,
        child: Text(
          'pág. ${context.pageNumber} / ${context.pagesCount}',
          textAlign: TextAlign.right,
        ),
      ),
      build: (context) {
        if (splitByCategory) {
          splitted!.sort((a, b) => a.key.compareTo(b.key));
          final result = <Widget>[];
          for (var e in splitted) {
            result.addAll(
              [
                SizedBox(
                  width: double.infinity,
                  child: Text(
                    e.key,
                    style: Theme.of(context).header3,
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(width: double.infinity, height: 20),
              ],
            );
            for (var i = 0; i < e.value.length; i++) {
              result.add(
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    BookRow(e.value[i]),
                    i != e.value.length - 1 ? Divider() : SizedBox.shrink(),
                  ],
                ),
              );
            }
            result.add(
                // e == splitted.last ?
                SizedBox(
              width: double.infinity,
              child: Divider(
                height: 40,
                thickness: 2,
              ),
            )
                // : SizedBox.shrink(),
                );
          }
          return [Wrap(children: result)];
        } else {
          return [
            ListView.separated(
              itemCount: books!.length,
              separatorBuilder: (_, __) => Divider(),
              itemBuilder: (_, i) => BookRow(books[i]),
            ),
          ];
        }
      },
    ),
  );
  return pdf.save();
}

class BookRow extends StatelessWidget {
  BookRow(this.book);

  final Book book;

  @override
  Widget build(context) {
    return Row(
      children: [
        Expanded(child: Text(book.numStr)),
        Expanded(flex: 10, child: Text(book.title)),
        Expanded(flex: 5, child: Text(book.author ?? '')),
        Expanded(
          flex: 4,
          child: Text(book.status == Status.borrowed
              ? book.lastUser ?? ''
              : 'Disponível'),
        ),
      ],
    );
  }
}

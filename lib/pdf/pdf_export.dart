import 'dart:typed_data';

import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

import '../models/book.dart';

Future<Uint8List> makePdf(
    {required bool splitByCategory,
    List<Book>? books,
    List<MapEntry<String, List<Book>>>? splitted}) async {
  assert((splitByCategory && splitted != null) || books != null);
  final pdf = pw.Document();
  pdf.addPage(
    pw.MultiPage(
      pageFormat: PdfPageFormat.a4,
      build: (context) {
        if (splitByCategory) {
          splitted!.sort((a, b) => a.key.compareTo(b.key));
          return [
            pw.ListView.separated(
              itemCount: splitted.length,
              separatorBuilder: (_, __) => pw.Divider(
                height: 40,
                thickness: 2,
              ),
              itemBuilder: (_, index) => pw.Column(
                mainAxisSize: pw.MainAxisSize.min,
                children: [
                  pw.Text(
                    splitted[index].key,
                    style: pw.Theme.of(context).header3,
                  ),
                  pw.SizedBox(height: 20),
                  pw.ListView.separated(
                    itemCount: splitted[index].value.length,
                    separatorBuilder: (_, __) => pw.Divider(),
                    itemBuilder: (_, i) => BookRow(splitted[index].value[i]),
                  ),
                ],
              ),
            ),
          ];
        } else {
          return [
            pw.ListView.separated(
              itemCount: books!.length,
              separatorBuilder: (_, __) => pw.Divider(),
              itemBuilder: (_, i) => BookRow(books[i]),
            ),
          ];
        }
      },
    ),
  );
  return pdf.save();
}

class BookRow extends pw.StatelessWidget {
  BookRow(this.book);

  final Book book;

  @override
  pw.Widget build(context) {
    return pw.Row(
      children: [
        pw.Expanded(child: pw.Text(book.numStr)),
        pw.Expanded(flex: 10, child: pw.Text(book.title)),
        pw.Expanded(flex: 5, child: pw.Text(book.author ?? '')),
        pw.Expanded(
          flex: 4,
          child: pw.Text(book.status == Status.borrowed
              ? book.lastUser ?? ''
              : 'Disponível'),
        ),
      ],
    );
  }
}

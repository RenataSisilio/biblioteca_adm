import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:printing/printing.dart';

import '../../../get_it.dart';
import '../../../models/book.dart';
import '../../../pdf/pdf_export.dart';
import '../report_controller.dart';
import 'books_report_view.dart';

class BooksReportPage extends StatelessWidget {
  const BooksReportPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = getIt.get<ReportController>();
    controller.sortBy(SortField.number);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Relatórios'),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () {
                final split = controller.split.value;
                final splitted = split
                    ? controller.splitByCategory().entries.toList()
                    : <MapEntry<String, List<Book>>>[];
                splitted.sort((a, b) => a.key.compareTo(b.key));
                Printing.layoutPdf(
                  onLayout: (format) async => await makePdf(
                    splitByCategory: split,
                    books: split ? null : controller.report,
                    splitted: splitted,
                  ),
                );
              },
              icon: const Icon(Icons.print)),
        ],
      ),
      body: BlocBuilder<ReportController, ReportState>(
        bloc: controller,
        builder: (context, state) {
          if (state == ReportState.success) {
            return const BooksReportView();
          }
          if (state == ReportState.error) {
            return const Center(child: Text('Erro'));
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}

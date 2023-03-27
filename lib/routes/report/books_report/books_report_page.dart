import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../get_it.dart';
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
          IconButton(onPressed: () {}, icon: const Icon(Icons.print)),
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

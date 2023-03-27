import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../get_it.dart';
import '../../../widgets/book_row.dart';
import '../report_controller.dart';

class BooksReportView extends StatelessWidget {
  const BooksReportView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = getIt.get<ReportController>();

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: BlocBuilder(
        bloc: controller,
        builder: (context, state) {
          if (controller.split.value) {
            final splitted = controller.splitByCategory().entries.toList();
            splitted.sort((a, b) => a.key.compareTo(b.key));
            return ListView.separated(
              itemCount: splitted.length,
              separatorBuilder: (_, __) => const Divider(
                height: 40,
                thickness: 2,
              ),
              itemBuilder: (_, index) => Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    splitted[index].key,
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 20),
                  ListView.separated(
                    shrinkWrap: true,
                    itemCount: splitted[index].value.length,
                    separatorBuilder: (_, __) => const Divider(),
                    itemBuilder: (_, i) => BookRow(splitted[index].value[i]),
                  ),
                ],
              ),
            );
          } else {
            final books = controller.report;
            return ListView.separated(
              shrinkWrap: true,
              itemCount: books.length,
              separatorBuilder: (_, __) => const Divider(),
              itemBuilder: (_, i) => BookRow(books[i]),
            );
          }
        },
      ),
    );
  }
}

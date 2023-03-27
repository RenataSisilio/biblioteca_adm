import 'package:flutter/material.dart';

import '../../get_it.dart';
import '../../models/book.dart';
import '../../widgets/radio_group.dart';
import 'report_controller.dart';

class ReportView extends StatelessWidget {
  const ReportView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = getIt.get<ReportController>();
    final status = ValueNotifier<Status?>(null);
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            ValueListenableBuilder(
              valueListenable: controller.split,
              builder: (_, __, ___) => SwitchListTile(
                title: const Text('Separar por categoria'),
                value: controller.split.value,
                onChanged: (value) {
                  controller.splitByCategory();
                  controller.split.value = value;
                },
              ),
            ),
            const Divider(),
            ValueListenableBuilder(
              valueListenable: status,
              builder: (_, __, ___) {
                return RadioGroup(
                  title: 'Status',
                  options: const ['Todos', 'Emprestados', 'Disponíveis'],
                  values: const [null, Status.borrowed, Status.available],
                  notifier: status,
                  onChanged: (value) => controller.selectByStatus(value),
                );
              },
            ),
            const Divider(),
            ValueListenableBuilder(
              valueListenable: controller.sortField,
              builder: (_, __, ___) => RadioGroup(
                title: 'Ordenar por',
                options: const ['Número', 'Título', 'Autor'],
                values: const [
                  SortField.number,
                  SortField.title,
                  SortField.author,
                ],
                notifier: controller.sortField,
                onChanged: (value) => controller.sortBy(value!),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

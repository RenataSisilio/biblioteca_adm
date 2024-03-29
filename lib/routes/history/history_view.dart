import 'package:biblioteca_adm/routes/history/user_history.dart/user_history_page.dart';
import 'package:flutter/material.dart';

import '../../services/get_it.dart';
import '../../services/library_controller.dart';

class HistoryView extends StatelessWidget {
  const HistoryView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = getIt.get<LibraryController>();
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            itemCount: controller.users.length,
            itemBuilder: (context, index) => ListTile(
              onTap: () {
                getIt.get<ValueNotifier<String>>().value =
                    controller.users[index];
                getIt.get<ValueNotifier<StatelessWidget>>().value =
                    const UserHistoryPage();
              },
              title: Text(controller.users[index]),
              trailing: const Icon(Icons.chevron_right),
            ),
          ),
        ),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: FloatingActionButton.extended(
            onPressed: () {},
            label: const Text('HISTÓRICO GERAL'), // selecionar período
          ),
        ),
      ],
    );
  }
}

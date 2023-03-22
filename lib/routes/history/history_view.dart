import 'package:biblioteca_adm/routes/user_history.dart/user_history_page.dart';
import 'package:flutter/material.dart';

import '../../get_it.dart';
import '../../services/controllers/library_controller.dart';

class HistoryView extends StatelessWidget {
  const HistoryView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = getIt.get<LibraryController>();
    return ListView.builder(
      itemCount: controller.users.length,
      itemBuilder: (context, index) => ListTile(
        onTap: () {
          getIt.get<ValueNotifier<String>>().value = controller.users[index];
          getIt.get<ValueNotifier<StatelessWidget>>().value =
              const UserHistoryPage();
        },
        title: Text(controller.users[index]),
        trailing: const Icon(Icons.chevron_right),
      ),
    );
  }
}

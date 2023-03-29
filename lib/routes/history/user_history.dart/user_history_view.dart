import 'package:flutter/material.dart';

import '../../../services/get_it.dart';
import '../../../services/library_controller.dart';
import 'user_history_controller.dart';

class UserHistoryView extends StatelessWidget {
  const UserHistoryView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = getIt.get<LibraryController>();
    final userHistoryController = getIt.get<UserHistoryController>();

    return ListView.builder(
      itemCount: userHistoryController.borrowed.length,
      itemBuilder: (_, index) {
        final dates = userHistoryController.getDates(index);
        return ListTile(
          title: Text(
            controller.books
                .singleWhere((book) =>
                    book.id == userHistoryController.borrowed[index].bookId)
                .title,
            style: TextStyle(
                fontWeight:
                    dates.length == 8 ? FontWeight.bold : FontWeight.normal),
          ),
          trailing: Text(dates),
        );
      },
    );
  }
}

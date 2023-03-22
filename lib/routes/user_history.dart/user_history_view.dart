import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../get_it.dart';
import '../../models/book.dart';
import '../../services/controllers/library_controller.dart';

class UserHistoryView extends StatelessWidget {
  const UserHistoryView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = getIt.get<LibraryController>();
    final moves = controller.history;
    moves.sort((a, b) => b.type.index.compareTo(a.type.index));
    final firstIndex = moves.indexWhere((move) => move.type == Status.borrowed);
    final borrowed = moves.sublist(firstIndex);
    final returned = moves.sublist(0, firstIndex);
    borrowed.sort((a, b) => b.date.compareTo(a.date));
    returned.sort((a, b) => b.date.compareTo(a.date));

    return ListView.builder(
      itemCount: borrowed.length,
      itemBuilder: (_, index) {
        final subListIndex = returned.indexWhere(
          (move) => move.date.isBefore(borrowed[index].date),
        );
        final subList = returned.sublist(
          0,
          subListIndex == -1 ? 0 : subListIndex,
        );
        final returnIndex =
            subList.indexWhere((move) => move.bookId == borrowed[index].bookId);
        return ListTile(
          title: Text(
            controller.books
                .singleWhere((book) => book.id == borrowed[index].bookId)
                .title,
          ),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(DateFormat('dd/MM/yy').format(borrowed[index].date)),
              returnIndex != -1
                  ? Text(
                      ' - ${DateFormat('dd/MM/yy').format(returned[returnIndex].date)}')
                  : const SizedBox.shrink(),
            ],
          ),
        );
      },
    );
  }
}

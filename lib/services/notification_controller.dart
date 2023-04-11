import 'package:bloc/bloc.dart';
import 'package:intl/intl.dart';

import '../models/book.dart';
import '../models/move.dart';
import 'repositories/library_repository.dart';

enum NotificationState { loading, error, notify }

class NotificationController extends Cubit<NotificationState> {
  NotificationController(this.repository) : super(NotificationState.loading);

  final LibraryRepository repository;
  late List<Move> borrowed;
  late List<Move> returned;
  late String notification;

  Future<void> getHistory(String user) async {
    try {
      final history = await repository.getMoves(user);
      history.sort((a, b) => b.type.index.compareTo(a.type.index));
      final firstIndex =
          history.indexWhere((move) => move.type == Status.borrowed);
      borrowed = history.sublist(firstIndex);
      returned = history.sublist(0, firstIndex);
      borrowed.sort((a, b) => b.date.compareTo(a.date));
      returned.sort((a, b) => b.date.compareTo(a.date));
    } catch (e) {
      emit(NotificationState.error);
    }
  }

  Future<void> notify(List<String> users) async {
    try {
      for (var user in users) {
        await getHistory(user);
        notification = '';
        final threeMonths = DateTime.now().subtract(const Duration(days: 90));
        for (var i = 0; i < borrowed.length; i++) {
          if (borrowed[i].date.isBefore(threeMonths)) {
            final subListIndex = returned.indexWhere(
              (move) => move.date.isBefore(borrowed[i].date),
            );
            final subList = returned.sublist(
              0,
              subListIndex == -1 ? 0 : subListIndex,
            );
            final returnIndex =
                subList.indexWhere((move) => move.bookId == borrowed[i].bookId);
            if (returnIndex == -1) {
              final bookName = await repository.bookTitle(borrowed[i].bookId);
              notification +=
                  '$user está com $bookName desde ${DateFormat('dd/MM/yy').format(borrowed[i].date)}.\n\n';
            }
          }
        }
      }
      try {
        notification.replaceRange(notification.lastIndexOf('\n\n'), null, '');
        emit(NotificationState.notify);
      } catch (e) {
        emit(NotificationState.loading);
      }
      if (notification != '') {
        emit(NotificationState.notify);
      }
    } catch (e) {
      emit(NotificationState.error);
    }
  }
}

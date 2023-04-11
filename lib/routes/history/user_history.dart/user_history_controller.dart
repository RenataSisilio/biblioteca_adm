import 'package:bloc/bloc.dart';
import 'package:intl/intl.dart';

import '../../../models/book.dart';
import '../../../models/move.dart';
import '../../../services/repositories/library_repository.dart';

enum UserHistoryState { loading, saving, success, error }

class UserHistoryController extends Cubit<UserHistoryState> {
  UserHistoryController(this.repository) : super(UserHistoryState.loading);

  final LibraryRepository repository;
  late List<Move> borrowed;
  late List<Move> returned;

  Future<void> getHistory(String user) async {
    emit(UserHistoryState.loading);
    try {
      final history = await repository.getMoves(user);
      history.sort((a, b) => b.type.index.compareTo(a.type.index));
      final firstIndex =
          history.indexWhere((move) => move.type == Status.borrowed);
      borrowed = history.sublist(firstIndex);
      returned = history.sublist(0, firstIndex);
      borrowed.sort((a, b) => b.date.compareTo(a.date));
      returned.sort((a, b) => b.date.compareTo(a.date));
      emit(UserHistoryState.success);
    } catch (e) {
      emit(UserHistoryState.error);
    }
  }

  String getDates(int index) {
    // final subListIndex = returned.indexWhere(
    //   (move) => move.date.isBefore(borrowed[index].date),
    // );
    // final subList = returned.sublist(
    //   0,
    //   subListIndex == -1 ? 0 : subListIndex,
    // );
    final returnIndex =
        returned.indexWhere((move) => move.bookId == borrowed[index].bookId);
    return DateFormat('dd/MM/yy').format(borrowed[index].date) +
        (returnIndex == -1
            ? ''
            : ' - ${DateFormat('dd/MM/yy').format(returned[returnIndex].date)}');
  }
}

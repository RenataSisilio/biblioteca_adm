import 'package:bloc/bloc.dart';

import '../../models/book.dart';

enum ShelfState { loading, success, error }

class ShelfController extends Cubit<ShelfState> {
  ShelfController() : super(ShelfState.loading);

  late List<Book> shelf;
  late List<Book> unique;

  void getShelf(List<Book> books, String category) {
    emit(ShelfState.loading);
    try {
      shelf = books.where((book) => book.category == category).toList();

      unique = [...shelf];
      for (var i = 1; i < unique.length; i++) {
        if (unique[i].title == unique[i - 1].title) {
          if (unique[i].author == unique[i - 1].author) {
            unique.remove(unique[i]);
            i--;
          }
        }
      }
      emit(ShelfState.success);
    } catch (e) {
      emit(ShelfState.error);
    }
  }
}

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../models/book.dart';
import '../repositories/library_repository.dart';

enum LibraryState { loading, saving, success, error }

class LibraryController extends Cubit<LibraryState> {
  LibraryController(this.repository) : super(LibraryState.loading);

  final LibraryRepository repository;
  late List<Book> books;
  late List<String> users;

  Future<void> getBooks() async {
    emit(LibraryState.loading);
    try {
      books = await repository.getBooks();
      users = await repository.getUsers();
      emit(LibraryState.success);
    } catch (e) {
      emit(LibraryState.error);
    }
  }

  List<String> getCategories() {
    final categories = books.fold(<String>[], (previousValue, book) {
      if (!previousValue.contains(book.category)) {
        previousValue.add(book.category);
      }
      return previousValue;
    });
    categories.sort((a, b) => a.compareTo(b));
    return categories;
  }

  Future<void> borrow(Book book, String user, DateTime date) async {
    emit(LibraryState.saving);
    try {
      await repository.borrow(book, user, date);
      final index = books.indexWhere((e) => e.id == book.id);
      books.removeAt(index);
      books.insert(
        index,
        book.copyWith(status: Status.borrowed, lastUser: user),
      );
      if (!users.contains(user)) {
        users.add(user);
      }
      emit(LibraryState.success);
    } catch (e) {
      emit(LibraryState.error);
    }
  }

  Future<void> giveBack(Book book, DateTime date) async {
    emit(LibraryState.saving);
    try {
      await repository.giveBack(book, date);
      final index = books.indexWhere((e) => e.id == book.id);
      books.removeAt(index);
      books.insert(
        index,
        book.copyWith(status: Status.available),
      );
      emit(LibraryState.success);
    } catch (e) {
      emit(LibraryState.error);
    }
  }
}

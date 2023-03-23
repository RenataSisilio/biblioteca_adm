import 'package:flutter_bloc/flutter_bloc.dart';

import '../models/book.dart';
import '../models/move.dart';
import 'repositories/library_repository.dart';

enum LibraryState { loading, saving, success, error }

class LibraryController extends Cubit<LibraryState> {
  LibraryController(this.repository) : super(LibraryState.loading);

  final LibraryRepository repository;
  late List<Book> books;
  late List<String> users;
  late List<Move> history;

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

  Future<void> create(
    String title,
    String author,
    String category,
  ) async {
    emit(LibraryState.saving);
    try {
      final double number;
      final shelf = books.where((book) => book.category == category).toList();
      if (shelf.any((book) => book.title == title && book.author == author)) {
        shelf.retainWhere(
            (book) => book.title == title && book.author == author);
        shelf.sort((a, b) => a.number.compareTo(b.number));
        number = shelf.last.number + 0.1;
      } else {
        shelf.sort((a, b) => a.number.compareTo(b.number));
        number = shelf.last.number.floorToDouble() + 1.0;
      }
      final newBook = Book(
        title: title,
        author: author,
        category: category,
        number: number,
        status: Status.available,
      );
      await repository.createBook(newBook);
      books.add(newBook);
      emit(LibraryState.success);
    } catch (e) {
      emit(LibraryState.error);
    }
  }

  Future<void> delete(Book book) async {
    emit(LibraryState.saving);
    try {
      await repository.deleteBook(book.id!);
      books.removeWhere((e) => e.id == book.id);
      emit(LibraryState.success);
    } catch (e) {
      emit(LibraryState.error);
    }
  }

  Future<void> edit(
    String id,
    String title,
    String author,
    String category,
  ) async {
    emit(LibraryState.saving);
    try {
      final index = books.indexWhere((book) => book.id == id);
      final Book edited;
      if (category == books[index].category) {
        edited = books[index].copyWith(
          title: title,
          author: author,
          category: category,
        );
      } else {
        final double number;
        final shelf = books.where((book) => book.category == category).toList();
        if (shelf.any((book) => book.title == title && book.author == author)) {
          shelf.retainWhere(
              (book) => book.title == title && book.author == author);
          shelf.sort((a, b) => a.number.compareTo(b.number));
          number = shelf.last.number + 0.1;
        } else {
          shelf.sort((a, b) => a.number.compareTo(b.number));
          number = shelf.last.number + 1.0;
        }
        edited = books[index].copyWith(
          title: title,
          author: author,
          category: category,
          number: number,
        );
      }
      await repository.editBook(edited);
      books.replaceRange(index, index + 1, [edited]);
      emit(LibraryState.success);
    } catch (e) {
      emit(LibraryState.error);
    }
  }
}

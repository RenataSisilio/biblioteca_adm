import 'dart:async';

import '../../models/book.dart';

abstract class LibraryRepository {
  Future<List<Book>> getBooks();
  Future<void> borrow(Book book, String user, DateTime date);
  Future<void> giveBack(Book book, DateTime date);
  Future<List<String>> getUsers();
  Future<void> createBook(Book book);
  Future<void> editBook(Book book);
  Future<void> deleteBook(String bookId);
}

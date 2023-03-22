import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';

import '../../models/book.dart';
import '../../models/move.dart';
import 'library_repository.dart';

class FirebaseLibraryRepository implements LibraryRepository {
  final FirebaseFirestore firestore;

  FirebaseLibraryRepository(this.firestore);

  @override
  Future<void> borrow(Book book, String user, DateTime date) async {
    try {
      final map =
          book.copyWith(status: Status.borrowed, lastUser: user).toMap();
      map.remove('id');
      await firestore.collection('books').doc(book.id).set(map);
      await firestore.collection('users').doc(user).collection('moves').add(
        {
          'status': Status.borrowed.name,
          'date': date.millisecondsSinceEpoch,
          'book': book.id,
        },
      );
      firestore.collection('users').doc(user).set({});
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<Book>> getBooks() async {
    try {
      final snapshot =
          await firestore.collection('books').orderBy('title').get();
      final docs = snapshot.docs;
      final library = <Book>[];
      for (var doc in docs) {
        final data = doc.data();
        data.addAll({'id': doc.id});
        library.add(Book.fromMap(map: data));
      }
      return library;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> giveBack(Book book, DateTime date) async {
    try {
      final map = book.copyWith(status: Status.available).toMap();
      map.remove('id');
      await firestore.collection('books').doc(book.id).set(map);
      await firestore
          .collection('users')
          .doc(book.lastUser)
          .collection('moves')
          .add(
        {
          'status': Status.available.name,
          'date': date.millisecondsSinceEpoch,
          'book': book.id,
        },
      );
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<String>> getUsers() async {
    try {
      final snapshot = await firestore.collection('users').get();
      return snapshot.docs.map((e) => e.id).toList();
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> createBook(Book book) async {
    try {
      final map = book.toMap();
      map.remove('id');
      await firestore.collection('books').add(map);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> deleteBook(String bookId) async {
    try {
      await firestore.collection('books').doc(bookId).delete();
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> editBook(Book book) async {
    try {
      final map = book.toMap();
      map.remove('id');
      await firestore.collection('books').doc(book.id).set(map);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<Move>> getMoves(String user) async {
    try {
      final snapshot = await firestore
          .collection('users')
          .doc(user)
          .collection('moves')
          .get();
      final docs = snapshot.docs;
      final library = <Move>[];
      for (var doc in docs) {
        final data = doc.data();
        data.addAll({'id': doc.id, 'user': user});
        library.add(Move.fromMap(data));
      }
      return library;
    } catch (e) {
      rethrow;
    }
  }
}

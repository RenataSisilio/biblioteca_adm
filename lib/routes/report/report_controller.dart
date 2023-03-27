import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';

import '../../models/book.dart';

enum ReportState { loading, success, error }

enum SortField { title, author, number }

class ReportController extends Cubit<ReportState> {
  ReportController(this.allBooks)
      : report = [...allBooks],
        super(ReportState.loading);

  final List<Book> allBooks;
  final List<Book> report;
  final split = ValueNotifier(true);
  final sortField = ValueNotifier(SortField.number);

  void selectByStatus([Status? status]) {
    emit(ReportState.loading);
    try {
      if (status == null) {
        report.clear();
        report.addAll(allBooks);
      } else {
        report.clear();
        report.addAll(allBooks.where((book) => book.status == status));
      }
      sortBy(sortField.value);
      emit(ReportState.success);
    } catch (e) {
      emit(ReportState.error);
    }
  }

  Map<String, List<Book>> splitByCategory() {
    emit(ReportState.loading);
    try {
      final map = report.fold(<String, List<Book>>{}, (map, book) {
        if (map.containsKey(book.category)) {
          map[book.category]!.add(book);
        } else {
          map.addAll({
            book.category: [book]
          });
        }
        return map;
      });
      emit(ReportState.success);
      return map;
    } catch (e) {
      emit(ReportState.error);
      return {};
    }
  }

  void sortBy(SortField sortField, {bool invert = false}) {
    emit(ReportState.loading);
    try {
      switch (sortField) {
        case SortField.author:
          invert
              ? report.sort(
                  (b, a) => (a.author ?? '')
                      .toLowerCase()
                      .compareTo((b.author ?? '').toLowerCase()),
                )
              : report.sort(
                  (a, b) => (a.author ?? '')
                      .toLowerCase()
                      .compareTo((b.author ?? '').toLowerCase()),
                );
          break;
        case SortField.number:
          invert
              ? report.sort(
                  (b, a) => a.number.compareTo(b.number),
                )
              : report.sort(
                  (a, b) => a.number.compareTo(b.number),
                );
          break;
        case SortField.title:
          invert
              ? report.sort(
                  (b, a) =>
                      a.title.toLowerCase().compareTo(b.title.toLowerCase()),
                )
              : report.sort(
                  (a, b) =>
                      a.title.toLowerCase().compareTo(b.title.toLowerCase()),
                );
          break;
        default:
          throw Exception();
      }
      emit(ReportState.success);
    } catch (e) {
      emit(ReportState.error);
    }
  }
}

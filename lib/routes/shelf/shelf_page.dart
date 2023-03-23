import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../get_it.dart';
import '../../services/controllers/library_controller.dart';
import '../../services/controllers/shelf_controller.dart';
import '../../widgets/book_info.dart';

class ShelfPage extends StatelessWidget {
  const ShelfPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = getIt.get<LibraryController>();
    final shelfController = getIt.get<ShelfController>();
    final categories = controller.getCategories();
    final category = getIt.get<ValueNotifier<int>>();

    return ValueListenableBuilder(
      valueListenable: category,
      builder: (BuildContext context, value, Widget? child) {
        shelfController.getShelf(controller.books, categories[value]);
        return Scaffold(
          appBar: AppBar(
            title: Text(categories[value]),
            centerTitle: true,
          ),
          body: BlocBuilder<ShelfController, ShelfState>(
            bloc: shelfController,
            builder: (context, state) {
              if (state == ShelfState.success) {
                return Builder(
                  builder: (context) {
                    return ListView.builder(
                      itemCount: shelfController.unique.length,
                      itemBuilder: (context, index) => ExpansionTile(
                        title: Text(shelfController.unique[index].title),
                        subtitle:
                            Text(shelfController.unique[index].author ?? ''),
                        children: List.from(shelfController.shelf
                            .where((e) =>
                                e.title ==
                                    shelfController.unique[index].title &&
                                e.author ==
                                    shelfController.unique[index].author)
                            .map((e) => BookInfo(controller.books.indexOf(e)))),
                      ),
                    );
                  },
                );
              }
              if (state == ShelfState.error) {
                return const Center(child: Text('Erro'));
              }
              return const Center(child: CircularProgressIndicator());
            },
          ),
        );
      },
    );
  }
}

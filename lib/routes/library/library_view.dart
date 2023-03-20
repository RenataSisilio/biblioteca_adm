import 'package:biblioteca_adm/routes/shelf/shelf_page.dart';
import 'package:flutter/material.dart';

import '../../services/controllers/library_controller.dart';
import '../../get_it.dart';

class LibraryView extends StatelessWidget {
  const LibraryView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = getIt.get<LibraryController>();
    final categories = controller.getCategories();
    final notifier = getIt.get<ValueNotifier<int>>();

    return ListView.builder(
      itemCount: categories.length,
      itemBuilder: (context, index) => ListTile(
        onTap: () {
          notifier.value = index;
          getIt.get<ValueNotifier<StatelessWidget>>().value = const ShelfPage();
        },
        title: Text(categories[index]),
      ),
    );
  }
}

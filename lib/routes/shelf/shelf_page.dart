import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../get_it.dart';
import '../../services/controllers/library_controller.dart';
import 'shelf_view.dart';

class ShelfPage extends StatelessWidget {
  const ShelfPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = getIt.get<LibraryController>();
    final categories = controller.getCategories();
    final category = getIt.get<ValueNotifier<int>>();

    return Scaffold(
      appBar: AppBar(
        title: ValueListenableBuilder(
          valueListenable: category,
          builder: (BuildContext context, value, Widget? child) =>
              Text(categories[value]),
        ),
      ),
      body: BlocBuilder<LibraryController, LibraryState>(
        bloc: controller,
        builder: (context, state) {
          if (state == LibraryState.loading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state == LibraryState.error) {
            return const Center(child: Text('Erro'));
          }
          return Builder(builder: (context) {
            return ValueListenableBuilder(
              valueListenable: category,
              builder: (BuildContext context, value, Widget? child) =>
                  ShelfView(categories[value]),
            );
          });
        },
      ),
    );
  }
}

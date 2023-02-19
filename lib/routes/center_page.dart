import 'package:flutter/material.dart';

import '../get_it.dart';
import '../services/controllers/library_controller.dart';
import 'home/home_page.dart';
import 'library/library_page.dart';
import 'shelf/shelf_page.dart';

class CenterPage extends StatelessWidget {
  const CenterPage({super.key});

  @override
  Widget build(BuildContext context) {
    final pageController = getIt.get<PageController>();
    final controller = getIt.get<LibraryController>();
    final categories = controller.getCategories();
    final category = getIt.get<ValueNotifier<int>>();

    return PageView(
      controller: pageController,
      physics: const NeverScrollableScrollPhysics(),
      children: [
        const HomePage(),
        const LibraryPage(),
        ValueListenableBuilder(
          valueListenable: category,
          builder: (BuildContext context, value, Widget? child) =>
              ShelfPage(categories[value]),
        ),
      ],
    );
  }
}

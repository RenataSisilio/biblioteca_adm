import 'package:biblioteca_adm/routes/shelf/shelf_page.dart';
import 'package:flutter/material.dart';

import '../get_it.dart';
import '../services/controllers/library_controller.dart';
import 'home/home_page.dart';
import 'library/library_page.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    final pageController = getIt.get<PageController>();
    final controller = getIt.get<LibraryController>();
    final categories = controller.getCategories();
    final category = getIt.get<ValueNotifier<int>>();

    return Scaffold(
      body: Row(
        children: [
          Expanded(
            child: Column(
              children: [
                PreferredSize(
                  preferredSize: Size(double.infinity,
                      MediaQuery.of(context).size.height * 0.15),
                  child: Center(
                    child: Image.asset(
                      'assets/Minha Biblioteca Contemplativa.png',
                      height: MediaQuery.of(context).size.height * 0.15,
                    ),
                  ),
                ),
                ListTile(
                  onTap: () => pageController.jumpToPage(0),
                  leading: const Icon(Icons.search),
                  title: const Text('Buscar'),
                ),
                ListTile(
                  onTap: () => pageController.jumpToPage(1),
                  leading: const Icon(Icons.menu_book),
                  title: const Text('Biblioteca'),
                ),
              ],
            ),
          ),
          const VerticalDivider(),
          Expanded(
            flex: 2,
            child: PageView(
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
            ),
          ),
          const VerticalDivider(),
          Expanded(
            flex: 2,
            child: Container(),
          ),
        ],
      ),
    );
  }
}

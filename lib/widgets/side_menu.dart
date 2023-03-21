import 'package:flutter/material.dart';

import '../get_it.dart';
import 'book_info_dialog.dart';

class SideMenu extends StatelessWidget {
  const SideMenu({super.key});

  @override
  Widget build(BuildContext context) {
    final pageController = getIt.get<PageController>();
    final endPageController = getIt.get<ValueNotifier<StatelessWidget>>();
    return Column(
      children: [
        PreferredSize(
          preferredSize:
              Size(double.infinity, MediaQuery.of(context).size.height * 0.15),
          child: Center(
            child: Image.asset(
              'assets/Minha Biblioteca Contemplativa.png',
              height: MediaQuery.of(context).size.height * 0.15,
            ),
          ),
        ),
        const SizedBox(height: 20),
        FloatingActionButton.extended(
          onPressed: () => showDialog(
            context: context,
            builder: (context) => const BookInfoDialog(),
          ),
          icon: const Icon(Icons.add),
          label: const Text('Cadastrar'),
        ),
        const SizedBox(height: 20),
        ListTile(
          onTap: () {
            pageController.jumpToPage(0);
            endPageController.value = Container();
          },
          leading: const Icon(Icons.search),
          title: const Text('Buscar'),
        ),
        ListTile(
          onTap: () => pageController.jumpToPage(1),
          leading: const Icon(Icons.import_contacts),
          title: const Text('Biblioteca'),
        ),
        ListTile(
          onTap: () {
            pageController.jumpToPage(2);
            endPageController.value = Container();
          },
          leading: const Icon(Icons.library_books),
          title: const Text('Relatórios'),
        ),
        ListTile(
          onTap: () {
            pageController.jumpToPage(2);
            endPageController.value = Container();
          },
          leading: const Icon(Icons.history),
          title: const Text('Histórico'),
        ),
      ],
    );
  }
}

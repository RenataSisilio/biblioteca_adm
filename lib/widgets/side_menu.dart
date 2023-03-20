import 'package:flutter/material.dart';

import '../get_it.dart';

class SideMenu extends StatelessWidget {
  const SideMenu({super.key});

  @override
  Widget build(BuildContext context) {
    final pageController = getIt.get<PageController>();
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
        ListTile(
          onTap: () => pageController.jumpToPage(0),
          leading: const Icon(Icons.search),
          title: const Text('Buscar'),
        ),
        ListTile(
          onTap: () => pageController.jumpToPage(1),
          leading: const Icon(Icons.import_contacts),
          title: const Text('Biblioteca'),
        ),
        ListTile(
          onTap: () => pageController.jumpToPage(2),
          leading: const Icon(Icons.add),
          title: const Text('Cadastrar'),
        ),
        ListTile(
          onTap: () => pageController.jumpToPage(3),
          leading: const Icon(Icons.library_books),
          title: const Text('Relatórios'),
        ),
      ],
    );
  }
}

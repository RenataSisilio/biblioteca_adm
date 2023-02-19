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
          leading: const Icon(Icons.menu_book),
          title: const Text('Biblioteca'),
        ),
      ],
    );
  }
}

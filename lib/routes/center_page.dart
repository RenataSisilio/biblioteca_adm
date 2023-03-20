import 'package:flutter/material.dart';

import '../get_it.dart';
import 'home/home_page.dart';
import 'library/library_page.dart';

class CenterPage extends StatelessWidget {
  const CenterPage({super.key});

  @override
  Widget build(BuildContext context) {
    final pageController = getIt.get<PageController>();

    return PageView(
      controller: pageController,
      physics: const NeverScrollableScrollPhysics(),
      children: const [
        HomePage(),
        LibraryPage(),
        Center(child: Text('Cadastrar'),),
        Center(child: Text('Relatórios'),),
      ],
    );
  }
}

import 'package:flutter/material.dart';

import '../get_it.dart';
import 'history/history_page.dart';
import 'report/report_page.dart';
import 'search/search_page.dart';
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
        SearchPage(),
        LibraryPage(),
        ReportPage(),
        HistoryPage(),
      ],
    );
  }
}

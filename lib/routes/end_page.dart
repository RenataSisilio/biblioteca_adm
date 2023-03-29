import 'package:flutter/material.dart';

import '../services/get_it.dart';

class EndPage extends StatelessWidget {
  const EndPage({super.key});

  @override
  Widget build(BuildContext context) {
    final pageController = getIt.get<ValueNotifier<StatelessWidget>>();
    return ValueListenableBuilder(
      valueListenable: pageController,
      builder: (context, value, child) => value,
    );
  }
}

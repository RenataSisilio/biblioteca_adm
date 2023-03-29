import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../services/get_it.dart';
import '../../services/library_controller.dart';
import 'history_view.dart';

class HistoryPage extends StatelessWidget {
  const HistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Histórico'),centerTitle: true,),
      body: BlocBuilder<LibraryController, LibraryState>(
        bloc: getIt.get<LibraryController>(),
        builder: (context, state) {
          if (state == LibraryState.loading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state == LibraryState.error) {
            return const Center(child: Text('Erro'));
          }
          return const HistoryView();
        },
      ),
    );
  }
}

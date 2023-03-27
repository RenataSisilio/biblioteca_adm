import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../get_it.dart';
import '../../services/library_controller.dart';
import 'report_view.dart';

class ReportPage extends StatelessWidget {
  const ReportPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Relatórios'),
        centerTitle: true,
      ),
      body: BlocBuilder<LibraryController, LibraryState>(
        bloc: getIt.get<LibraryController>(),
        builder: (context, state) {
          if (state == LibraryState.success) {
            return const ReportView();
          }
          if (state == LibraryState.error) {
            return const Center(child: Text('Erro'));
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}

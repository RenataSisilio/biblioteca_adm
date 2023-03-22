import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../get_it.dart';
import '../../services/controllers/library_controller.dart';
import 'user_history_view.dart';

class UserHistoryPage extends StatelessWidget {
  const UserHistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = getIt.get<LibraryController>();
    final user = getIt.get<ValueNotifier<String>>();
    return ValueListenableBuilder(
      valueListenable: user,
      builder: (_, value, __) {
        controller.getHistory(value);
        return Scaffold(
          appBar: AppBar(
            title: Text(value),
            centerTitle: true,
          ),
          body: BlocBuilder<LibraryController, LibraryState>(
            bloc: getIt.get<LibraryController>(),
            builder: (context, state) {
              if (state == LibraryState.loading) {
                return const Center(child: CircularProgressIndicator());
              }
              if (state == LibraryState.error) {
                return const Center(child: Text('Erro'));
              }
              return const UserHistoryView();
            },
          ),
        );
      },
    );
  }
}

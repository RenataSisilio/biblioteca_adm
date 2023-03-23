import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../get_it.dart';
import 'user_history_controller.dart';
import 'user_history_view.dart';

class UserHistoryPage extends StatelessWidget {
  const UserHistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = getIt.get<UserHistoryController>();
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
          body: BlocBuilder<UserHistoryController, UserHistoryState>(
            bloc: getIt.get<UserHistoryController>(),
            builder: (context, state) {
              if (state == UserHistoryState.success) {
                return const UserHistoryView();
              }
              if (state == UserHistoryState.error) {
                return const Center(child: Text('Erro'));
              }
              return const Center(child: CircularProgressIndicator());
            },
          ),
        );
      },
    );
  }
}

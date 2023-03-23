import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../get_it.dart';
import '../services/library_controller.dart';

class ConfirmationDialog extends StatelessWidget {
  const ConfirmationDialog({
    super.key,
    required this.onConfirm,
    required this.message,
    this.confirmButtonText,
  });

  final Function onConfirm;
  final String message;
  final String? confirmButtonText;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LibraryController, LibraryState>(
      bloc: getIt.get<LibraryController>(),
      builder: (context, state) {
        return state == LibraryState.saving
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : AlertDialog(
                content: Text(message),
                actions: [
                  ElevatedButton(
                    onPressed: () async {
                      final navigator = Navigator.of(context);
                      onConfirm();
                      navigator.pop();
                    },
                    child: Text(confirmButtonText ?? 'OK'),
                  ),
                ],
              );
      },
    );
  }
}

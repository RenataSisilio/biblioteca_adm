import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../get_it.dart';
import '../models/book.dart';
import '../services/controllers/library_controller.dart';
import 'category_form_field.dart';

class BookInfoDialog extends StatelessWidget {
  const BookInfoDialog({super.key, this.book});

  final Book? book;

  @override
  Widget build(BuildContext context) {
    final controller = getIt.get<LibraryController>();
    final formKey = GlobalKey<FormState>();
    final title = TextEditingController(text: book?.title);
    final author = TextEditingController(text: book?.author);
    final category = TextEditingController(text: book?.category);

    return BlocBuilder<LibraryController, LibraryState>(
      bloc: controller,
      builder: (context, state) {
        return state == LibraryState.saving
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : AlertDialog(
                content: Form(
                  key: formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TextFormField(
                        controller: title,
                        decoration: const InputDecoration(
                          labelText: 'Título',
                        ),
                      ),
                      TextFormField(
                        controller: author,
                        decoration: const InputDecoration(
                          labelText: 'Autor',
                        ),
                      ),
                      CategoryFormField(category),
                    ],
                  ),
                ),
                actions: [
                  ElevatedButton(
                    onPressed: () async {
                      final navigator = Navigator.of(context);
                      book == null
                          ? await controller.create(
                              title.text,
                              author.text,
                              category.text,
                            )
                          : await controller.edit(
                              book!.id!,
                              title.text,
                              author.text,
                              category.text,
                            );
                      navigator.pop();
                    },
                    child: Text(book == null ? 'CADASTRAR' : 'SALVAR'),
                  ),
                ],
              );
      },
    );
  }
}

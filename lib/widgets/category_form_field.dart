import 'package:flutter/material.dart';

import '../get_it.dart';
import '../services/controllers/library_controller.dart';

class CategoryFormField extends StatelessWidget {
  const CategoryFormField(this.category, {super.key});

  final TextEditingController category;

  @override
  Widget build(BuildContext context) {
    final controller = getIt.get<LibraryController>();
    final categories = controller.getCategories();
    return Autocomplete(
      initialValue: category.value,
      fieldViewBuilder:
          (context, textEditingController, focusNode, onFieldSubmitted) =>
              TextFormField(
        controller: textEditingController,
        focusNode: focusNode,
        onFieldSubmitted: (String value) {
          onFieldSubmitted();
        },
        decoration: const InputDecoration(
          label: Text('Categoria'),
        ),
      ),
      optionsBuilder: (textEditingValue) {
        if (textEditingValue.text == '') {
          return const Iterable<String>.empty();
        }
        final List<String> result = categories.fold(
          <String>[],
          (res, element) {
            if (element.toLowerCase().startsWith(
                  textEditingValue.text.toLowerCase(),
                )) {
              res.add(element);
            }
            return res;
          },
        ).toList();
        result.addAll(
          categories
              .where(
                (element) => element.toLowerCase().contains(
                      textEditingValue.text.toLowerCase(),
                    ),
              )
              .where((element) => !result.contains(element)),
        );
        category.text = textEditingValue.text;
        return result;
      },
      onSelected: (option) => category.text = option,
    );
  }
}

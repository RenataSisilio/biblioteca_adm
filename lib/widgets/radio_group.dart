import 'package:flutter/material.dart';

class RadioGroup<T extends Object?> extends StatelessWidget {
  const RadioGroup({
    super.key,
    required this.options,
    required this.values,
    required this.notifier,
    required this.onChanged,
    this.title,
  }) : assert(options.length == values.length);

  final String? title;
  final List<String> options;
  final List<T> values;
  final ValueNotifier<T?> notifier;
  final Function(T? value) onChanged;

  @override
  Widget build(BuildContext context) {
    final children = title == null
        ? <Widget>[]
        : <Widget>[Text(title!, style: Theme.of(context).textTheme.titleLarge)];
    for (var i = 0; i < options.length; i++) {
      children.add(
        RadioListTile(
          title: Text(options[i]),
          value: values[i],
          groupValue: notifier.value,
          onChanged: (value) {
            onChanged(value);
            notifier.value = value;
          },
        ),
      );
    }
    return Column(children: children);
  }
}

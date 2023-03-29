import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../services/get_it.dart';
import '../../services/library_controller.dart';
import 'search_view.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LibraryController, LibraryState>(
      bloc: getIt.get<LibraryController>(),
      builder: (context, state) {
        if (state == LibraryState.loading) {
          return const Center(child: CircularProgressIndicator());
        }
        if (state == LibraryState.error) {
          return const Center(child: Text('Erro'));
        }
        return const HomeView();
      },
    );
  }
}

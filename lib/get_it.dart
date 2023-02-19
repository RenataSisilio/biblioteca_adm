import 'package:flutter/cupertino.dart';
import 'package:get_it/get_it.dart';

import 'services/controllers/library_controller.dart';
import 'services/repositories/firebase_library_repository.dart';

final getIt = GetIt.instance;

void initializeDependencyInjection() {
  getIt.registerSingleton<FirebaseLibraryRepository>(
    FirebaseLibraryRepository(),
  );
  getIt.registerSingleton<LibraryController>(
    LibraryController(
      getIt.get<FirebaseLibraryRepository>(),
    ),
  );
  getIt.registerSingleton<ValueNotifier<int>>(ValueNotifier(0));
  getIt.registerSingleton<PageController>(PageController(initialPage: 1));
}

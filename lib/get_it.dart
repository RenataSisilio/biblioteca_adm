import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import 'firebase_options.dart';
import 'services/controllers/library_controller.dart';
import 'services/repositories/firebase_library_repository.dart';

final getIt = GetIt.instance;

Future<void> initializeDependencyInjection() async {
  await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
      );
  getIt.registerSingleton<FirebaseLibraryRepository>(
    FirebaseLibraryRepository(FirebaseFirestore.instance),
  );
  getIt.registerSingleton<LibraryController>(
    LibraryController(
      getIt.get<FirebaseLibraryRepository>(),
    ),
  );
  getIt.registerSingleton<ValueNotifier<int>>(ValueNotifier(0));
  getIt.registerSingleton<PageController>(PageController(initialPage: 1));
  getIt.registerSingleton<ValueNotifier<StatelessWidget>>(
      ValueNotifier(Container()));
}

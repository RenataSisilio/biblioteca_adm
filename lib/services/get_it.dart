import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import '../firebase_options.dart';
import '../routes/history/user_history.dart/user_history_controller.dart';
import '../routes/library/shelf/shelf_controller.dart';
import '../routes/report/report_controller.dart';
import 'library_controller.dart';
import 'notification_controller.dart';
import 'repositories/firebase_library_repository.dart';

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
  getIt.registerSingleton<ValueNotifier<int>>(ValueNotifier(0)); // cat. index
  getIt.registerSingleton<ValueNotifier<String>>(ValueNotifier('')); // user
  getIt.registerSingleton<PageController>(PageController(initialPage: 1));
  getIt.registerSingleton<ValueNotifier<StatelessWidget>>(
      ValueNotifier(Container())); // end page
  getIt.registerSingleton<UserHistoryController>(UserHistoryController(
    getIt.get<FirebaseLibraryRepository>(),
  ));
  getIt.registerSingleton<ShelfController>(ShelfController());
  getIt.registerSingleton<NotificationController>(NotificationController(
    getIt.get<FirebaseLibraryRepository>(),
  ));
}

void registerReportController() {
  getIt.registerSingleton<ReportController>(
    ReportController(getIt.get<LibraryController>().books),
  );
}

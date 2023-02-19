import 'package:bloc/bloc.dart';
import 'package:firebase_core/firebase_core.dart';

import '../../firebase_options.dart';
import '../../services/controllers/library_controller.dart';
import '../../services/repositories/firebase_library_repository.dart';

enum SplashState { loading, online, offline }

class SplashController extends Cubit<SplashState> {
  SplashController() : super(SplashState.loading);

  void init({
    required FirebaseLibraryRepository firestore,
    required LibraryController libraryController,
  }) async {
    try {
      await Firebase.initializeApp(
          options: DefaultFirebaseOptions.currentPlatform,
        );
        firestore.init();
      await libraryController.getBooks();
      emit(SplashState.online);
    } catch (e) {
      await libraryController.getBooks();
      emit(SplashState.offline);
    }
  }
}

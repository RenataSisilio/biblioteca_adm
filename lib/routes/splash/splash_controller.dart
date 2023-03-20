import 'package:bloc/bloc.dart';

import '../../services/controllers/library_controller.dart';

enum SplashState { loading, online, offline }

class SplashController extends Cubit<SplashState> {
  SplashController() : super(SplashState.loading);

  void init(LibraryController libraryController) async {
    try {
      await libraryController.getBooks();
      emit(SplashState.online);
    } catch (e) {
      await libraryController.getBooks();
      emit(SplashState.offline);
    }
  }
}

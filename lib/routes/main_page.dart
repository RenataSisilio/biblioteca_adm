import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../services/get_it.dart';
import '../services/library_controller.dart';
import '../services/notification_controller.dart';
import '../widgets/side_menu.dart';
import 'center_page.dart';
import 'end_page.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = getIt.get<NotificationController>();
    controller.notify(getIt.get<LibraryController>().users);
    return Scaffold(
      body: BlocListener<NotificationController, NotificationState>(
        bloc: controller,
        listener: (context, state) {
          if (state == NotificationState.notify) {
            showDialog(
              context: context,
              builder: (context) => AlertDialog(
                title: const Text('Notificação'),
                content: Text(controller.notification),
              ),
            );
          } else if (state == NotificationState.error) {
            showDialog(
              context: context,
              builder: (context) => const AlertDialog(
                title: Text('Notificação'),
                content: Text('Não foi possível analisar os prazos de devolução'),
              ),
            );
          }
        },
        child: Row(
          children: const [
            Expanded(
              child: SideMenu(),
            ),
            VerticalDivider(),
            Expanded(
              flex: 2,
              child: CenterPage(),
            ),
            VerticalDivider(),
            Expanded(
              flex: 2,
              child: EndPage(),
            ),
          ],
        ),
      ),
    );
  }
}

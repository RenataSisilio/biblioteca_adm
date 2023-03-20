import 'package:biblioteca_adm/routes/end_page.dart';
import 'package:flutter/material.dart';

import '../widgets/side_menu.dart';
import 'center_page.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
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
    );
  }
}


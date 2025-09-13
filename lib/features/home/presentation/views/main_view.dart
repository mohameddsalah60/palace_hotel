import 'package:flutter/material.dart';

import 'widgets/custom_drawer_desktop.dart';
import 'widgets/main_page.dart';

class MainView extends StatelessWidget {
  const MainView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [CustomDrawerDesktop(), MainPage()],
      ),
    );
  }
}

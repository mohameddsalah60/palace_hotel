import 'package:flutter/material.dart';
import 'package:palace_systeam_managment/features/dashboard/presentation/views/dashboard_view.dart';

import '../../features/home/presentation/views/main_view.dart';
import 'app_routes.dart';

class AppRouter {
  static Route onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.mainView:
        return MaterialPageRoute(builder: (context) => const MainView());
      case AppRoutes.dashboardView:
        return MaterialPageRoute(builder: (context) => const DashboardView());
      default:
        return MaterialPageRoute(
          builder:
              (context) =>
                  const Scaffold(body: Center(child: Text('404 Not Found'))),
        );
    }
  }
}

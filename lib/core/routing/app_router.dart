import 'package:flutter/material.dart';
import 'package:palace_systeam_managment/features/auth/presentation/views/sign_in_screen.dart';
import '../../features/home/presentation/views/main_view.dart';
import 'app_routes.dart';

class AppRouter {
  static Route onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.mainView:
        return MaterialPageRoute(builder: (context) => const MainView());
      case AppRoutes.signInView:
        return MaterialPageRoute(builder: (context) => const SignInScreen());
      default:
        return MaterialPageRoute(
          builder:
              (context) =>
                  const Scaffold(body: Center(child: Text('404 Not Found'))),
        );
    }
  }
}

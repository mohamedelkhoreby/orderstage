import 'package:flutter/material.dart';

import 'package:orderstage/core/routes/routes.dart';
import '../../view/staff/view/staff_page.dart';
import '../../view/registration/view/registration_page.dart';
import '../../view/splash/splash_view.dart';

class RouteGenerator {
  static Route<dynamic> getRoute(RouteSettings settings) {
    switch (settings.name) {
      case NamedRoutes.splash:
        return MaterialPageRoute(builder: (_) => const SplashView());
      case NamedRoutes.main:
        return MaterialPageRoute(builder: (_) => const StaffPage());
      case NamedRoutes.registration:
        return MaterialPageRoute(builder: (_) => const Registration());
      default:
        return unDefinedRoute();
    }
  }

  static Route<dynamic> unDefinedRoute() {
    return MaterialPageRoute(
      builder: (_) => Scaffold(
        appBar: AppBar(
          title: const Text("No Route Found"),
        ),
        body: const Center(
          child: Text("No Route Found"),
        ),
      ),
    );
  }
}

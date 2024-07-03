import 'package:flutter/material.dart';
import 'package:orderstage/core/routes/routes.dart';
import 'package:sizer/sizer.dart';


import 'core/routes/app_routes.dart';
import 'core/routes/app_routes_fun.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Sizer(builder:
        (BuildContext context, Orientation orientation, DeviceType deviceType) {
      return MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: NamedRoutes.splash,
        onGenerateRoute: RouteGenerator.getRoute,
        navigatorKey: navigator,
      );
    });
  }
}

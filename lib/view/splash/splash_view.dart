import 'dart:async';

import 'package:flutter/material.dart';

import '../../core/resources/assets_manager.dart';
import '../../core/resources/color_manager.dart';
import '../../core/routes/app_routes_fun.dart';
import '../../core/routes/routes.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  SplashState createState() => SplashState();
}

class SplashState extends State<SplashView> {
  Timer? _timer;
  final int splashDelay = 4;

// Timer that triggers _goNext after splashDelay
  _startDelay() {
    _timer = Timer(Duration(seconds: splashDelay), _goNext);
  }

// Navigation to the registration route
  _goNext() async {
    await push(NamedRoutes.registration);
  }

  @override
  void initState() {
    super.initState(); // Starting the delay timer when the state is initialized
    _startDelay();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.appbar,
      body: Center(
        child: Image.asset(ImageAssets.splash),
      ),
    );
  }

  @override
  void dispose() {
    _timer?.cancel(); // Cancelling the timer if it's active
    super.dispose();
  }
}

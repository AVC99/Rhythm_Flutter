import 'package:flutter/material.dart';

class SplashView extends StatelessWidget {
  static const String route = '/splash';

  const SplashView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}

import 'package:flutter/material.dart';

import 'package:rhythm/src/views/sign_in_view.dart';
import 'package:rhythm/src/views/start_view.dart';
import 'package:rhythm/src/views/theme_changer_view.dart';

final routes = <String, WidgetBuilder>{
  StartView.route: (context) => const StartView(),
  SignInView.route: (context) => const SignInView(),
  ThemeChangerView.route: (context) => const ThemeChangerView(),
};

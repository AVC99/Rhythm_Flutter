import 'package:flutter/material.dart';

import 'package:rhythm/src/views/start_view.dart';
import 'package:rhythm/src/views/theme_changer_view.dart';

final routes = <String, WidgetBuilder>{
  '/': (context) => const StartView(),
  '/theme': (context) => const ThemeChangerView(),
};

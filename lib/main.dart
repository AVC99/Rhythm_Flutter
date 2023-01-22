import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:rhythm/firebase_options.dart';
import 'package:rhythm/src/core/theme/theme_repository.dart';
import 'package:rhythm/src/app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  SystemChrome.setPreferredOrientations(
    [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown],
  );

  final themeRepository = ThemeRepository(
    sharedPreferences: await SharedPreferences.getInstance(),
  );

  runApp(
    ProviderScope(
      child: RhythmApp(themeRepository: themeRepository),
    ),
  );
}

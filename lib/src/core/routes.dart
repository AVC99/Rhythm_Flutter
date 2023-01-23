import 'package:flutter/material.dart';

import 'package:rhythm/src/views/splash_view.dart';
import 'package:rhythm/src/views/onboarding/start_view.dart';
import 'package:rhythm/src/views/onboarding/sign_in_view.dart';
import 'package:rhythm/src/views/onboarding/reset_password_view.dart';
import 'package:rhythm/src/views/onboarding/sign_up_view.dart';
import 'package:rhythm/src/views/onboarding/create_account_view.dart';
import 'package:rhythm/src/views/home/home_view.dart';
import 'package:rhythm/src/views/theme_changer_view.dart';

final routes = <String, WidgetBuilder>{
  SplashView.route: (context) => const SplashView(),
  StartView.route: (context) => const StartView(),
  SignInView.route: (context) => const SignInView(),
  ResetPasswordView.route: (context) => const ResetPasswordView(),
  SignUpView.route: (context) => const SignUpView(),
  CreateAccountView.route: (context) => const CreateAccountView(
        email: '',
        password: '',
      ),
  HomeView.route: (context) => const HomeView(),
  ThemeChangerView.route: (context) => const ThemeChangerView(),
};

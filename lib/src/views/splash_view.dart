import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:rhythm/src/widgets/banners/vertical_rhythm_banner.dart';

class SplashView extends StatelessWidget {
  static const String route = '/splash';

  const SplashView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          width: double.infinity,
          height: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              VerticalRhythmBanner(
                subtitle: AppLocalizations.of(context)!.slogan,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
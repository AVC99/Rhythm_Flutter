import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:rhythm/src/core/resources/images.dart';
import 'package:rhythm/src/core/resources/typography.dart';
import 'package:rhythm/src/views/onboarding/sign_in_view.dart';
import 'package:rhythm/src/widgets/banners/vertical_rhythm_banner.dart';
import 'package:rhythm/src/widgets/buttons/large_action_button.dart';
import 'package:rhythm/src/widgets/utils/svg_image.dart';

class StartView extends StatelessWidget {
  static const String route = '/start';

  const StartView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                VerticalRhythmBanner(
                  subtitle: AppLocalizations.of(context)!.slogan,
                ),
                _buildIllustration(context),
                _buildFooter(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildIllustration(BuildContext context) {
    return SvgImage(
      svg: kAudioPlayerIllustration,
      width: double.infinity,
      height: MediaQuery.of(context).size.height / 4,
    );
  }

  Widget _buildFooter(BuildContext context) {
    return Column(
      children: [
        LargeActionButton(
          label: AppLocalizations.of(context)!.start,
          width: MediaQuery.of(context).size.width / 1.5,
          onPressed: () {
            Navigator.pushNamed(context, SignInView.route);
          },
        ),
        SizedBox(height: MediaQuery.of(context).size.height / 15),
        Text(
          AppLocalizations.of(context)!.termsAndConditions,
          style: kActionText,
        ),
      ],
    );
  }
}


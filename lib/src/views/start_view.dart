import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:rhythm/src/core/resources/images.dart';
import 'package:rhythm/src/core/resources/typography.dart';
import 'package:rhythm/src/widgets/large_action_button.dart';
import 'package:rhythm/src/widgets/svg_image.dart';

class StartView extends StatelessWidget {
  const StartView({Key? key}) : super(key: key);

  Widget _buildBanner(BuildContext context) {
    return Column(
      children: [
        SvgImage(
          svg: kLogo,
          width: MediaQuery.of(context).size.width / 2,
          height: MediaQuery.of(context).size.height / 15,
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height / 50,
        ),
        Text(
          AppLocalizations.of(context)!.appName,
          style: kAppTitle,
        ),
        SizedBox(height: MediaQuery.of(context).size.height / 50),
        Text(
          AppLocalizations.of(context)!.slogan,
          style: kTextLine,
        ),
      ],
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
            Navigator.pushNamed(context, '/signIn');
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                _buildBanner(context),
                _buildIllustration(context),
                _buildFooter(context),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

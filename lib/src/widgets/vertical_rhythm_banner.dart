import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:rhythm/src/core/resources/images.dart';
import 'package:rhythm/src/core/resources/typography.dart';
import 'package:rhythm/src/widgets/svg_image.dart';

class VerticalRhythmBanner extends StatelessWidget {
  final String subtitle;

  const VerticalRhythmBanner({
    Key? key,
    required this.subtitle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
          subtitle,
          style: kTextLine,
        ),
      ],
    );
  }
}

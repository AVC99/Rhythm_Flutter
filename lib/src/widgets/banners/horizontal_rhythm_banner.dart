import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:rhythm/src/core/resources/images.dart';
import 'package:rhythm/src/core/resources/typography.dart';
import 'package:rhythm/src/widgets/utils/svg_image.dart';

class HorizontalRhythmBanner extends StatelessWidget {
  const HorizontalRhythmBanner({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SvgImage(
          svg: kLogo,
          width: MediaQuery.of(context).size.width / 4,
          height: MediaQuery.of(context).size.height / 40,
        ),
        SizedBox(
          width: MediaQuery.of(context).size.height / 75,
        ),
        Text(
          AppLocalizations.of(context)!.appName,
          style: kAppTitle.copyWith(
            fontSize: 24.0,
          ),
        ),
      ],
    );
  }
}

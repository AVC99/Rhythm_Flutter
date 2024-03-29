import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:rhythm/src/widgets/buttons/circular_icon_button.dart';
import 'package:rhythm/src/widgets/banners/horizontal_rhythm_banner.dart';

class CustomAppBar extends StatefulWidget implements PreferredSizeWidget {
  final bool hasActions;

  const CustomAppBar({
    Key? key,
    this.hasActions = true,
  }) : super(key: key);

  @override
  State<CustomAppBar> createState() => _CustomAppBarState();

  @override
  Size get preferredSize => const Size(
        double.infinity,
        80.0,
      );
}

class _CustomAppBarState extends State<CustomAppBar> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 25,
          vertical: 25 / 2.5,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const HorizontalRhythmBanner(),
            widget.hasActions ? _buildActions(context) : Container(),
          ],
        ),
      ),
    );
  }

  Widget _buildActions(BuildContext context) {
    return Row(
      children: [
        CircularIconButton(
          icon: const Icon(Icons.notifications),
          tooltip: AppLocalizations.of(context)!.notifications,
          onPressed: () {},
        ),
      ],
    );
  }
}

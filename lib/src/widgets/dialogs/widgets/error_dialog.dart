import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:rhythm/src/core/resources/typography.dart';

class ErrorDialog extends StatelessWidget {
  final String title;
  final String description;
  final Function()? onAccept;

  const ErrorDialog({
    Key? key,
    required this.title,
    required this.description,
    required this.onAccept,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        title,
        style: kDialogTitle,
      ),
      content: Text(
        description,
        style: kDialogDescription,
      ),
      actions: [
        TextButton(
          onPressed: onAccept,
          child: Text(
            AppLocalizations.of(context)!.accept,
            style: kDialogActions,
          ),
        ),
      ],
    );
  }
}

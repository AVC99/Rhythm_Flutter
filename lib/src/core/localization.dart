import 'package:flutter/widgets.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class Localization {
  static AppLocalizations? _loc;

  AppLocalizations? get loc => Localization._loc;

  static void init(BuildContext context) => _loc = AppLocalizations.of(context)!;
}
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:rhythm/src/core/resources/typography.dart';
import 'package:rhythm/src/providers/spotify_provider.dart';
import 'package:rhythm/src/widgets/scaffold/custom_app_bar.dart';
import 'package:rhythm/src/widgets/buttons/large_action_button.dart';

class SpotifyAuthenticationErrorView extends ConsumerWidget {
  const SpotifyAuthenticationErrorView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: const CustomAppBar(
        hasActions: false,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Icon(
                  FontAwesomeIcons.spotify,
                  size: 64,
                ),
                const SizedBox(height: 16.0),
                Text(
                  AppLocalizations.of(context)!.spotifyRequired,
                  style: kSectionTitle,
                ),
                const SizedBox(height: 16.0),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.8,
                  child: Text(
                    AppLocalizations.of(context)!.spotifyRequiredDescription,
                    style: kDialogDescription,
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height / 10),
                LargeActionButton(
                  label: AppLocalizations.of(context)!.spotifyLogin,
                  width: MediaQuery.of(context).size.width / 1.5,
                  onPressed: () {
                    ref.invalidate(spotifyAuthenticationToken);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

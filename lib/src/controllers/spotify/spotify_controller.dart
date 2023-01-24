import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:rhythm/src/controllers/spotify/spotify_state.dart';

final spotifyControllerProvider =
    StateNotifierProvider<SpotifyController, SpotifyState>(
  (ref) => SpotifyController(ref),
);

class SpotifyController extends StateNotifier<SpotifyState> {
  final Ref ref;

  SpotifyController(this.ref) : super(const SpotifyInitialState());

}

import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:rhythm/src/repositories/spotify/spotify_repository.dart';

final spotifyRepositoryProvider = Provider<SpotifyRepository>(
  (ref) => SpotifyRepository(),
);

final spotifyAccessToken = Provider<String>((ref) {
  if (ref.read(spotifyRepositoryProvider).authorizationToken == null) {
    ref.read(spotifyRepositoryProvider).getAuthorizationToken();
  }

  return ref.read(spotifyRepositoryProvider).authorizationToken!;
});

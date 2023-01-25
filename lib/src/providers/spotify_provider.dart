import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:rhythm/src/repositories/spotify/spotify_repository.dart';

final spotifyRepositoryProvider = Provider<SpotifyRepository>(
  (ref) => SpotifyRepository(),
);

final getSpotifyAuthenticationToken = FutureProvider<String>(
  (ref) async => ref.watch(spotifyRepositoryProvider).getAuthorizationToken(),
);

import 'package:firebase_auth/firebase_auth.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:rhythm/src/controllers/firestore/users_controller.dart';
import 'package:rhythm/src/repositories/spotify/spotify_repository.dart';

import '../models/display_info.dart';

final spotifyRepositoryProvider = Provider<SpotifyRepository>(
  (ref) => SpotifyRepository(),
);

final spotifyAuthenticationToken = FutureProvider<String>((ref) async {
  final token =
      await ref.read(spotifyRepositoryProvider).getAuthorizationToken();

  final spotifyUser =
      await ref.read(spotifyRepositoryProvider).getAuthenticatedUser(token);

  final rhythmUser = await ref
      .read(usersControllerProvider.notifier)
      .getAuthenticatedUser(FirebaseAuth.instance.currentUser!.email!);

  if (rhythmUser != null && rhythmUser.spotifyId != spotifyUser) {
    rhythmUser.spotifyId = spotifyUser;
    await ref.read(usersControllerProvider.notifier).updateUser(rhythmUser);
  }

  return token;
});

final spotifyTopArtistProvider = FutureProvider<List<DisplayInfo>>(
    (ref) async => await ref.read(spotifyRepositoryProvider).getUserTopArtist(),
);

final spotifyPlaylistProvider = FutureProvider<List<DisplayInfo>>(
    (ref) async => await ref.read(spotifyRepositoryProvider).getUserPlaylist(),
);
final spotifyTopSongsProvider = FutureProvider<List<DisplayInfo>>(
    (ref) async => await ref.read(spotifyRepositoryProvider).getUserTopTracks(),
);
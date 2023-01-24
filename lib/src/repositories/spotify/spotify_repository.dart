import 'package:spotify_sdk/spotify_sdk.dart';

import 'package:rhythm/src/providers/environment_provider.dart';

class SpotifyRepository {
  String? _authorizationToken;

  SpotifyRepository();

  String? get authorizationToken => _authorizationToken;

  void getAuthorizationToken() async {
    final List<String> scopes = [
      'app-remote-control',
      'user-modify-playback-state',
      'playlist-read-private',
      'playlist-modify-public',
      'user-read-currently-playing'
    ];

    try {
      _authorizationToken = await SpotifySdk.getAccessToken(
        clientId: Environment.getSpotifyClientId(),
        redirectUrl: Environment.getSpotifyRedirectUri(),
        scope: scopes.join(', '),
      );
    } catch (_) {
      print('here');
      throw Exception('Error: Cannot authenticate user.');
    }
  }
}

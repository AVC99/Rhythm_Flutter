import 'package:spotify_sdk/spotify_sdk.dart';

import 'package:rhythm/src/providers/environment_provider.dart';
import 'package:webview_cookie_manager/webview_cookie_manager.dart';

class SpotifyRepository {
  SpotifyRepository();

  Future<String> getAuthorizationToken() async {
    final List<String> scopes = [
      'app-remote-control',
      'user-modify-playback-state',
      'playlist-read-private',
      'playlist-modify-public',
      'user-read-currently-playing'
    ];

    try {
      return await SpotifySdk.getAccessToken(
        clientId: Environment.getSpotifyClientId(),
        redirectUrl: Environment.getSpotifyRedirectUri(),
        scope: scopes.join(', '),
      );
    } catch (_) {
      throw Exception('Error: Cannot authenticate user.');
    }
  }

  Future<void> signOut() async {
    await WebviewCookieManager().clearCookies();
  }
}

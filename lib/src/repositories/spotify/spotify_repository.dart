import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:rhythm/src/repositories/spotify/spotify_error.dart';
import 'package:spotify_sdk/spotify_sdk.dart';
import 'package:http/http.dart' as http;

import 'package:rhythm/src/providers/environment_provider.dart';
import 'package:webview_cookie_manager/webview_cookie_manager.dart';

class SpotifyRepository {
  static const String baseUrl = 'https://api.spotify.com/v1';

  SpotifyRepository();

  Future<String> getAuthorizationToken() async {
    final List<String> scopes = [
      'ugc-image-upload',
      'user-read-playback-state',
      'user-modify-playback-state',
      'user-read-currently-playing',
      'app-remote-control',
      'streaming',
      'playlist-read-private',
      'playlist-read-collaborative',
      'playlist-modify-private',
      'playlist-modify-public',
      'user-follow-modify',
      'user-follow-read',
      'user-read-playback-position',
      'user-top-read',
      'user-read-recently-played',
      'user-library-modify',
      'user-library-read',
      'user-read-email',
      'user-read-private'
    ];

    try {
      if (defaultTargetPlatform == TargetPlatform.iOS) {
        return await SpotifySdk.getAccessToken(
          clientId: Environment.getSpotifyClientId(),
          redirectUrl: Environment.getSpotifyRedirectUri(),
          scope: scopes.join(', '),
          spotifyUri: 'spotify:track:58kNJana4w5BIjlZE2wq5r',
        );
      }

      return await SpotifySdk.getAccessToken(
        clientId: Environment.getSpotifyClientId(),
        redirectUrl: Environment.getSpotifyRedirectUri(),
        scope: scopes.join(', '),
      );
    } on PlatformException catch (e) {
      // Forgot password => PlatformException
      // No Spotify app on iOS => PlatformException
      throw SpotifyErrorHandler.determineErrorCode(e);
    } on MissingPluginException catch (e) {
      // Back button => MissingPluginException
      throw SpotifyErrorHandler.determineErrorCode(e);
    }
  }

  Future<void> signOut() async {
    await WebviewCookieManager().clearCookies();
  }

  Future<String> getAuthenticatedUser(
      String authenticationToken,
      ) async {
    const url = '$baseUrl/me';
    final uri = Uri.parse(url);
    final response = await http.get(
      uri,
      headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $authenticationToken',
      },
    );

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);

      return json['id'];
    } else {
      throw Exception('Error: Cannot get authenticated Spotify user.');
    }
  }
}

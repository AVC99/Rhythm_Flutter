import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:rhythm/src/models/display_info.dart';
import 'package:spotify_sdk/spotify_sdk.dart';
import 'package:http/http.dart' as http;
import 'package:webview_cookie_manager/webview_cookie_manager.dart';

import 'package:rhythm/src/repositories/spotify/spotify_error.dart';
import 'package:rhythm/src/providers/environment_provider.dart';

class SpotifyRepository {
  static const String baseUrl = 'https://api.spotify.com/v1';
  late String authorizationToken;

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
        authorizationToken = await SpotifySdk.getAccessToken(
          clientId: Environment.getSpotifyClientId(),
          redirectUrl: Environment.getSpotifyRedirectUri(),
          scope: scopes.join(', '),
          spotifyUri: 'spotify:track:58kNJana4w5BIjlZE2wq5r',
        );
        return authorizationToken;
      }
      authorizationToken = await SpotifySdk.getAccessToken(
        clientId: Environment.getSpotifyClientId(),
        redirectUrl: Environment.getSpotifyRedirectUri(),
        scope: scopes.join(', '),
      );
      return authorizationToken;
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
    authorizationToken = authenticationToken;
    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);

      return json['id'];
    } else {
      throw Exception('Error: Cannot get authenticated Spotify user.');
    }
  }

  Future<List<DisplayInfo>> getUserTopArtist() async {
    const url =
        '$baseUrl/me/top/artists?time_range=short_term&limit=10&offset=0';
    final uri = Uri.parse(url);
    final response = await http.get(
      uri,
      headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $authorizationToken',
      },
    );

    if (response.statusCode == 200) {
      List<DisplayInfo> artistList = [];
      Map<String, dynamic> myMap = json.decode(response.body);
      List<dynamic> items = myMap['items'];

      for (var element in items) {
        artistList.add(DisplayInfo(
            text: element['name'], url: element['images'][0]['url']));
      }

      return artistList;
    } else {
      throw Exception('Error: Cannot get authenticated Spotify user.');
    }
  }

  Future<List<DisplayInfo>> getUserTopTracks() async {
    const url =
        '$baseUrl/me/top/tracks?time_range=short_term&limit=10&offset=0';
    final uri = Uri.parse(url);
    final response = await http.get(
      uri,
      headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $authorizationToken',
      },
    );

    if (response.statusCode == 200) {
      List<DisplayInfo> artistList = [];
      Map<String, dynamic> myMap = json.decode(response.body);
      List<dynamic> items = myMap['items'];

      for (var element in items) {
        artistList.add(
          DisplayInfo(
            text: element['name'],
            url: element['album']['images'][0]['url'],
            artist: element['artists'][0]['name'],
            previewUrl: element['preview_url'],
          ),
        );
      }

      return artistList;
    } else {
      throw Exception('Error: Cannot get authenticated Spotify user.');
    }
  }

  Future<List<DisplayInfo>> getUserPlaylist() async {
    const url = '$baseUrl/me/playlists?limit=50&offset=0';
    final uri = Uri.parse(url);
    final response = await http.get(
      uri,
      headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $authorizationToken',
      },
    );

    if (response.statusCode == 200) {
      List<DisplayInfo> playlist = [];
      Map<String, dynamic> myMap = json.decode(response.body);
      List<dynamic> items = myMap['items'];

      for (var element in items) {
        playlist.add(DisplayInfo(
            text: element['name'], url: element['images'][0]['url']));
      }

      return playlist;
    } else {
      throw Exception('Error: Cannot get authenticated Spotify user.');
    }
  }

  Future<List<DisplayInfo>> searchTracks(String query) async {
    final url = '$baseUrl/search?q=$query&type=track';
    final uri = Uri.parse(url);
    final response = await http.get(
      uri,
      headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $authorizationToken',
      },
    );

    if (response.statusCode == 200) {
      Map<String, dynamic> myMap = json.decode(response.body);
      List<dynamic> items = myMap['tracks']['items'];
      List<DisplayInfo> tracks = [];

      for (var element in items) {
        tracks.add(
          DisplayInfo(
            text: element['name'],
            url: element['album']['images'][0]['url'],
            artist: element['artists'][0]['name'],
            previewUrl: element['preview_url'],
          ),
        );
      }

      return tracks;
    } else {
      throw Exception('Error: Cannot search tracks from Spotify');
    }
  }
}

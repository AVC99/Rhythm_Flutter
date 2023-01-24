import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:rhythm/src/core/resources/constants.dart';

abstract class Environment {
  static String getSpotifyClientId() {
    final String? clientId = dotenv.env[kEnvironmentSpotifyClientIdKey];
    return clientId ?? '';
  }

  static String getSpotifyRedirectUri() {
    final String? redirectUri = dotenv.env[kEnvironmentSpotifyRedirectUriKey];
    return redirectUri ?? '';
  }
}

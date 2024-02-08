import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

class SpotifyAuthService {
  final String clientId =
      "ad75e46c095940b4a11dec0ae979de2d"; // Your Spotify Client ID
  final String redirectUri =
      "com.example.spotifyxapp://"; // Your Spotify Redirect URI
  final List<String> scopes = ['user-library-read', 'playlist-read-private'];
  final String authEndpoint = 'https://accounts.spotify.com/authorize';
  final String tokenEndpoint = 'https://accounts.spotify.com/api/token';

  // Step 1: Redirect the user to Spotify login and authorization
  String getAuthorizationUrl() {
    final List<String> encodedScopes =
        scopes.map((s) => Uri.encodeComponent(s)).toList();
    final String scopeString = encodedScopes.join('%20');

    return '$authEndpoint?client_id=$clientId&redirect_uri=$redirectUri&scope=$scopeString&response_type=code';
  }

  // Step 2: Exchange the authorization code for an access token
  Future<String?> getAccessToken(String code) async {
    final Map<String, String> headers = {
      'Content-Type': 'application/x-www-form-urlencoded'
    };
    final Map<String, String> body = {
      'client_id': clientId,
      'grant_type': 'authorization_code',
      'code': code,
      'redirect_uri': redirectUri,
    };

    final http.Response response =
        await http.post(Uri.parse(tokenEndpoint), headers: headers, body: body);

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      return data['access_token'];
    } else {
      return null;
    }
  }
}

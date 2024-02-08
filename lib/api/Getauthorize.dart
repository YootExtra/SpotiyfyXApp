import 'dart:convert';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:spotifyxapp/model/TokenModel.dart';

Future<String> Getauthorize() async {
  final String url =
      'https://accounts.spotify.com/authorize'; // Replace with your desired URL

  try {
    // final SharedPreferences prefs = await SharedPreferences.getInstance();
    // String? txtTokenAPI = prefs.getString('TokenAPI');

    // if (txtTokenAPI == null || txtTokenAPI.isEmpty) {
    //   throw Exception('Access token not found in SharedPreferences');
    // }

    final response = await http.get(
      Uri.parse(url),
      // headers: {
      //   'Content-Type': 'application/x-www-form-urlencoded',
      //   'Authorization': 'Bearer $txtTokenAPI', // Include the access token here
      // },
    );

    if (response.statusCode == 200) {
      return response.body;
      // If the response is successful (status code 200), you can handle the user's Spotify profile data here
      // For example, you can parse the JSON response and work with the profile information.
      // final responseJson = jsonDecode(response.body) as Map<String, dynamic>;
      // Handle the response accordingly and return any necessary data.
    } else {
      // If the response status code is not 200, print an error message and throw an exception
      print('Error: ${response.statusCode}');
      throw Exception('Failed to load user profile');
    }
  } catch (e) {
    // Catch and handle any exceptions that may occur during the HTTP request or if the access token is missing
    print('Error: $e');
    throw Exception('Failed to load user profile');
  }
}

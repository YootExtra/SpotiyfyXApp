import 'dart:convert';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:spotifyxapp/model/TokenModel.dart';

Future<TokenModel> Posttoken() async {
  final String url =
      'https://accounts.spotify.com/api/token'; // Replace with your desired URL

  try {
    final response = await http.post(Uri.parse(url), headers: {
      'Content-Type': 'application/x-www-form-urlencoded',
    }, body: {
      'grant_type': 'client_credentials',
      'client_id': 'ad75e46c095940b4a11dec0ae979de2d',
      'client_secret': '9a4368ad1a744da9bae821357493adcf'
    });

    if (response.statusCode == 200) {
      final responseJson = jsonDecode(response.body) as Map<String, dynamic>;
      final resFormJSON = TokenModel.fromJson(responseJson);
      return resFormJSON;
    } else {
      print('Error: ${response.statusCode}');
      throw Exception('Failed to load album');
    }
  } catch (e) {
    print('Error: $e');
    throw Exception('Failed to load album');
  }
}



      // Map<String, dynamic> userMap = jsonDecode(content);

      // TokenModel _token = TokenModel(userMap['access_token'],
      //     userMap['access_token'], userMap['token_type']);
      // Map<String, dynamic> tokenJson = _token.toJson();
      // print(tokenJson);


      // You can save the content to a file using Flutter's file operations.
      // For example, to save it to the app's documents directory:
      // File file = File('${(await getApplicationDocumentsDirectory()).path}/output.txt');
      // await file.writeAsString(content);
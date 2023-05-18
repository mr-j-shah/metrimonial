import 'package:flutter_web_auth_2/flutter_web_auth_2.dart';
import 'package:http/http.dart' as http;

Future<void> authenticateWithIDMe() async {
  final authorizationEndpoint = 'https://api.id.me/oauth/authorize';
  final redirectUri = 'https://my.test.app/';
  final tokenEndpoint = 'https://api.id.me/oauth/token';
  final clientId = '07259cd89dd3d3909028b298060069b1';
  final clientSecret = '2fc8dc9a68a661ed3c15484d04b73c5c';

  // Step 1: Obtain authorization code
  final authUrl =
      ('$authorizationEndpoint?response_type=code&client_id=$clientId&redirect_uri=$redirectUri');
  final result = await FlutterWebAuth2.authenticate(
      url: authUrl.toString(), callbackUrlScheme: 'https');

  // Step 2: Exchange authorization code for access token
  final code = Uri.parse(result).queryParameters['code'];
  final tokenResponse = await http.post(Uri.parse(tokenEndpoint), body: {
    'grant_type': 'authorization_code',
    'client_id': clientId,
    'client_secret': clientSecret,
    'redirect_uri': redirectUri,
    'code': code,
  });

  if (tokenResponse.statusCode == 200) {
    final accessToken = tokenResponse.body[0];
    // Store the access token securely for future use

    // KYC verification and other API requests can be made using the access token
  } else {
    // Error handling
  }
}

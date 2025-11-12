import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:skorify/handlers/classes.dart';

Future<DefaultAPIResult> getAccountInfo(String session) async {
  final String completeURL = 'https://skorify-api.hosea.dev/account/info';
  final Map<String, String> headers = {'Session': session};

  try {
    final res = await http.get(Uri.parse(completeURL), headers: headers);

    final Map<String, dynamic> jsonResponse = jsonDecode(res.body);
    print(jsonResponse);
    if (jsonResponse.containsKey('message')) {
      return DefaultAPIResult(result: jsonResponse['message'], success: false);
    }

    return DefaultAPIResult(result: jsonResponse['account'], success: true);
  } catch (err) {
    final Map<String, dynamic> error = {
      'message': 'Maaf, terjadi kesalahan pada sistem',
    };
    return DefaultAPIResult(result: error, success: false);
  }
}

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:skorify/handlers/classes.dart';

Future<StringAPIResult> login(Object data) async {
  final String completeURL = 'https://skorify-api.hosea.dev/account/login';
  final Map<String, String> headers = {'Content-Type': 'application/json'};
  final String body = jsonEncode(data);

  try {
    final res = await http.post(
      Uri.parse(completeURL),
      headers: headers,
      body: body,
    );
    final Map<String, dynamic> jsonResponse = jsonDecode(res.body);

    String result;
    bool success = true;

    // If request is accepted
    if (res.statusCode == 200) {
      result = jsonResponse['sessionId'];
    } else {
      success = false;
      result = jsonResponse['message'];
    }

    // If not accepted
    return StringAPIResult(result: result, success: success);
  } catch (err) {
    return StringAPIResult(
      result: 'Maaf, terjadi kesalahan pada sistem.',
      success: false,
    );
  }
}

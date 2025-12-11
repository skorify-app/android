import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:skorify/handlers/classes.dart';

Future<EmptyAPIResult> submit(String session, Object data) async {
  final String completeURL = 'https://skorify-api.hosea.dev/questions/submit';
  final Map<String, String> headers = {
    'Content-Type': 'application/json',
    'Session': session,
  };
  final String body = jsonEncode(data);

  try {
    final res = await http.post(
      Uri.parse(completeURL),
      headers: headers,
      body: body,
    );

    String error = '';
    bool success = true;

    if (res.statusCode != 200) {
      success = false;
      final Map<String, dynamic> jsonResponse = jsonDecode(res.body);
      error = jsonResponse['message'];
    }

    return EmptyAPIResult(error: error, success: success);
  } catch (err) {
    return EmptyAPIResult(
      error: 'Maaf, terjadi kesalahan pada sistem.',
      success: false,
    );
  }
}

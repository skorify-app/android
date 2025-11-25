import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:skorify/handlers/classes.dart';

Future<EmptyAPIResult> update(String session, Object data) async {
  final String completeURL = 'https://skorify-api.hosea.dev/account/update';
  final Map<String, String> headers = {
    'Content-Type': 'application/json',
    'Session': session,
  };
  final String body = jsonEncode(data);

  try {
    final res = await http.put(
      Uri.parse(completeURL),
      headers: headers,
      body: body,
    );

    String error = '';
    bool success = true;

    if (res.statusCode != 204) {
      success = false;
      final Map<String, dynamic> jsonResponse = jsonDecode(res.body);
      error = jsonResponse['message'];
    }

    return EmptyAPIResult(error: error, success: success);
  } catch (err, stack) {
    print(stack);
    return EmptyAPIResult(
      error: 'Maaf, terjadi kesalahan pada sistem.',
      success: false,
    );
  }
}

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:skorify/handlers/classes.dart';

Future<StringAPIResult> submit(String session, Object data) async {
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

    String result = res.body;
    bool success = true;

    if (res.statusCode != 200) {
      success = false;
      result = '';
    }

    return StringAPIResult(result: result, success: success);
  } catch (err) {
    return StringAPIResult(result: '', success: false);
  }
}

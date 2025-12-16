import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:skorify/handlers/classes.dart';

Future<DefaultAPIResult> detail(String session, String scoreId) async {
  final String completeURL = 'https://skorify-api.hosea.dev/scores/$scoreId';
  final Map<String, String> headers = {'Session': session};

  try {
    final res = await http.get(Uri.parse(completeURL), headers: headers);
    final Map<String, dynamic> jsonResponse = jsonDecode(res.body);

    if (res.statusCode != 200) {
      return DefaultAPIResult(result: {}, success: false);
    }

    return DefaultAPIResult(result: jsonResponse, success: true);
  } catch (err) {
    return DefaultAPIResult(result: {}, success: false);
  }
}

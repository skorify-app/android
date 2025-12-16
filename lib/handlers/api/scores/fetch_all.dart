import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:skorify/handlers/classes.dart';

Future<ListAPIResult> fetchAll(String session) async {
  final String completeURL = 'https://skorify-api.hosea.dev/scores';
  final Map<String, String> headers = {'Session': session};

  try {
    final res = await http.get(Uri.parse(completeURL), headers: headers);
    final List<dynamic> jsonResponse = jsonDecode(res.body);

    List<Map<String, dynamic>> result = [];
    bool success = false;

    if (res.statusCode == 200) {
      result = jsonResponse
          .whereType<Map>()
          .map(
            (e) => Map<String, dynamic>.from(
              (e).map((k, v) => MapEntry(k.toString(), v?.toString() ?? '')),
            ),
          )
          .toList();
      success = true;
    }

    return ListAPIResult(result: result, success: success);
  } catch (err) {
    return ListAPIResult(result: [], success: false);
  }
}

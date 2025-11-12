import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:skorify/handlers/classes.dart';

Future<QuestionAPIResult> fetchQuestions(
  String session,
  String subtestId,
) async {
  final String completeURL =
      'https://skorify-api.hosea.dev/questions/get/$subtestId';
  final Map<String, String> headers = {'Session': session};

  try {
    final res = await http.get(Uri.parse(completeURL), headers: headers);

    final List<Map<String, String>> jsonResponse = jsonDecode(res.body);

    if (jsonResponse[0].containsKey('message')) {
      final List<Map<String, String>> error = [
        {
          'message':
              jsonResponse[0]['message'] ??
              'Maaf, terjadi kesalahan pada sistem.',
        },
      ];

      return QuestionAPIResult(result: error, success: false);
    }

    return QuestionAPIResult(result: jsonResponse, success: true);
  } catch (err) {
    final List<Map<String, String>> error = [
      {'message': 'Maaf, terjadi kesalahan pada sistem'},
    ];
    return QuestionAPIResult(result: error, success: false);
  }
}

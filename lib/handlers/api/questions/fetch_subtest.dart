import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:skorify/handlers/classes.dart';
import 'package:skorify/handlers/util.dart';

Future<QuestionAPIResult> fetchSubtestQuestions(
  String session,
  String subtestId,
) async {
  final String completeURL =
      '$API_URL/questions?type=subtest&subtest_id=$subtestId';
  final Map<String, String> headers = {'Session': session};

  try {
    final res = await http.get(Uri.parse(completeURL), headers: headers);

    final List<dynamic> jsonResponse = jsonDecode(res.body);

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

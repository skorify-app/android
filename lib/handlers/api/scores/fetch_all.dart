import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:skorify/handlers/classes.dart';

Future<ScoreDataAPIResult> fetchAll(String session) async {
  final String completeURL = 'https://skorify-api.hosea.dev/scores';
  final Map<String, String> headers = {'Session': session};

  try {
    final res = await http.get(Uri.parse(completeURL), headers: headers);
    final List<dynamic> jsonResponse = jsonDecode(res.body);

    if (jsonResponse.isEmpty) {
      return ScoreDataAPIResult(scores: [], success: true);
    }

    if (res.statusCode != 200) {
      return ScoreDataAPIResult(scores: [], success: false);
    }

    List<ScoreData> result = [];
    for (int i = 0; i < jsonResponse.length; i++) {
      Map<String, dynamic> raw = jsonResponse[i];

      AnswerSummary answerSummary = AnswerSummary(
        correct: raw['correct_answers'],
        incorrect: raw['incorrect_answers'],
        empty: raw['empty_answers'],
      );

      ScoreData scoreData = ScoreData(
        id: raw['id'],
        name: raw['name'],
        score: raw['score'],
        recordedAt: raw['recorded_at'],
        answerSummary: answerSummary,
      );

      result.add(scoreData);
    }

    return ScoreDataAPIResult(scores: result, success: true);
  } catch (err) {
    return ScoreDataAPIResult(scores: [], success: false);
  }
}

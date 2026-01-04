import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:skorify/handlers/classes.dart';
import 'package:skorify/handlers/util.dart';

Future<QuizInfoResult> fetchList(String session) async {
  final String completeURL = '$API_URL/subtests';
  final Map<String, String> headers = {'Session': session};

  try {
    final res = await http.get(Uri.parse(completeURL), headers: headers);
    final Map<String, dynamic> jsonResponse = jsonDecode(res.body);

    if (res.statusCode == 200) {
      List<dynamic> subtestInfo = jsonResponse['subtests'];
      Map<String, dynamic> umpbInfo = jsonResponse['umpb'];

      List<SubtestInfo> subtests = [];
      for (int i = 0; i < subtestInfo.length; i++) {
        Map<String, dynamic> rawSubtest = subtestInfo[i];
        SubtestInfo subtest = SubtestInfo(
          id: rawSubtest['subtest_id'].toString(),
          name: rawSubtest['subtest_name'],
          imageName: rawSubtest['subtest_image_name'],
          duration: rawSubtest['duration_seconds'],
          totalQuestions: rawSubtest['total_questions'],
        );
        subtests.add(subtest);
      }

      List<SubtestSummary> umpbSubtestsSummary = [];
      List<dynamic> rawSubtestsSummary = umpbInfo['questions'];
      for (int i = 0; i < rawSubtestsSummary.length; i++) {
        Map<String, dynamic> rawSubtestSummary = rawSubtestsSummary[i];
        SubtestSummary subtestSummary = SubtestSummary(
          name: rawSubtestSummary['name'],
          amount: rawSubtestSummary['amount'],
        );
        umpbSubtestsSummary.add(subtestSummary);
      }

      UMPB umpb = UMPB(
        totalQuestions: umpbInfo['total'],
        duration: umpbInfo['duration'],
        subtests: umpbSubtestsSummary,
      );

      QuizInfo result = QuizInfo(subtests: subtests, umpb: umpb);
      return QuizInfoResult(info: result, success: true);
    }

    return QuizInfoResult(
      info: QuizInfo(
        subtests: [],
        umpb: UMPB(totalQuestions: 0, duration: 0, subtests: []),
      ),
      success: false,
    );
  } catch (err) {
    return QuizInfoResult(
      info: QuizInfo(
        subtests: [],
        umpb: UMPB(totalQuestions: 0, duration: 0, subtests: []),
      ),
      success: false,
    );
  }
}

class DefaultAPIResult {
  final Map<String, dynamic> result;
  final bool success;

  DefaultAPIResult({required this.result, required this.success});
}

class SubtestListAPIResult {
  final List<Map<String, dynamic>> result;
  final bool success;

  SubtestListAPIResult({required this.result, required this.success});
}

class StringAPIResult {
  final String result;
  final bool success;

  StringAPIResult({required this.result, required this.success});
}

class EmptyAPIResult {
  final String error;
  final bool success;

  EmptyAPIResult({required this.success, required this.error});
}

class QuestionAPIResult {
  final bool success;
  final List<Map<String, dynamic>> result;

  QuestionAPIResult({required this.success, required this.result});
}

class QuestionData {
  final int id;
  final String text;
  final List<Map<String, String>> choices;

  QuestionData({required this.id, required this.text, required this.choices});
}

class Questions {
  final int subtestId;
  final List<QuestionData> questions;

  Questions({required this.subtestId, required this.questions});
}

class Subtest {
  final int id;
  final String name;
  final String imageName;

  Subtest({required this.id, required this.name, required this.imageName});
}

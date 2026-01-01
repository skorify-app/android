class DefaultAPIResult {
  final Map<String, dynamic> result;
  final bool success;

  DefaultAPIResult({required this.result, required this.success});
}

class ListAPIResult {
  final List<Map<String, dynamic>> result;
  final bool success;

  ListAPIResult({required this.result, required this.success});
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
  final List<dynamic> result;

  QuestionAPIResult({required this.success, required this.result});
}

class Choice {
  final String label;
  final String choiceValue;

  Choice({required this.label, required this.choiceValue});
}

class QuestionData {
  final int id;
  final String text;
  final List<Choice> choices;
  final String? image;

  QuestionData({
    required this.id,
    required this.text,
    required this.choices,
    required this.image,
  });
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

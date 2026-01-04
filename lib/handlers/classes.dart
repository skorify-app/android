class QuizInfoResult {
  final QuizInfo info;
  final bool success;

  QuizInfoResult({required this.info, required this.success});
}

class QuizInfo {
  final List<SubtestInfo> subtests;
  final UMPB umpb;

  QuizInfo({required this.subtests, required this.umpb});
}

class SubtestInfo {
  final String id;
  final String name;
  final String imageName;
  final int duration;
  final int totalQuestions;

  SubtestInfo({
    required this.id,
    required this.name,
    required this.imageName,
    required this.duration,
    required this.totalQuestions,
  });
}

class UMPB {
  final int totalQuestions;
  final int duration;
  final List<SubtestSummary> subtests;

  UMPB({
    required this.totalQuestions,
    required this.duration,
    required this.subtests,
  });
}

class ScoreDataAPIResult {
  final List<ScoreData> scores;
  final bool success;

  ScoreDataAPIResult({required this.scores, required this.success});
}

class ScoreData {
  final String id;
  final String name;
  final int score;
  final String recordedAt;
  final AnswerSummary answerSummary;

  ScoreData({
    required this.id,
    required this.name,
    required this.score,
    required this.recordedAt,
    required this.answerSummary,
  });
}

class AnswerSummary {
  final int correct;
  final int incorrect;
  final int empty;

  AnswerSummary({
    required this.correct,
    required this.incorrect,
    required this.empty,
  });
}

class SubtestSummary {
  final String name;
  final int amount;

  SubtestSummary({required this.name, required this.amount});
}

class DefaultAPIResult {
  final Map<String, dynamic> result;
  final bool success;

  DefaultAPIResult({required this.result, required this.success});
}

class MapList {
  final Map<String, List<Map<String, dynamic>>> result;
  final bool success;

  MapList({required this.result, required this.success});
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

class Subtest {
  final int id;
  final String name;
  final String imageName;

  Subtest({required this.id, required this.name, required this.imageName});
}

class AnswersData {
  final String type;
  final String? subtestId;
  final List<Answer> answers;

  AnswersData({
    required this.type,
    required this.subtestId,
    required this.answers,
  });
}

class Answer {
  final String id;
  final String number;
  String answerLabel;

  Map<String, dynamic> toJson() => {
    'id': id,
    'number': number,
    'answerLabel': answerLabel,
  };

  Answer({required this.id, required this.number, required this.answerLabel});
}

class QuestionsInfo {
  final String type;
  final String? subtestId;
  final int duration;
  final List<Question> questions;

  QuestionsInfo({
    required this.type,
    required this.subtestId,
    required this.duration,
    required this.questions,
  });
}

class Question {
  final int id;
  final String text;
  final List<Choice> choices;
  final String? image;

  Question({
    required this.id,
    required this.text,
    required this.choices,
    required this.image,
  });
}

class Choice {
  final String label;
  final String choiceValue;

  Choice({required this.label, required this.choiceValue});
}

import 'package:flutter/material.dart';
import 'package:skorify/components/questions/answer_option_button.dart';
import 'package:skorify/components/questions/question_background.dart';
import 'package:skorify/components/questions/question_colors_indication.dart';
import 'package:skorify/components/questions/question_bottom_nav.dart';
import 'package:skorify/components/questions/question_nav_button.dart';
import 'package:skorify/components/questions/question_number.dart';
import 'package:skorify/components/questions/question_numbers_grid.dart';
import 'package:skorify/components/questions/timer.dart';
import 'package:skorify/components/misc/top_bar.dart';
import 'package:skorify/handlers/classes.dart';
import 'package:skorify/pages/submitting_answers_page.dart';

List<Map<String, String>> userAnswers = [];
List<int> unsureQuestions = [];

class QuestionsScreen extends StatefulWidget {
  const QuestionsScreen({
    super.key,
    required this.questions,
    required this.subtestId,
    required this.duration,
  });

  final Questions questions;
  final String subtestId;
  final int duration;
  final int questionNumber = 1;

  @override
  State<QuestionsScreen> createState() => _QuestionsScreenState();
}

class _QuestionsScreenState extends State<QuestionsScreen> {
  bool showQuestionNav = false;

  late int totalQuestions = widget.questions.questions.length;
  late int duration = widget.duration;

  late int _questionNumber = widget.questionNumber;
  late QuestionData question = widget.questions.questions[_questionNumber - 1];

  List<Widget> choices = [];
  late String? _selectedLabel = _getAnswer(_questionNumber.toString());
  late IconData unsureButtonIcon = Icons.bookmark_add;

  @override
  void initState() {
    super.initState();
    userAnswers = [];
    unsureQuestions = [];
  }

  void nextQuestion() {
    changeNumber(_questionNumber + 1);
  }

  void previousQuestion() {
    changeNumber(_questionNumber - 1);
  }

  void changeNumber(int questonNum) {
    setState(() {
      _questionNumber = questonNum;
      question = widget.questions.questions[_questionNumber - 1];
      _selectedLabel = _getAnswer(_questionNumber.toString());
      unsureButtonIcon = (unsureQuestions.contains(_questionNumber))
          ? Icons.bookmark_remove
          : Icons.bookmark_add;
    });
  }

  void unsure() {
    if (unsureQuestions.contains(_questionNumber)) {
      unsureQuestions.remove(_questionNumber);
      unsureButtonIcon = Icons.bookmark_add;
    } else {
      unsureButtonIcon = Icons.bookmark_remove;
      unsureQuestions.add(_questionNumber);
    }

    setState(() {
      unsureButtonIcon = unsureButtonIcon;
    });
  }

  void choiceClick({
    required int id,
    required String questionNumber,
    required String answerLabel,
  }) {
    setState(() {
      _selectedLabel = (_selectedLabel == answerLabel) ? null : answerLabel;
    });

    String? currentAnswer = _getAnswer(questionNumber);

    if (currentAnswer != null && answerLabel == currentAnswer) {
      _removeAnswer(questionNumber);
      return;
    }

    _setAnswer(id, questionNumber, answerLabel);
  }

  void submitAnswers() {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) => SubmittingAnswersPage(
          subtestId: widget.subtestId,
          answers: userAnswers,
        ),
      ),
    );
  }

  Future<bool?> _showExitConfirmation() {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text(
            'Ingin Berhenti?',
            style: TextStyle(color: Colors.black),
          ),
          content: const Text(
            'Apakah kamu yakin ingin berhenti mengerjakan tes?',
            style: TextStyle(color: Colors.black),
          ),
          backgroundColor: Colors.white,

          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context, false),
              child: const Text('Tidak', style: TextStyle(color: Colors.black)),
            ),
            TextButton(
              onPressed: () => Navigator.pop(context, true),
              child: const Text('Iya', style: TextStyle(color: Colors.black)),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: TopBar(),
      body: PopScope(
        canPop: false,
        onPopInvokedWithResult: (bool didPop, Object? result) async {
          if (didPop) return;

          bool confimed = await _showExitConfirmation() ?? false;
          if (context.mounted && confimed) {
            Navigator.pop(context);
          }
        },
        child: GestureDetector(
          onTap: () => {
            setState(() {
              showQuestionNav = false;
            }),
          },
          child: Stack(
            children: [
              Column(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          Container(
                            margin: const EdgeInsets.all(16),
                            padding: const EdgeInsets.all(16),
                            decoration: questionBackground,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Timer dan tombol Sembunyikan
                                Timer(
                                  duration: duration,
                                  submitAnswers: submitAnswers,
                                ),
                                const SizedBox(height: 16),

                                // Nomor Soal
                                QuestionNumber(number: '$_questionNumber'),
                                const SizedBox(height: 20),

                                // Teks Soal
                                Text(
                                  question.text,
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.black87,
                                    height: 1.5,
                                  ),
                                ),
                                const SizedBox(height: 24),

                                // Opsi Jawaban
                                for (
                                  var i = 0;
                                  i < question.choices.length;
                                  i++
                                ) ...[
                                  AnswerOptionButton(
                                    key: ValueKey(
                                      'q$_questionNumber:a${question.choices[i].label}',
                                    ),
                                    label: question.choices[i].label,
                                    text: question.choices[i].choiceValue,
                                    selected:
                                        _selectedLabel ==
                                        question.choices[i].label,
                                    onTap: () => choiceClick(
                                      id: question.id,
                                      questionNumber: _questionNumber
                                          .toString(),
                                      answerLabel: question.choices[i].label,
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                ],
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  // Navigasi soal (tombol selanjutnya, sebelumnya, ragu-ragu)
                  QuestionNav(
                    previousQuestionMethod: previousQuestion,
                    nextQuestionMethod: nextQuestion,
                    unsureMethod: unsure,
                    submitMethod: submitAnswers,
                    unsureButtonIcon: unsureButtonIcon,
                    questionNumber: _questionNumber,
                    totalQuestions: totalQuestions,
                    showSubmitButton: totalQuestions == userAnswers.length,
                  ),
                ],
              ),

              // Panel navigasi soal-soal
              if (showQuestionNav)
                Positioned(
                  right: 0,
                  top: 0,
                  bottom: 180,
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.75,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(20),
                        bottomLeft: Radius.circular(20),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: const Color.fromARGB(59, 0, 0, 0),
                          spreadRadius: 2,
                          blurRadius: 10,
                          offset: const Offset(-3, 0),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        // Question Grid
                        const SizedBox(height: 45),
                        QuestionNumbersGrid(
                          itemCount: totalQuestions,
                          itemBuilder: (context, index) {
                            int questionNum = index + 1;
                            String status = '';
                            bool isAnswered = userAnswers.any(
                              (item) =>
                                  item['number'] == questionNum.toString(),
                            );
                            if (isAnswered) {
                              status = 'ANSWERED';
                            } else if (unsureQuestions.contains(questionNum)) {
                              status = 'UNSURE';
                            }
                            return _buildQuestionNavItem(questionNum, status);
                          },
                        ),

                        // Question color indication
                        QuestionColorsIndication(),
                      ],
                    ),
                  ),
                ),

              // Floating Question Navigator Button
              QuestionNavButton(
                onTap: () {
                  setState(() {
                    showQuestionNav = !showQuestionNav;
                  });
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildQuestionNavItem(int number, String status) {
    Color bgColor;
    Color textColor = Color.fromRGBO(255, 255, 255, 1);
    if (status == 'ANSWERED') {
      bgColor = const Color(0xFF4CAF50);
    } else if (status == 'UNSURE') {
      bgColor = const Color(0xFFFFD700);
      textColor = const Color.fromRGBO(0, 0, 0, 0.5);
    } else {
      bgColor = const Color.fromRGBO(224, 224, 224, 1);
    }

    return InkWell(
      child: Container(
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(8),
          border: number == _questionNumber
              ? Border.all(color: const Color(0xFF4A90E2), width: 2)
              : null,
        ),
        child: Center(
          child: Text(
            '$number',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: textColor,
            ),
          ),
        ),
      ),
      onTap: () => {
        changeNumber(number),
        setState(() {
          showQuestionNav = !showQuestionNav;
        }),
      },
    );
  }
}

void _setAnswer(int id, String number, String label) {
  for (var answer in userAnswers) {
    if (answer['number'] == number) {
      answer['answerLabel'] = label;
      return;
    }
  }

  userAnswers.add({
    'id': id.toString(),
    'number': number,
    'answerLabel': label,
  });
}

String? _getAnswer(String number) {
  for (var answer in userAnswers) {
    if (answer['number'] == number) return answer['answerLabel'];
  }

  return null;
}

void _removeAnswer(String number) {
  userAnswers.removeWhere((answer) => answer['number'] == number);
}

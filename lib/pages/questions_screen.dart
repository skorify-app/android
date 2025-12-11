import 'package:flutter/material.dart';
import 'package:skorify/components/questions/answer_option_button.dart';
import 'package:skorify/components/questions/color_indication_text.dart';
import 'package:skorify/components/questions/question_background.dart';
import 'package:skorify/components/questions/question_nav.dart';
import 'package:skorify/components/questions/question_nav_button.dart';
import 'package:skorify/components/questions/question_number.dart';
import 'package:skorify/components/questions/timer.dart';
import 'package:skorify/components/misc/top_bar.dart';
import 'package:skorify/handlers/classes.dart';
import 'package:skorify/pages/submitting_answers_page.dart';

List<Map<String, String>> userAnswers = [];

class QuestionsScreen extends StatefulWidget {
  const QuestionsScreen({
    super.key,
    required this.questions,
    required this.subtestId,
  });

  final String subtestId;
  final int questionNumber = 1;
  final Questions questions;

  @override
  State<QuestionsScreen> createState() => _QuestionsScreenState();
}

class _QuestionsScreenState extends State<QuestionsScreen> {
  bool showQuestionNav = false;

  late int totalQuestions = widget.questions.questions.length;

  late int _questionNumber = widget.questionNumber;
  late QuestionData question = widget.questions.questions[_questionNumber - 1];

  List<Widget> choices = [];
  late String? _selectedLabel = _getAnswer(_questionNumber.toString());

  @override
  void initState() {
    super.initState();
    userAnswers = [];
  }

  void nextQuestion() {
    setState(() {
      _questionNumber++;
      question = widget.questions.questions[_questionNumber - 1];
      _selectedLabel = _getAnswer(_questionNumber.toString());
    });
  }

  void previousQuestion() {
    setState(() {
      _questionNumber--;
      question = widget.questions.questions[_questionNumber - 1];
      _selectedLabel = _getAnswer(_questionNumber.toString());
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: TopBar(),
      body: Stack(
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
                            Timer(),
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
                                    _selectedLabel == question.choices[i].label,
                                onTap: () => choiceClick(
                                  id: question.id,
                                  questionNumber: _questionNumber.toString(),
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
                submitMethod: submitAnswers,
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
                    // Header
                    Container(
                      padding: const EdgeInsets.only(top: 30),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                showQuestionNav = false;
                              });
                            },
                            child: const Icon(Icons.close, color: Colors.white),
                          ),
                        ],
                      ),
                    ),

                    // Question Grid
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: GridView.builder(
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 5,
                                crossAxisSpacing: 12,
                                mainAxisSpacing: 12,
                                childAspectRatio: 1,
                              ),
                          itemCount: 10,
                          itemBuilder: (context, index) {
                            return _buildQuestionNavItem(index + 1);
                          },
                        ),
                      ),
                    ),

                    // Question color indication
                    Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        children: [
                          ColorIndicationText(
                            text: 'Sudah Dijawab',
                            colorCode: 0xFF4CAF50,
                          ),
                          const SizedBox(height: 8),
                          ColorIndicationText(
                            text: 'Ragu-ragu',
                            colorCode: 0xFFFFD700,
                          ),
                          const SizedBox(height: 8),
                          ColorIndicationText(
                            text: 'Belum Dijawab',
                            colorCode: 0xFFE0E0E0,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

          // Floating Question Navigator Button
          Positioned(
            top: 10,
            right: 0,
            child: GestureDetector(
              onTap: () {
                setState(() {
                  showQuestionNav = !showQuestionNav;
                });
              },
              child: QuestionNavButton(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuestionNavItem(int number) {
    Color bgColor;
    if (number == 8) {
      bgColor = const Color(0xFF4CAF50); // Answered
    } else if (number == 3 || number == 5) {
      bgColor = const Color(0xFFFFD700); // Doubt
    } else {
      bgColor = Colors.grey.shade300; // Unanswered
    }

    return Container(
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(8),
        border: number == 1
            ? Border.all(color: const Color(0xFF4A90E2), width: 2)
            : null,
      ),
      child: Center(
        child: Text(
          '$number',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: number == 1 || number == 3 || number == 5
                ? Colors.white
                : Colors.black54,
          ),
        ),
      ),
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
  userAnswers.removeWhere((answer) => answer['answerLabel'] == number);
}

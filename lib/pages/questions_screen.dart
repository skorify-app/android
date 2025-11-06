import 'package:flutter/material.dart';
import 'package:skorify/components/questions/answer_option_button.dart';
import 'package:skorify/components/questions/question_nav.dart';
import 'package:skorify/components/questions/question_number.dart';
import 'package:skorify/components/questions/timer.dart';
import 'package:skorify/components/questions/top_bar.dart';

class QuestionsScreen extends StatefulWidget {
  const QuestionsScreen({super.key});

  final int questionNumber = 1;

  @override
  State<QuestionsScreen> createState() => _QuestionsScreenState();
}

class _QuestionsScreenState extends State<QuestionsScreen> {
  late int _questionNumber;
  bool showQuestionNav = false;

  @override
  void initState() {
    super.initState();
    _questionNumber = 1;
  }

  void nextQuestion() {
    setState(() {
      _questionNumber++;
    });
  }

  void previousQuestion() {
    setState(() {
      _questionNumber--;
    });
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
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                              color: const Color.fromARGB(41, 158, 158, 158),
                              spreadRadius: 1,
                              blurRadius: 10,
                            ),
                          ],
                        ),
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
                            const Text(
                              '''Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.
                                  Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.''',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.black87,
                                height: 1.5,
                              ),
                            ),
                            const SizedBox(height: 24),

                            // Opsi Jawaban
                            ...List.generate(
                                  4,
                                  (i) => AnswerOptionButton(
                                    text:
                                        'Lorem ipsum dolor sit amet, consectetur adipiscing elit',
                                  ),
                                )
                                .expand<Widget>(
                                  (w) => [w, const SizedBox(height: 10)],
                                )
                                .toList()
                              ..removeLast(),
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
                questionNumber: _questionNumber,
              ),

              // Navbar Aplikasi
              Container(
                color: const Color(0xFF0D2A47),
                child: SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        _buildNavItem(Icons.home, 'Beranda'),
                        _buildNavItem(Icons.assignment, 'Aktivitas'),
                        _buildNavItem(Icons.person, 'Akun'),
                      ],
                    ),
                  ),
                ),
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
                    // Legend
                    Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Container(
                                width: 20,
                                height: 20,
                                decoration: BoxDecoration(
                                  color: const Color(0xFF4CAF50),
                                  borderRadius: BorderRadius.circular(4),
                                ),
                              ),
                              const SizedBox(width: 8),
                              const Text(
                                'Sudah dijawab',
                                style: TextStyle(fontSize: 12),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Row(
                            children: [
                              Container(
                                width: 20,
                                height: 20,
                                decoration: BoxDecoration(
                                  color: const Color(0xFFFFD700),
                                  borderRadius: BorderRadius.circular(4),
                                ),
                              ),
                              const SizedBox(width: 8),
                              const Text(
                                'Ragu-ragu',
                                style: TextStyle(fontSize: 12),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Row(
                            children: [
                              Container(
                                width: 20,
                                height: 20,
                                decoration: BoxDecoration(
                                  color: Colors.grey.shade300,
                                  borderRadius: BorderRadius.circular(4),
                                ),
                              ),
                              const SizedBox(width: 8),
                              const Text(
                                'Belum dijawab',
                                style: TextStyle(fontSize: 12),
                              ),
                            ],
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
              child: Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: const Color(0xFF4A90E2),
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(25),
                    bottomLeft: Radius.circular(25),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: const Color.fromARGB(55, 0, 0, 0),
                      spreadRadius: 1,
                      blurRadius: 5,
                      offset: const Offset(-2, 0),
                    ),
                  ],
                ),
                child: const Icon(
                  Icons.arrow_back_ios,
                  color: Colors.white,
                  size: 20,
                ),
              ),
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

  Widget _buildNavItem(IconData icon, String label) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, color: Colors.white, size: 24),
        const SizedBox(height: 4),
        Text(label, style: const TextStyle(color: Colors.white, fontSize: 12)),
      ],
    );
  }
}

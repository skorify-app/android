import 'package:flutter/material.dart';
import 'package:skorify/components/misc/bottom_navbar.dart';
import 'package:skorify/components/misc/top_bar.dart';
import 'package:skorify/components/test_result/question_card.dart';

class ResultScreen extends StatefulWidget {
  const ResultScreen({super.key, required this.scoreData});

  final Map<String, dynamic> scoreData;

  @override
  State<ResultScreen> createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {
  late Map<String, dynamic> scoreData = {};

  @override
  void initState() {
    super.initState();
    setState(() {
      scoreData = widget.scoreData;
    });
  }

  int _selectedNavbarIndex = 1;
  void _onItemTapped(int index) {
    setState(() {
      _selectedNavbarIndex = index;
    });

    if (index == 0) {
      Navigator.pushNamed(context, '/homepage');
    } else if (index == 1) {
      Navigator.pushNamed(context, '/activity');
    } else if (index == 2) {
      Navigator.pushNamed(context, '/account');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F6F8),
      appBar: TopBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: GestureDetector(
                      onTap: () => Navigator.pushNamed(context, '/activity'),
                      child: Container(
                        width: 34,
                        height: 34,
                        decoration: const BoxDecoration(
                          color: Color(0xFF1E293B),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.arrow_back,
                          color: Colors.white,
                          size: 18,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),

                  Text(
                    scoreData['subtest_name'],
                    style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF1F2937),
                    ),
                  ),

                  const SizedBox(height: 24),
                  Text(
                    "SKOR",
                    style: TextStyle(
                      fontSize: 12,
                      letterSpacing: 1.5,
                      fontWeight: FontWeight.w500,
                    ),
                  ),

                  const SizedBox(height: 8),
                  Text(
                    scoreData['score'].toString(),
                    style: TextStyle(
                      fontSize: 70,
                      fontWeight: FontWeight.bold,
                      height: 1,
                    ),
                  ),

                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Benar : ${scoreData['answers']['correct']}",
                        style: TextStyle(fontSize: 13),
                      ),

                      const SizedBox(width: 24),
                      Text(
                        "Salah : ${scoreData['answers']['incorrect']}",
                        style: TextStyle(fontSize: 13),
                      ),

                      const SizedBox(width: 24),
                      Text(
                        "Kosong : ${scoreData['answers']['empty']}",
                        style: TextStyle(fontSize: 13),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            for (var i = 0; i < scoreData['questions'].length; i++) ...[
              QuestionCard(
                questionText: scoreData['questions'][i]['text'],
                choices: (scoreData['questions'][i]['choices'] as List<dynamic>)
                    .map<Map<String, String>>((choice) {
                      return {
                        'label': choice['label'] ?? '',
                        'choice_value': choice['choice_value'] ?? '',
                      };
                    })
                    .toList(),
                correctAnswer: scoreData['questions'][i]['correctAnswer'],
                userAnswer: scoreData['questions'][i]['userAnswer'] ?? '-1',
              ),
            ],

            const SizedBox(height: 40),
          ],
        ),
      ),

      bottomNavigationBar: BottomNavbar(
        index: _selectedNavbarIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}

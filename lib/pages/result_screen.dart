import 'package:flutter/material.dart';
import 'package:skorify/components/misc/bottom_navbar.dart';
import 'package:skorify/components/misc/top_bar.dart';
import 'package:skorify/components/test_result/question_card.dart';

class ResultScreen extends StatefulWidget {
  const ResultScreen({super.key, required this.scoreId});

  final String scoreId;

  @override
  State<ResultScreen> createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {
  late String scoreId = widget.scoreId;

  int _selectedNavbarIndex = 1;
  void _onItemTapped(int index) {
    setState(() {
      _selectedNavbarIndex = index;
    });

    if (index == 0) {
      Navigator.pushNamed(context, '/homepage');
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
                    scoreId,
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
                      color: Colors.grey.shade500,
                    ),
                  ),

                  const SizedBox(height: 8),
                  const Text(
                    "455",
                    style: TextStyle(
                      fontSize: 70,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      height: 1,
                    ),
                  ),

                  const SizedBox(height: 12),
                  const Text(
                    "CBT Potensi Akademik, Bahasa Indonesia - #1",
                    style: TextStyle(fontSize: 14, color: Color(0xFF4B5563)),
                  ),

                  const SizedBox(height: 8),
                  const Text(
                    "Benar : 12     Salah : 18     Kosong : 5",
                    style: TextStyle(fontSize: 13, color: Color(0xFF6B7280)),
                  ),
                ],
              ),
            ),

            //SOAL
            QuestionCard(
              questionText:
                  'Usia Ayah 3 kali usia Budi. Jika 5 tahun yang akan datang jumlah usia mereka adalah 80 tahun',
              choices: [
                {'label': 'a', 'choice_value': '15 Tahun'},
                {'label': 'b', 'choice_value': '16 Tahun'},
                {'label': 'c', 'choice_value': '17 Tahun'},
                {'label': 'd', 'choice_value': '20 Tahun'},
              ],
              correctAnswer: 'a',
              userAnswer: 'd',
            ),

            _buildQuestionCard(
              soal:
                  "Suhu air mula-mula 25°C. Setelah dipanaskan naik 15°C. Berapa suhu akhirnya?",
              opsi: ["30°C", "35°C", "40°C", "45°C"],
              jawabanBenar: 2,
              jawabanUser: 1,
            ),

            _buildQuestionCard(
              soal: "Planet manakah yang merupakan pusat tata surya?",
              opsi: ["Bumi", "Matahari", "Mars", "Jupiter"],
              jawabanBenar: 1,
              jawabanUser: 0,
            ),

            _buildQuestionCard(
              soal: "Makhluk hidup yang bernapas menggunakan insang adalah...",
              opsi: ["Kucing", "Burung", "Ikan", "Ular"],
              jawabanBenar: 2,
              jawabanUser: 3,
            ),

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

  Widget _buildQuestionCard({
    required String soal,
    required List<String> opsi,
    required int jawabanBenar,
    required int jawabanUser,
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: Color.fromRGBO(0, 0, 0, 0.07),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            soal,
            style: const TextStyle(
              fontSize: 15,
              color: Color(0xFF1F2937),
              height: 1.4,
            ),
          ),
          const SizedBox(height: 16),

          for (int i = 0; i < opsi.length; i++)
            _buildAnswerOption(
              opsi[i],
              isCorrect: i == jawabanBenar,
              isUserAnswer: i == jawabanUser,
            ),
        ],
      ),
    );
  }

  Widget _buildAnswerOption(
    String text, {
    required bool isCorrect,
    required bool isUserAnswer,
  }) {
    Color dotColor = Colors.grey.shade300;

    if (isCorrect) {
      dotColor = Colors.green;
    } else if (isUserAnswer && !isCorrect) {
      dotColor = Colors.red;
    }

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Container(
            width: 18,
            height: 18,
            decoration: BoxDecoration(color: dotColor, shape: BoxShape.circle),
          ),
          const SizedBox(width: 12),
          Text(text, style: const TextStyle(fontSize: 15)),
        ],
      ),
    );
  }
}

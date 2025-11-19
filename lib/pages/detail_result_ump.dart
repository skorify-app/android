import 'package:flutter/material.dart';
import 'package:skorify/components/misc/bottom_navbar.dart';
import 'package:skorify/components/misc/top_bar.dart';

class DetailResultUmp extends StatefulWidget {
  const DetailResultUmp({super.key});

  @override
  State<DetailResultUmp> createState() => DetailResultUmpState();
}

class DetailResultUmpState extends State<DetailResultUmp> {
  int _selectedNavbarIndex = 1;

  void _onItemTapped(int index) {
    setState(() {
      _selectedNavbarIndex = index;
    });

    if (index == 0) {
      Navigator.pushNamed(context, '/homepages');
    } else if (index == 2) {
      Navigator.pushNamed(context, '/account');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF4F6FA),
      appBar: TopBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // HEADER
            Container(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // BACK BUTTON
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, '/activity');
                    },
                    child: Container(
                      width: 34,
                      height: 34,
                      decoration: BoxDecoration(
                        color: const Color(0xFF1E293B),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.arrow_back,
                        color: Colors.white,
                        size: 18,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),

                  const Text(
                    "Matematika",
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF1F2937),
                    ),
                  ),
                  const SizedBox(height: 4),

                  const Text(
                    "Skor 358",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF1F2937),
                    ),
                  ),

                  const SizedBox(height: 8),

                  // STATISTIK
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      _buildStatItem("Benar", 15),
                      const SizedBox(width: 20),
                      _buildStatItem("Salah", 15),
                      const SizedBox(width: 20),
                      _buildStatItem("Kosong", 5),
                    ],
                  ),
                ],
              ),
            ),

            // LIST SOAL
            _buildQuestionCard(
              soal:
                  "Usia Ayah 3 kali usia Budi. Jika 5 tahun yang akan datang jumlah usia mereka adalah 80 tahun, maka usia Budi sekarang adalah ... ",
              options: ["15 Tahun", "16 Tahun", "17 Tahun", "18 Tahun"],
              correctIndex: 1,
              userAnswer: 1, // benar
            ),

            _buildQuestionCard(
              soal:
                  "Usia Ayah 3 kali usia Budi. Jika 5 tahun yang akan datang jumlah usia mereka adalah 80 tahun, maka usia Budi sekarang adalah ... ",
              options: ["15 Tahun", "16 Tahun", "17 Tahun", "18 Tahun"],
              correctIndex: 0,
              userAnswer: 2, // salah
            ),

            _buildQuestionCard(
              soal:
                  "Usia Ayah 3 kali usia Budi. Jika 5 tahun yang akan datang jumlah usia mereka adalah 80 tahun, maka usia Budi sekarang adalah ... ",
              options: ["15 Tahun", "16 Tahun", "17 Tahun", "18 Tahun"],
              correctIndex: 3,
              userAnswer: -1, // kosong
            ),

            const SizedBox(height: 40),
          ],
        ),
      ),

      // BOTTOM NAVIGATION
      bottomNavigationBar: BottomNavbar(
        index: _selectedNavbarIndex,
        onTap: _onItemTapped,
      ),
    );
  }

  // Widget statistik
  Widget _buildStatItem(String label, int value) {
    return Row(
      children: [
        Text(
          '$label : ',
          style: TextStyle(
            fontSize: 13,
            color: Colors.grey.shade600,
          ),
        ),
        Text(
          '$value',
          style: const TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }

  // Card Soal
  Widget _buildQuestionCard({
    required String soal,
    required List<String> options,
    required int correctIndex,
    required int userAnswer,
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 6),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xFFF1F1F1)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 8,
            offset: const Offset(0, 3),
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            soal,
            style: const TextStyle(
              fontSize: 14,
              color: Color(0xFF1F2937),
            ),
          ),
          const SizedBox(height: 12),

          // OPTIONS
          Column(
            children: List.generate(options.length, (index) {
              Color dotColor = Colors.grey.shade300;

              // JAWABAN BENAR
              if (index == correctIndex) {
                dotColor = const Color(0xFF4ADE80); // hijau
              }

              // JAWABAN USER SALAH
              if (userAnswer == index && userAnswer != correctIndex) {
                dotColor = const Color(0xFFEF4444); // merah
              }

              return Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Row(children: [
                  Container(
                    width: 18,
                    height: 18,
                    decoration: BoxDecoration(
                      color: dotColor,
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Text(
                    options[index],
                    style: const TextStyle(
                      fontSize: 14,
                      color: Color(0xFF374151),
                    ),
                  )
                ]),
              );
            }),
          )
        ],
      ),
    );
  }
}

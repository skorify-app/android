import 'package:flutter/material.dart';
import 'package:skorify/components/misc/bottom_navbar.dart';
import 'package:skorify/components/misc/top_bar.dart';

class TestResultUmp extends StatefulWidget {
  const TestResultUmp({super.key});

  @override
  State<TestResultUmp> createState() => _TestResultUmpState();
}

class _TestResultUmpState extends State<TestResultUmp> {
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
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 10),

            // Back button
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Align(
                alignment: Alignment.centerLeft,
                child: GestureDetector(
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
              ),
            ),

            const SizedBox(height: 20),

            // Title
            const Text(
              "Hasil tes CBT Potensi akademik",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1F2937),
              ),
            ),

            const SizedBox(height: 25),

            // Skor label
            Text(
              "SKOR",
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w500,
                color: Colors.grey.shade500,
                letterSpacing: 2,
              ),
            ),
            const SizedBox(height: 5),

            // Skor angka
            const Text(
              "1000",
              style: TextStyle(
                fontSize: 70,
                height: 1,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),

            const SizedBox(height: 10),

            // Nama tes
            const Text(
              "Simulasi Ujian Mandiri Polibatam (UMP) - #1",
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w500,
                color: Color(0xFF1F2937),
              ),
              textAlign: TextAlign.center,
            ),

            const SizedBox(height: 10),

            // Statistik
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildStatItem("Benar", 55),
                const SizedBox(width: 18),
                _buildStatItem("Salah", 50),
                const SizedBox(width: 18),
                _buildStatItem("Kosong", 10),
              ],
            ),

            const SizedBox(height: 20),

            // LESSON CARDS
            _buildLessonCard(
              context,
              image: "assets/images/matematika.png",
              title: "Matematika",
              skor: 358,
              benar: 15,
              salah: 15,
              kosong: 5,
            ),

            _buildLessonCard(
              context,
              image: "assets/images/sains.png",
              title: "Sains",
              skor: 387,
              benar: 20,
              salah: 12,
              kosong: 3,
            ),

            _buildLessonCard(
              context,
              image: "assets/images/computer.png",
              title: "Computational thinking",
              skor: 396,
              benar: 25,
              salah: 13,
              kosong: 2,
            ),

            _buildLessonCard(
              context,
              image: "assets/images/inggris.png",
              title: "Bahasa Inggris",
              skor: 396,
              benar: 25,
              salah: 13,
              kosong: 2,
            ),

            _buildLessonCard(
              context,
              image: "assets/images/indonesia.png",
              title: "Bahasa Indonesia",
              skor: 387,
              benar: 22,
              salah: 14,
              kosong: 4,
            ),

            const SizedBox(height: 30),
          ],
        ),
      ),

      bottomNavigationBar: BottomNavbar(
        index: _selectedNavbarIndex,
        onTap: _onItemTapped,
      ),
    );
  }

  // ======================
  //      STAT ITEM
  // ======================
  Widget _buildStatItem(String label, int value) {
    return Row(
      children: [
        Text(
          "$label : ",
          style: TextStyle(
            fontSize: 13,
            color: Colors.grey.shade600,
          ),
        ),
        Text(
          "$value",
          style: const TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w600,
            color: Color(0xFF1F2937),
          ),
        ),
      ],
    );
  }

  // ======================
  //      LESSON CARD
  // ======================
  Widget _buildLessonCard(
    BuildContext context, {
    required String image,
    required String title,
    required int skor,
    required int benar,
    required int salah,
    required int kosong,
  }) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(
          context,
          '/detail_result_ump',
          arguments: {
            "title": title,
            "skor": skor,
            "benar": benar,
            "salah": salah,
            "kosong": kosong,
          },
        );
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 18, vertical: 7),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(18),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.06),
              blurRadius: 12,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              height: 55,
              width: 55,
              decoration: BoxDecoration(
                color: const Color(0xFFE0F2FE),
                borderRadius: BorderRadius.circular(12),
              ),
              padding: const EdgeInsets.all(8),
              child: Image.asset(
                image,
                fit: BoxFit.contain,
              ),
            ),

            const SizedBox(width: 15),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    "Skor $skor",
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Color(0xFF4B5563),
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    "Benar : $benar   Salah : $salah   Kosong : $kosong",
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey.shade600,
                    ),
                  ),
                ],
              ),
            ),

            Icon(
              Icons.chevron_right,
              color: Colors.grey.shade400,
              size: 24,
            ),
          ],
        ),
      ),
    );
  }
}

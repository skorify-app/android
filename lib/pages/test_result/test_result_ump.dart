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
      backgroundColor: const Color(0xFFF5F6F8),
      appBar: TopBar(),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 10),

            /// BACK BUTTON
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

            /// TITLE
            const Text(
              "Hasil Tes CBT Potensi Akademik",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1F2937),
              ),
            ),

            const SizedBox(height: 25),

            /// LABEL SKOR
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

            /// NUMERIC SKOR
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

            /// TEST NAME
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

            /// SUMMARY ROW
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

            /// SUBJECT CARDS
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

  /// ========================
  /// STAT ITEM
  /// ========================
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

  /// ========================
  /// LESSON CARD (NEW STYLE)
  /// ========================
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
        String route = '';

        switch (title) {
          case "Matematika":
            route = '/detail_result_ump_mtk';
            break;
          case "Sains":
            route = '/detail_result_ump_sains';
            break;
          case "Computational thinking":
            route = '/detail_result_ump_ct';
            break;
          case "Bahasa Inggris":
            route = '/detail_result_ump_inggris';
            break;
          case "Bahasa Indonesia":
            route = '/detail_result_ump_indonesia';
            break;
          default:
            route = '/detail_result_ump_mtk';
        }

        Navigator.pushNamed(
          context,
          route,
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
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          color: const Color(0xFFBDD8E9), // biru muda
          borderRadius: BorderRadius.circular(22),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              height: 60,
              width: 60,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(18),
              ),
              padding: const EdgeInsets.all(10),
              child: Image.asset(image, fit: BoxFit.contain),
            ),

            const SizedBox(width: 18),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF1F2937),
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    "Skor $skor",
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF374151),
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    "Benar : $benar   Salah : $salah   Kosong : $kosong",
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey.shade700,
                    ),
                  ),
                ],
              ),
            ),

            Icon(
              Icons.chevron_right,
              color: Colors.grey.shade500,
              size: 26,
            )
          ],
        ),
      ),
    );
  }
}

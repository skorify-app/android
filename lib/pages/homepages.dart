import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'questions_screen.dart'; // ✅ Pastikan file ini ada

class HomePages extends StatefulWidget {
  const HomePages({super.key});

  @override
  State<HomePages> createState() => _HomePagesState();
}

class _HomePagesState extends State<HomePages> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    if (index == 2) {
      Navigator.pushNamed(context, '/setting');
    }
  }

  // 🔹 Dialog Detail Subtes Generik (BARU)
  void _showSubtestDialog(BuildContext context, String title) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Colors.white, 
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Align(
                  alignment: Alignment.topRight,
                  child: IconButton(
                    icon: const Icon(Icons.close, color: Colors.black54),
                    onPressed: () => Navigator.pop(context),
                  ),
                ),
                Text(
                  "Detail Uji $title",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.inter(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: const Color(0xFF001D39),
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  "CBT Potensi Akademik, $title - #1\n20 Agustus 2024",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.inter(fontSize: 13, color: Colors.black54),
                ),
                const Divider(height: 30, thickness: 1),

                // 🔹 Detail Waktu dan Soal
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Column(
                    children: [
                      _buildDetailRow(
                        icon: Icons.timer_outlined, 
                        label: "Total waktu", 
                        value: "30 menit"
                      ),
                      const SizedBox(height: 10),
                      _buildDetailRow(
                        icon: Icons.list_alt_rounded, 
                        label: "Total soal", 
                        value: "25 soal"
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 30),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                      // NAVIGASI KE QUESTIONS SCREEN
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const QuestionsScreen()),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF002855),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 14),
                    ),
                    child: Text(
                      "MULAI",
                      style: GoogleFonts.inter(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  // 🔹 Helper untuk baris detail (Waktu & Soal)
  Widget _buildDetailRow({required IconData icon, required String label, required String value}) {
    return Row(
      children: [
        Icon(icon, color: const Color(0xFF002855)),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            label, 
            style: GoogleFonts.inter(fontSize: 14, color: Colors.black87)
          ),
        ),
        Text(
          value, 
          style: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.black87)
        ),
      ],
    );
  }

  // 🔹 Dialog Simulasi UMPB (tetap ada untuk kartu utama)
  void _showSimulasiDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Colors.white, 
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Align(
                  alignment: Alignment.topRight,
                  child: IconButton(
                    icon: const Icon(Icons.close, color: Colors.black54), 
                    onPressed: () => Navigator.pop(context),
                  ),
                ),
                Center(
                  child: Text(
                    "Detail Simulasi UMPB",
                    style: GoogleFonts.inter(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFF001D39),
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                Center(
                  child: Text(
                    "Simulasi Ujian Mandiri Polibatam (UMP) - #1\n20 Agustus 2024",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.inter(fontSize: 13, color: Colors.black54),
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    const Icon(Icons.timer, color: Color(0xFF002855)),
                    const SizedBox(width: 8),
                    Text("Total waktu: 150 menit", style: GoogleFonts.inter(fontSize: 14)),
                  ],
                ),
                const SizedBox(height: 6),
                Row(
                  children: [
                    const Icon(Icons.list_alt_rounded, color: const Color(0xFF001D39)),
                    const SizedBox(width: 8),
                    Text("Total soal: 125 soal", style: GoogleFonts.inter(fontSize: 14)),
                  ],
                ),
                const Divider(height: 30, thickness: 1),
                _buildTimelineItem("Matematika", "30 menit", "25 soal"),
                _buildTimelineItem("Sains", "30 menit", "25 soal"),
                _buildTimelineItem("Computational thinking", "30 menit", "25 soal"),
                _buildTimelineItem("Bahasa Inggris", "30 menit", "25 soal"),
                _buildTimelineItem("Bahasa Indonesia", "30 menit", "25 soal"),
                const SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const QuestionsScreen()),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF002855),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 14),
                    ),
                    child: Text(
                      "MULAI",
                      style: GoogleFonts.inter(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }


  // 🔹 Subtest Card (Diperbarui untuk memanggil dialog generik)
  Widget _buildSubtestCard(String imagePath, String title) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 4,
            offset: const Offset(2, 3),
          ),
        ],
      ),
      padding: const EdgeInsets.all(12),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        // 💡 Semua kartu subtes sekarang memanggil dialog generik
        onTap: () => _showSubtestDialog(context, title), 
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 70,
              width: 70,
              decoration: BoxDecoration(
                color: const Color(0xFFE7F0FB),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Image.asset(imagePath, fit: BoxFit.contain),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              title,
              textAlign: TextAlign.center,
              style: GoogleFonts.inter(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: const Color(0xFF002855),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // 🔹 Item dengan garis timeline
  Widget _buildTimelineItem(String title, String waktu, String soal) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          children: [
            Container(
              width: 10,
              height: 10,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Color(0xFF002855),
              ),
            ),
            Container(
              width: 2,
              height: 40,
              color: Colors.grey.shade300,
            ),
          ],
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: GoogleFonts.inter(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFF002855),
                  ),
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    const Icon(Icons.timer_outlined, size: 14, color: Colors.black54),
                    const SizedBox(width: 4),
                    Text(waktu, style: GoogleFonts.inter(fontSize: 12, color: Colors.black54)),
                    const SizedBox(width: 12),
                    const Icon(Icons.article_outlined, size: 14, color: Colors.black54),
                    const SizedBox(width: 4),
                    Text(soal, style: GoogleFonts.inter(fontSize: 12, color: Colors.black54)),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.only(left: 16.0),
          child: Image.asset(
            'assets/images/logo.png',
            height: 20,
            width: 20,
          ),
        ),
        title: const Text(
          "Skorify",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        elevation: 0,
        backgroundColor: Colors.transparent,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/home-background.png"),
              fit: BoxFit.fitWidth,
              alignment: Alignment.topCenter,
            ),
          ),
        ),
      ),

      // 🔹 Body
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "CBT Potensi akademik",
              style: GoogleFonts.inter(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: const Color(0xFF001D39),
              ),
            ),
            const SizedBox(height: 4),
            Text(
              "Simulasi Ujian Mandiri Polibatam (UMPB)",
              style: GoogleFonts.inter(
                fontSize: 14,
                color: const Color(0xFF001D39),
              ),
            ),
            const SizedBox(height: 20),

            // 🔹 Kartu simulasi utama
            GestureDetector(
              onTap: () => _showSimulasiDialog(context),
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 4,
                      offset: const Offset(2, 3),
                    ),
                  ],
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                        color: const Color(0xFFE7F0FB),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Image.asset(
                        'assets/images/UMPB.png',
                        fit: BoxFit.contain,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Simulasi Ujian Mandiri Polibatam (UMPB)",
                            style: GoogleFonts.inter(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: const Color(0xFF001D39),
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            "Uji dan asah pengetahuanmu dengan latihan simulasi UMP sungguhan!",
                            style: GoogleFonts.inter(
                              fontSize: 13,
                              color: const Color(0xFF001D39),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 24),
            Text(
              "Coba uji persubtes yuk!",
              style: GoogleFonts.inter(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: const Color(0xFF001D39),
              ),
            ),
            const SizedBox(height: 16),

            // 🔹 Grid Subtes
            GridView.count(
              crossAxisCount: 2,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              childAspectRatio: 1.1,
              children: [
                _buildSubtestCard('assets/images/sains.png', "Sains"),
                _buildSubtestCard('assets/images/matematika.png', "Matematika"),
                _buildSubtestCard('assets/images/computer.png', "Computational thinking"),
                _buildSubtestCard('assets/images/inggris.png', "Bahasa Inggris"),
                _buildSubtestCard('assets/images/indonesia.png', "Bahasa Indonesia"),
              ],
            ),
          ],
        ),
      ),

      // 🔹 Bottom NavBar
      bottomNavigationBar: ClipRRect(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(15),
          topRight: Radius.circular(15),
        ),
        child: BottomNavigationBar(
          backgroundColor: const Color(0xFF001D39),
          currentIndex: _selectedIndex,
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.white70,
          onTap: _onItemTapped,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home_rounded),
              label: "Beranda",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.assignment_rounded),
              label: "Aktivitas",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person_rounded),
              label: "Akun",
            ),
          ],
        ),
      ),
    );
  }
}
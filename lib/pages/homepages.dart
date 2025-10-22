import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

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
                color: const Color(0xFF002855),
              ),
            ),
            const SizedBox(height: 4),
            Text(
              "Simulasi Ujian Mandiri Polibatam (UMPB)",
              style: GoogleFonts.inter(
                fontSize: 14,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 20),

            // 🔹 Kartu utama
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
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
                            color: const Color(0xFF002855),
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          "Uji dan asah pengetahuanmu dengan latihan simulasi UMP sungguhan!",
                          style: GoogleFonts.inter(
                            fontSize: 13,
                            color: Colors.black54,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            Text(
              "Coba uji persubtes yuk!",
              style: GoogleFonts.inter(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: const Color(0xFF002855),
              ),
            ),
            const SizedBox(height: 16),

            // 🔹 GridView untuk subtes
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

      // 🔹 Bottom Navigation Bar
      bottomNavigationBar: ClipRRect(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(15),
          topRight: Radius.circular(15),
        ),
        child: BottomNavigationBar(
          backgroundColor: const Color(0xFF0A2342),
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

  // 🔹 Widget kartu subtes pakai gambar (bukan Icon)
  Widget _buildSubtestCard(String imagePath, String title) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      padding: const EdgeInsets.all(12),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        /*onTap: () {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Kamu pilih $title")),
          );
        },*/
        // temp code
        onTap: () {
          Navigator.pushNamed(context, '/test/english');
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              imagePath,
              height: 50,
              fit: BoxFit.contain,
            ),
            const SizedBox(height: 8),
            Text(
              title,
              textAlign: TextAlign.center,
              style: GoogleFonts.inter(
                fontSize: 13,
                fontWeight: FontWeight.w500,
                color: const Color(0xFF002855),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

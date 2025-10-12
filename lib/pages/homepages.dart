import 'package:flutter/material.dart';

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

    // 🔹 Tambahan navigasi
    if (index == 2) {
      // Jika tab "Akun" ditekan, pindah ke halaman setting
      Navigator.pushNamed(context, '/setting');
    }
    // Kalau nanti kamu mau bikin halaman aktivitas, bisa tambahkan:
    // else if (index == 1) { Navigator.pushNamed(context, '/activity'); }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: const Text(
          "Skorify",
          style: TextStyle(
            fontFamily: 'Inter',
            fontWeight: FontWeight.bold,
          ),
        ),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "CBT Potensi Akademik",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Color(0xFF002855),
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              "Simulasi Ujian Mandiri Polibatam (UMPB)\n"
              "Uji dan asah pengetahuanmu dengan latihan simulasi UMP sungguhan!",
              style: TextStyle(fontSize: 16, color: Colors.black87),
            ),
            const SizedBox(height: 20),

            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.lightBlue[50],
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  const Icon(Icons.assignment, size: 40, color: Colors.blue),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text(
                          "Simulasi Ujian Mandiri Polibatam (UMPB)",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: Color(0xFF002855),
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          "Uji dan asah pengetahuanmu dengan latihan simulasi UMP sungguhan!",
                          style: TextStyle(fontSize: 14, color: Colors.black87),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),
            const Text(
              "Coba uji persubtes yuk!",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Color(0xFF002855),
              ),
            ),
            const SizedBox(height: 16),

            GridView.count(
              crossAxisCount: 2,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              children: [
                _buildSubtestCard(Icons.science, "Sains"),
                _buildSubtestCard(Icons.calculate, "Matematika"),
                _buildSubtestCard(Icons.memory, "Computational Thinking"),
                _buildSubtestCard(Icons.menu_book, "Bahasa Inggris"),
                _buildSubtestCard(Icons.book, "Bahasa Indonesia"),
              ],
            ),
          ],
        ),
      ),

      // 🔹 Bottom Navigation
      bottomNavigationBar: ClipRRect(
  borderRadius: const BorderRadius.only(
    topLeft: Radius.circular(15),
    topRight: Radius.circular(15),
  ),
  child: BottomNavigationBar(
    backgroundColor:const Color(0xFF001D39),
    items: const [
      BottomNavigationBarItem(
        icon: Icon(Icons.home),
        label: "Beranda",
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.checklist),
        label: "Aktivitas",
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.person),
        label: "Akun",
      ),
    ],
    currentIndex: _selectedIndex,
    selectedItemColor: const Color(0xFF001D39),
    unselectedItemColor: Colors.white,
    onTap: _onItemTapped,
  ),
),

    );
  }

  Widget _buildSubtestCard(IconData icon, String title) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          const BoxShadow(
            color: Colors.black12,
            blurRadius: 4,
            offset: Offset(2, 2),
          ),
        ],
      ),
      child: InkWell(
        onTap: () {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Kamu pilih $title")),
          );
        },
        borderRadius: BorderRadius.circular(12),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 40, color: Colors.blue),
            const SizedBox(height: 8),
            Text(
              title,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Color(0xFF002855),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

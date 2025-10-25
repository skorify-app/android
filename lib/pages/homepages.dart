import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // Import untuk Haptic Feedback
import 'package:google_fonts/google_fonts.dart';
import 'questions_screen.dart'; 

class TappableCard extends StatefulWidget {
  final Widget child;
  final VoidCallback onTap;
  final double scaleDown; // Ukuran pengecilan, default 0.98

  const TappableCard({
    Key? key,
    required this.child,
    required this.onTap,
    this.scaleDown = 0.98,
  }) : super(key: key);

  @override
  State<TappableCard> createState() => _TappableCardState();
}

class _TappableCardState extends State<TappableCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 150), // Durasi cepat
      vsync: this,
    );

    _scaleAnimation = Tween<double>(begin: 1.0, end: widget.scaleDown).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  // Aksi saat disentuh
  void _onTapDown(TapDownDetails details) {
    _controller.forward(); // Mulai animasi pengecilan
    HapticFeedback.lightImpact(); // **EFEK GETARAN HALUS**
  }

  // Aksi saat dilepas
  void _onTapUp(TapUpDetails details) {
    _controller.reverse(); // Kembalikan ke ukuran normal
    widget.onTap(); // Panggil fungsi klik
  }

  void _onTapCancel() {
    _controller.reverse(); // Kembalikan jika sentuhan dibatalkan
  }

  @override
  Widget build(BuildContext context) {
    // GestureDetector: Mendeteksi sentuhan
    return GestureDetector(
      onTapDown: _onTapDown,
      onTapUp: _onTapUp,
      onTapCancel: _onTapCancel,
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return Transform.scale(
            scale: _scaleAnimation.value,
            child: widget.child, // Konten Kartu yang asli
          );
        },
      ),
    );
  }
}

class HomePages extends StatefulWidget {
  const HomePages({super.key});

  @override
  State<HomePages> createState() => _HomePagesState();
}

class _HomePagesState extends State<HomePages> {
  int _selectedIndex = 0;

  // 🔹 FUNGSI BOTTOM NAV BAR (TIDAK DIUBAH)
  void _onItemTapped(int index) {
    // Menambahkan Haptic Feedback saat navigasi bar diklik
    HapticFeedback.selectionClick(); 
    
    setState(() {
      _selectedIndex = index;
    });

    if (index == 2) {
      Navigator.pushNamed(context, '/setting');
    }
  }

  // 🔹 Dialog Detail Subtes
  void _showSubtestDialog(BuildContext context, String title) {
    showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: '',
      transitionDuration: const Duration(milliseconds: 300),
      pageBuilder: (_, __, ___) => const SizedBox.shrink(),
      transitionBuilder: (context, animation, _, __) {
        return FadeTransition(
          opacity: CurvedAnimation(parent: animation, curve: Curves.easeInOut),
          child: ScaleTransition(
            scale: CurvedAnimation(parent: animation, curve: Curves.easeOutBack),
            child: Dialog(
              backgroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
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

                    const SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Column(
                        children: [
                          _buildDetailRow(
                            icon: Icons.timer_outlined,
                            label: "Total waktu",
                            value: "30 menit",
                          ),
                          const SizedBox(height: 6),
                          const Divider(thickness: 1, color: Color(0xFFE0E0E0)),
                          const SizedBox(height: 8),
                          _buildDetailRow(
                            icon: Icons.list_alt_rounded,
                            label: "Total soal",
                            value: "25 soal",
                          ),
                          const SizedBox(height: 6),
                          const Divider(thickness: 1, color: Color(0xFFE0E0E0)),
                        ],
                      ),
                    ),

                    const SizedBox(height: 30),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const QuestionsScreen(),
                            ),
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
            ),
          ),
        );
      },
    );
  }


  // 🔹 Helper baris detail
  Widget _buildDetailRow({
    required IconData icon,
    required String label,
    required String value,
  }) {
    return Row(
      children: [
        Icon(icon, color: const Color(0xFF002855)),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            label,
            style: GoogleFonts.inter(fontSize: 14, color: Colors.black87),
          ),
        ),
        Text(
          value,
          style: GoogleFonts.inter(
            fontSize: 14,
            color: Colors.grey[700],
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  // 🔹 Dialog Simulasi UMPB
  void _showSimulasiDialog(BuildContext context) {
    showGeneralDialog(
      context: context,
      barrierLabel: "Simulasi UMPB",
      barrierDismissible: true,
      barrierColor: Colors.black54, // background gelap transparan
      transitionDuration: const Duration(milliseconds: 300), // durasi animasi
      pageBuilder: (context, animation1, animation2) {
        return const SizedBox.shrink();
      },
      transitionBuilder: (context, animation, secondaryAnimation, child) {
        final curvedValue =
            Curves.easeOutBack.transform(animation.value); // efek lembut muncul
        return Transform.scale(
          scale: curvedValue,
          child: Opacity(
            opacity: animation.value,
            child: Dialog(
              backgroundColor: Colors.white,
              shape:
                  RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
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
                        style: GoogleFonts.inter(
                          fontSize: 13,
                          color: Colors.black54,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      children: [
                        const Icon(Icons.timer, color: Color(0xFF002855)),
                        const SizedBox(width: 8),
                        Text(
                          "Total waktu: 150 menit",
                          style: GoogleFonts.inter(fontSize: 14),
                        ),
                      ],
                    ),
                    const SizedBox(height: 6),
                    Row(
                      children: [
                        const Icon(Icons.list_alt_rounded, color: Color(0xFF002855)),
                        const SizedBox(width: 8),
                        Text(
                          "Total soal: 125 soal",
                          style: GoogleFonts.inter(fontSize: 14),
                        ),
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
                            MaterialPageRoute(
                              builder: (context) => const QuestionsScreen(),
                            ),
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
            ),
          ),
        );
      },
    );
  }

  // 🔹 Item timeline
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
                    Text(waktu,
                        style: GoogleFonts.inter(fontSize: 12, color: Colors.black54)),
                    const SizedBox(width: 12),
                    const Icon(Icons.article_outlined, size: 14, color: Colors.black54),
                    const SizedBox(width: 4),
                    Text(soal,
                        style: GoogleFonts.inter(fontSize: 12, color: Colors.black54)),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  // 🔹 Subtest Card dengan TappableCard
  Widget _buildSubtestCard(String imagePath, String title) {
    return TappableCard( // <-- EFEK KLIK DITERAPKAN DI SINI
      onTap: () => _showSubtestDialog(context, title),
      scaleDown: 0.95, 
      child: Container(
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

  // 🔹 Build
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

      // Body
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

            // KARTU SIMULASI UMPB DENGAN TappableCard
            TappableCard( // <-- EFEK KLIK DITERAPKAN DI SINI
              onTap: () => _showSimulasiDialog(context),
              scaleDown: 0.99, // Efek scale yang sangat halus
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

            // Grid Subtes (MENGGUNAKAN _buildSubtestCard yang baru)
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

      // Bottom NavBar (TIDAK DIUBAH, hanya ditambahkan Haptic Feedback di onTap)
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
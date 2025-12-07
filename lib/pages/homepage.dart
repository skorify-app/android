import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:skorify/components/misc/bottom_navbar.dart';
import 'package:skorify/components/misc/top_bar.dart';
import 'package:skorify/handlers/api/session/validate.dart';
import 'package:skorify/handlers/api/subtest/fetch_list.dart';
import 'package:skorify/handlers/classes.dart';
import 'package:skorify/handlers/secure_storage_service.dart';
import 'questions_screen.dart';

class TappableCard extends StatefulWidget {
  final Widget child;
  final VoidCallback onTap;
  final double scaleDown;

  const TappableCard({
    super.key,
    required this.child,
    required this.onTap,
    this.scaleDown = 0.98,
  });

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
      duration: const Duration(milliseconds: 150),
      vsync: this,
    );

    _scaleAnimation = Tween<double>(
      begin: 1.0,
      end: widget.scaleDown,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onTapDown(TapDownDetails details) {
    _controller.forward();
    HapticFeedback.lightImpact();
  }

  void _onTapUp(TapUpDetails details) {
    _controller.reverse();
    widget.onTap();
  }

  void _onTapCancel() {
    _controller.reverse();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: _onTapDown,
      onTapUp: _onTapUp,
      onTapCancel: _onTapCancel,
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return Transform.scale(
            scale: _scaleAnimation.value,
            child: widget.child,
          );
        },
      ),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final SecureStorageService _secureStorage = getStorage();

  int _selectedNavbarIndex = 0;
  late String sessionId;
  late List<Map<String, dynamic>> subtests = [];
  late List<Widget> _subtests = [];

  @override
  void initState() {
    super.initState();
    _checkSessionValidation();
    _fetchSubtestList();
  }

  void _checkSessionValidation() async {
    sessionId = await _secureStorage.get('session') ?? '';
    EmptyAPIResult result = await validateSession(sessionId);
    if (!result.success && result.error == 'INVALID') {
      _secureStorage.delete('session');

      if (!mounted) return;
      Navigator.pushNamedAndRemoveUntil(
        context,
        '/onboarding_page',
        (Route<dynamic> route) => false,
      );
    }
  }

  void _fetchSubtestList() async {
    sessionId = await _secureStorage.get('session') ?? '';
    SubtestListAPIResult subtestsResult = await fetchList(sessionId);
    if (subtestsResult.success) subtests = subtestsResult.result;

    setState(() {
      _subtests = List.from(
        subtests.map((subtest) {
          return _buildSubtestCard(
            subtest['subtest_image_name'],
            subtest['subtest_name'],
          );
        }),
      );
    });
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedNavbarIndex = index;
    });

    if (index == 1) {
      Navigator.pushNamed(context, '/activity');
    } else if (index == 2) {
      Navigator.pushNamed(context, '/account');
    }
  }

  void _showSubtestDialog(BuildContext context, String title) {
    showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: '',
      transitionDuration: const Duration(milliseconds: 300),
      pageBuilder: (_, _, _) => const SizedBox.shrink(),
      transitionBuilder: (context, animation, _, _) {
        return FadeTransition(
          opacity: CurvedAnimation(parent: animation, curve: Curves.easeInOut),
          child: ScaleTransition(
            scale: CurvedAnimation(
              parent: animation,
              curve: Curves.easeOutBack,
            ),
            child: Dialog(
              backgroundColor: const Color(0xFFF5F6F8),
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
                      style: GoogleFonts.inter(
                        fontSize: 13,
                        color: Colors.black54,
                      ),
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
                              builder: (context) =>
                                  const QuestionsScreen(subtestId: '3'),
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

  void _showSimulasiDialog(BuildContext context) {
    showGeneralDialog(
      context: context,
      barrierLabel: "Simulasi UMPB",
      barrierDismissible: true,
      barrierColor: Colors.black54,
      transitionDuration: const Duration(milliseconds: 300),
      pageBuilder: (context, animation1, animation2) => const SizedBox.shrink(),
      transitionBuilder: (context, animation, secondaryAnimation, child) {
        final curvedValue = Curves.easeOutBack.transform(animation.value);
        return Transform.scale(
          scale: curvedValue,
          child: Opacity(
            opacity: animation.value,
            child: Dialog(
              backgroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
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
                        const Icon(
                          Icons.list_alt_rounded,
                          color: Color(0xFF002855),
                        ),
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
                    _buildTimelineItem(
                      "Computational thinking",
                      "30 menit",
                      "25 soal",
                    ),
                    _buildTimelineItem("Bahasa Inggris", "30 menit", "25 soal"),
                    _buildTimelineItem(
                      "Bahasa Indonesia",
                      "30 menit",
                      "25 soal",
                    ),

                    const SizedBox(height: 20),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  const QuestionsScreen(subtestId: '3'),
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
            Container(width: 2, height: 40, color: Colors.grey.shade300),
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
                    const Icon(
                      Icons.timer_outlined,
                      size: 14,
                      color: Colors.black54,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      waktu,
                      style: GoogleFonts.inter(
                        fontSize: 12,
                        color: Colors.black54,
                      ),
                    ),
                    const SizedBox(width: 12),
                    const Icon(
                      Icons.article_outlined,
                      size: 14,
                      color: Colors.black54,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      soal,
                      style: GoogleFonts.inter(
                        fontSize: 12,
                        color: Colors.black54,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSubtestCard(String imagePath, String title) {
    return TappableCard(
      onTap: () => _showSubtestDialog(context, title),
      scaleDown: 0.95,
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xFFBDD8E9),
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Color.fromRGBO(0, 0, 0, 0.07),
              blurRadius: 6,
              offset: const Offset(2, 3),
            ),
          ],
        ),
        padding: const EdgeInsets.all(18),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 70,
              width: 70,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: CachedNetworkImage(
                  imageUrl:
                      'https://skorify-web.hosea.dev/images/subtest/$imagePath',
                ),
              ),
            ),
            const SizedBox(height: 10),
            Text(
              title,
              textAlign: TextAlign.center,
              style: GoogleFonts.inter(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: const Color(0xFF001D39),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // CARD SIMULASI UMPB — REPLACED WITH NEW DESIGN
  Widget _buildSimulasiCard() {
    return TappableCard(
      onTap: () => _showSimulasiDialog(context),
      scaleDown: 0.98,
      child: Container(
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          color: const Color(0xFFBDD8E9), // FULL BIRU MUDA
          borderRadius: BorderRadius.circular(18),
          boxShadow: [
            BoxShadow(
              color: Color.fromRGBO(0, 0, 0, 0.05),
              blurRadius: 6,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// ICON PUTIH DENGAN ROUNDED
            Container(
              width: 70,
              height: 70,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(14),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: Image.asset(
                  'assets/images/UMPB.png',
                  fit: BoxFit.contain,
                ),
              ),
            ),

            const SizedBox(width: 14),

            /// TEXT SEBELAH KANAN
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Simulasi Ujian Mandiri Polibatam (UMPB)",
                    style: GoogleFonts.inter(
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                      color: const Color(0xFF001D39),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    "Uji dan asah pengetahuanmu dengan latihan simulasi UMP sungguhan!",
                    style: GoogleFonts.inter(
                      fontSize: 13,
                      height: 1.3,
                      color: const Color(0xFF001D39),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: TopBar(),

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

            // SIMULASI CARD (REPLACED)
            _buildSimulasiCard(),

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

            GridView.count(
              crossAxisCount: 2,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              childAspectRatio: 1.1,
              children: _subtests,
              /*
              _buildSubtestCard('assets/images/sains.png', "Sains"),
                _buildSubtestCard('assets/images/matematika.png', "Matematika"),
                _buildSubtestCard(
                  'assets/images/computer.png',
                  "Computational thinking",
                ),
                _buildSubtestCard(
                  'assets/images/inggris.png',
                  "Bahasa Inggris",
                ),
                _buildSubtestCard(
                  'assets/images/indonesia.png',
                  "Bahasa Indonesia",
                ),
                */
            ),
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

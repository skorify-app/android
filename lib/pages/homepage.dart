import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_ce_flutter/adapters.dart';
import 'package:skorify/components/homepage/simulation_card.dart';
import 'package:skorify/components/homepage/simulation_dialog.dart';
import 'package:skorify/components/homepage/subtest_card_dialog.dart';
import 'package:skorify/components/misc/bottom_navbar.dart';
import 'package:skorify/components/misc/top_bar.dart';
import 'package:skorify/handlers/api/session/validate.dart';
import 'package:skorify/handlers/api/subtest/fetch_list.dart';
import 'package:skorify/handlers/classes.dart';
import 'package:skorify/handlers/secure_storage_service.dart';

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
  final box = Hive.box('storageBox');

  int _selectedNavbarIndex = 0;
  late String sessionId;
  late List<Map<String, dynamic>> subtests = [];
  late List<Widget> subtestWidgets = [];

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
    ListAPIResult subtestsResult = await fetchList(sessionId);
    if (subtestsResult.success) subtests = subtestsResult.result;

    await box.put('subtest_data', jsonEncode(subtests));

    setState(() {
      subtestWidgets = List.from(
        subtests.map((subtest) {
          return _buildSubtestCard(
            subtest['subtest_id'],
            subtest['subtest_name'],
            subtest['subtest_image_name'].toString(),
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

  void _showSubtestDialog(BuildContext context, String subtestId) {
    Map<String, dynamic> subtest = subtests.firstWhere(
      (map) => map['subtest_id'] == subtestId,
      orElse: () => <String, String>{},
    );

    if (subtest.isEmpty) return;

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
            child: SubtestCardDialog(context: context, subtest: subtest),
          ),
        );
      },
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
          child: SimulationDialog(context: context, animation: animation),
        );
      },
    );
  }

  Widget _buildSubtestCard(
    String subtestId,
    String subtestName,
    String imageName,
  ) {
    return TappableCard(
      onTap: () => _showSubtestDialog(context, subtestId),
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
                      'https://skorify-web.hosea.dev/images/subtest/${imageName.isEmpty ? 'default.png' : imageName}',
                ),
              ),
            ),
            const SizedBox(height: 10),
            Text(
              subtestName,
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

  Widget _buildSimulasiCard() {
    return TappableCard(
      onTap: () => _showSimulasiDialog(context),
      scaleDown: 0.98,
      child: SimulationCard(),
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
              children: subtestWidgets,
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

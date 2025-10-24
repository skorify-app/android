import 'package:flutter/material.dart';
import 'login_pages.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  final PageController _controller = PageController();
  int _currentPage = 0;

  final List<Map<String, String>> _pages = [
    {
      'image': 'assets/images/logo.png',
      'title': 'Skorify',
      'subtitle': 'Aplikasi CBT Test Potensi Akademik',
      'button': '',
    },
    {
      'image': 'assets/images/Dashboard_pengguna.png',
      'title': 'Lakukan Simulasi Ujian Mandiri Polibatam disini!',
      'subtitle': '',
      'button': '',
    },
    {
      'image': 'assets/images/Task.png',
      'title': 'Peroleh hasil dan skor mu!',
      'subtitle': '',
      'button': '',
    },
    {
      'image': 'assets/images/logo.png',
      'title': 'Skorify',
      'subtitle': 'Aplikasi CBT Test Potensi Akademik',
      'button': 'Coba sekarang!',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
          
            Positioned.fill(
              child: Image.asset(
                'assets/images/home-background.png', 
                fit: BoxFit.cover,
                alignment: Alignment.center, 
              ),
            ),

            

            // 🔹 Isi konten onboarding
            PageView.builder(
              controller: _controller,
              itemCount: _pages.length,
              onPageChanged: (index) {
                setState(() {
                  _currentPage = index;
                });
              },
              itemBuilder: (context, index) {
                final page = _pages[index];
                final bool isLastPage = index == _pages.length - 1;

                return Container(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(height: 40),
                      Image.asset(
                        page['image']!,
                        height: 220,
                      ),
                      const SizedBox(height: 20),
                      Text(
                        page['title']!,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                          color: Colors.black,
                        ),
                      ),
                      if (page['subtitle']!.isNotEmpty) ...[
                        const SizedBox(height: 8),
                        Text(
                          page['subtitle']!,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.black,
                          ),
                        ),
                      ],
                      const SizedBox(height: 30),

                      // 🔹 Indikator & panah
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          if (index != 0)
                            IconButton(
                              onPressed: () {
                                _controller.previousPage(
                                  duration: const Duration(milliseconds: 300),
                                  curve: Curves.easeInOut,
                                );
                              },
                              icon: const Icon(Icons.arrow_back_ios,
                                  color: Colors.black),
                            ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: List.generate(
                              _pages.length,
                              (dotIndex) => Container(
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 4),
                                width: 8,
                                height: 8,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: _currentPage == dotIndex
                                      ? Colors.blueAccent
                                      : Colors.grey[300],
                                ),
                              ),
                            ),
                          ),
                          if (!isLastPage)
                            IconButton(
                              onPressed: () {
                                _controller.nextPage(
                                  duration: const Duration(milliseconds: 300),
                                  curve: Curves.easeInOut,
                                );
                              },
                              icon: const Icon(Icons.arrow_forward_ios,
                                  color: Colors.black),
                            ),
                        ],
                      ),
                      const SizedBox(height: 30),

                      // 🔹 Tombol terakhir
                      if (isLastPage)
                        ElevatedButton(
                          onPressed: () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const LoginPage(),
                              ),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF001D39),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 40, vertical: 14),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: Text(
                            page['button']!,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                        ),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

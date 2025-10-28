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
    },
    {
      'image': 'assets/images/Dashboard_pengguna.png',
      'title': 'Lakukan Simulasi Ujian Mandiri Polibatam disini!',
      'subtitle': '',
    },
    {
      'image': 'assets/images/Task.png',
      'title': 'Peroleh hasil dan skor mu!',
      'subtitle': '',
    },
    {
      'image': 'assets/images/logo.png',
      'title': 'Skorify',
      'subtitle': 'Aplikasi CBT Test Potensi Akademik',
      'button': 'Coba sekarang!',
    },
  ];

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bool isLastPage = _currentPage == _pages.length - 1;
    
    // Tinggi yang dicadangkan di bagian bawah untuk Row Indikator (sekitar 60px)
    const double bottomAreaHeight = 60.0; 

    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            
            // 🔹 1. Background Image
            Positioned.fill(
              child: Image.asset(
                'assets/images/home-background.png', 
                fit: BoxFit.cover,
                alignment: Alignment.center, 
              ),
            ),

            // 🔹 2. Isi konten onboarding (Gambar & Teks)
            // Tambahkan Padding hanya setinggi Row Indikator
            Padding(
              padding: const EdgeInsets.only(bottom: bottomAreaHeight),
              child: PageView.builder(
                controller: _controller,
                itemCount: _pages.length,
                onPageChanged: (index) {
                  setState(() {
                    _currentPage = index;
                  });
                },
                itemBuilder: (context, index) {
                  final page = _pages[index];
                  final bool isLastPageItem = index == _pages.length - 1;

                  return Container(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Column(
                      // PENTING: Mengatur alignment ke CENTER
                      // Ini akan memusatkan konten di tengah sisa ruang PageView.
                      mainAxisAlignment: MainAxisAlignment.center, 
                      children: [
                        // --- HAPUS SizedBox(height: topSpacing) ---
                        
                        Image.asset(
                          page['image']!,
                          height: 250,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          page['title']!,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.w700,
                            color: Colors.black,
                          ),
                        ),
                        
                        if (page['subtitle'] != null && page['subtitle']!.isNotEmpty) ...[
                          const SizedBox(height: 8),
                          Text(
                            page['subtitle']!,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontSize: 25, 
                              color: Colors.black,
                            ),
                          ),
                        ],
                        
                        // 🌟 Tombol Coba Sekarang
                        if (isLastPageItem)
                          Padding(
                            padding: const EdgeInsets.only(top: 20.0), 
                            child: ElevatedButton(
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
                          ),
                          
                        // --- HAPUS const Spacer() ---
                      ],
                    ),
                  );
                },
              ),
            ),

            // 🌟 3. INDIKATOR DI BAWAH STACK
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 20.0), 
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    
                    // 1. Tombol Kembali (Panah Kiri) atau Penyeimbang
                    if (_currentPage != 0) 
                      IconButton(
                        onPressed: () {
                          _controller.previousPage(
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeInOut,
                          );
                        },
                        icon: const Icon(Icons.arrow_back_ios,
                            color: Colors.black),
                      )
                    else
                      const SizedBox(width: 48.0), 

                    // 2. Indikator Titik
                    Row(
                      children: List.generate(
                        _pages.length,
                        (dotIndex) => Container(
                          margin: const EdgeInsets.symmetric(horizontal: 4),
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

                    // 3. Tombol Maju (Panah Kanan) atau Penyeimbang
                    if (_currentPage != _pages.length - 1) 
                      IconButton(
                        onPressed: () {
                          _controller.nextPage(
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeInOut,
                          );
                        },
                        icon: const Icon(Icons.arrow_forward_ios,
                            color: Colors.black),
                      )
                    else
                      const SizedBox(width: 48.0), 
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
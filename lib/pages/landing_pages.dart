import 'package:flutter/material.dart';
import 'login_pages.dart';

// TEMA DAN KONSTANTA
const Color kDarkBlue = Color(0xFF001F3F); // Warna latar belakang gelap
const Color kAccentBlue = Color(0xFF007BFF); // Warna tombol
const Color kLightColor = Colors.white;

// Custom Text Styles
const TextStyle kHeaderStyle = TextStyle(
  fontFamily: 'Poppins', 
  fontWeight: FontWeight.w700,
  color: kDarkBlue,
);
const TextStyle kBodyStyle = TextStyle(
  fontFamily: 'Inter', 
  fontWeight: FontWeight.w400,
  color: Colors.black,
);
const TextStyle kBodyWhiteStyle = TextStyle(
  fontFamily: 'Inter',
  fontWeight: FontWeight.w400,
  color: Colors.white70,
  height: 1.6,
  fontSize: 16,
);

// --- WIDGET UTAMA LANDING PAGE ---
class LandingPage extends StatelessWidget {
  const LandingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: kLightColor,
      body: SingleChildScrollView(
        child: Column(
          children: [
            HeaderSection(),
            AboutSection(),
            FeaturesSection(),
            AppFooter(),
          ],
        ),
      ),
    );
  }
}

// -----------------------------------------------------------------------------
// BAGIAN 1: HEADER SECTION (Putih)
// -----------------------------------------------------------------------------
class HeaderSection extends StatelessWidget {
  const HeaderSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 40.0),
      child: Column(
        children: [
          Text(
            'Test Potensi Akademikmu Sekarang!',
            textAlign: TextAlign.center,
            style: kHeaderStyle.copyWith(fontSize: 28, color: kDarkBlue),
          ),
          const SizedBox(height: 10),
          Text(
            'Layanan yang menyediakan sarana simulasi ujian bagi calon mahasiswa Politeknik Negeri Batam.',
            textAlign: TextAlign.center,
            style: kBodyStyle.copyWith(color: Colors.grey[700]),
          ),
          const SizedBox(height: 30),
          SizedBox(
            width: 200,
            child: ElevatedButton.icon(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const LoginPage()),
                );
              },
              icon: const Text('Coba Sekarang!'),
              label: const Icon(Icons.arrow_forward_ios, size: 16),
              style: ElevatedButton.styleFrom(
                backgroundColor: kDarkBlue,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 15),
                textStyle: kBodyStyle.copyWith(fontWeight: FontWeight.w600),
                
              ),
            ),
          ),
          const SizedBox(height: 40),
          // Gambar Mockup
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 20,
                  offset: Offset(0, 10),
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: Image.asset(
                'assets/images/Dashboard_pengguna.png', 
                fit: BoxFit.cover,
                height: 300, 
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// -----------------------------------------------------------------------------
// BAGIAN 2: ABOUT SECTION (Gelap)
// -----------------------------------------------------------------------------
class AboutSection extends StatelessWidget {
  const AboutSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: kDarkBlue,
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 60.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'TENTANG APLIKASI',
            style: kHeaderStyle.copyWith(fontSize: 18, color: Colors.white70),
          ),
          const SizedBox(height: 5),
          Text(
            'SKORIFY',
            style: kHeaderStyle.copyWith(fontSize: 34, color: Colors.white),
          ),
          const SizedBox(height: 20),
          const Text(
            'Aplikasi yang menyediakan sarana simulasi ujian bagi calon mahasiswa Politeknik Negeri Batam dalam rangka mempersiapkan diri menghadapi Ujian Potensi Akademik. Aplikasi ini berfungsi sebagai media belajar, yang menyajikan kumpulan soal sesuai dengan subjek Tes Potensi Akademik (TPA) yang dapat dikerjakan berulang kali sebagai latihan atau simulasi berwaktu.',
            style: kBodyWhiteStyle,
          ),
          const SizedBox(height: 30),
          OutlinedButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const LoginPage()),
                );
            },
            style: OutlinedButton.styleFrom(
              side: const BorderSide(color: Colors.white, width: 2),
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
              textStyle: kBodyStyle.copyWith(fontWeight: FontWeight.w600),
            ),
            child: const Text(
              'Coba Sekarang!',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}

// -----------------------------------------------------------------------------
// BAGIAN 3: FEATURES SECTION (Putih)
// -----------------------------------------------------------------------------
class FeaturesSection extends StatelessWidget {
  const FeaturesSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 60.0),
      child: Column(
        children: [
          Text(
            'Fitur Aplikasi',
            style: kHeaderStyle.copyWith(fontSize: 24, color: kDarkBlue),
          ),
          const SizedBox(height: 5),
          Text(
            'Fitur utama yang disediakan!',
            style: kBodyStyle.copyWith(color: Colors.grey),
          ),
          const SizedBox(height: 40),
          // Layout Fitur Menggunakan Wrap (Lebih Responsif)
          Wrap(
            spacing: 80, 
            runSpacing: 40, 
            alignment: WrapAlignment.center,
            children: const [
              // 1. Fitur Simulasi Tes
              FeatureItem(
                title: 'Simulasi Tes',
                description:
                    'Penggunaan dapat melakukan simulasi tes secara keseluruhan ataupun persubjek.',
                icon: Icons.description_outlined,
              ),
              // 2. Fitur Aktifitas + Kotak Ikon
              FeatureItemWithIcons(
                title: 'Aktifitas',
                description:
                    'Penggunaan dapat melihat skor dan pembahasan soal.',
                icon: Icons.list_alt,
              ),
            ],
          ),
          const SizedBox(height: 30),
        ],
      ),
    );
  }
}

// Widget Item Fitur Sederhana
class FeatureItem extends StatelessWidget {
  final String title;
  final String description;
  final IconData icon;

  const FeatureItem({
    super.key,
    required this.title,
    required this.description,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 150, 
      child: Column(
        children: [
          Icon(icon, size: 40, color: kAccentBlue),
          const SizedBox(height: 10),
          Text(
            title,
            style: kBodyStyle.copyWith(fontWeight: FontWeight.w600, fontSize: 16),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 5),
          Text(
            description,
            style: kBodyStyle.copyWith(fontSize: 14, color: Colors.grey[700]),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

// Widget Item Fitur dengan Kotak Ikon Tambahan
class FeatureItemWithIcons extends StatelessWidget {
  final String title;
  final String description;
  final IconData icon;

  const FeatureItemWithIcons({
    super.key,
    required this.title,
    required this.description,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 250, 
      child: Column(
        children: [
          // Konten Fitur Aktifitas
          FeatureItem(
            title: title,
            description: description,
            icon: icon,
          ),
          const SizedBox(height: 20),
          // Tombol Mulai Simulasi
          ElevatedButton.icon(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const LoginPage()),
                );
            },
            icon: const Text('Mulai Simulasi'),
            label: const Icon(Icons.arrow_forward_ios, size: 16),
            style: ElevatedButton.styleFrom(
              backgroundColor: kDarkBlue,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              textStyle: kBodyStyle.copyWith(fontWeight: FontWeight.w600),
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}

// -----------------------------------------------------------------------------
// BAGIAN 4: FOOTER
// -----------------------------------------------------------------------------
class AppFooter extends StatelessWidget {
  const AppFooter({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: kDarkBlue,
      padding: const EdgeInsets.symmetric(vertical: 15),
      child: Text(
        '©2025 SKORIFY | Politeknik Negeri Batam',
        textAlign: TextAlign.center,
        style: kBodyWhiteStyle.copyWith(fontSize: 12, color: Colors.grey[400]),
      ),
    );
  }
}
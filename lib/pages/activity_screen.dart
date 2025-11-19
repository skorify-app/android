import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:skorify/components/misc/bottom_navbar.dart';
import 'package:skorify/components/misc/top_bar.dart';

class ActivityScreen extends StatefulWidget {
  const ActivityScreen({super.key});

  @override
  State<ActivityScreen> createState() => _ActivityScreenState();
}

class _ActivityScreenState extends State<ActivityScreen> {
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
      backgroundColor: Colors.white,
      appBar: TopBar(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            TextField(
              decoration: InputDecoration(
                hintText: 'Cari disini',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
              ),
            ),
            SizedBox(height: 16),
            Text(
              'Hasil tes CBT Potensi akademik',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),

            // ============================
            // UMP
            // ============================
            ExpansionTile(
              title: Text('Simulasi Ujian Mandiri Polibatam (UMP)'),
              shape: Border(),
              collapsedShape: Border(),
              children: [
                _buildStyledCard(
                  title: 'Simulasi Ujian Mandiri Polibatam (UMP)',
                  subtitle: 'Simulasi Ujian Mandiri Polibatam (UMP) - #1\n20 Agustus 2024',
                  benar: 55,
                  salah: 45,
                  kosong: 10,
                  type: "UMP",
                ),
              ],
            ),

            // ============================
            // SAINS
            // ============================
            ExpansionTile(
              title: Text('CBT Potensi akademik - sains'),
              shape: Border(),
              collapsedShape: Border(),
              children: [
                _buildStyledCard(
                  title: 'CBT Sains',
                  subtitle: 'CBT Sains - #1\n10 Juli 2024',
                  benar: 50,
                  salah: 30,
                  kosong: 10,
                  type: "SAINS",
                ),
              ],
            ),

            // ============================
            // MATEMATIKA
            // ============================
            ExpansionTile(
              title: Text('CBT Potensi akademik - matematika'),
              shape: Border(),
              collapsedShape: Border(),
              children: [
                _buildStyledCard(
                  title: 'CBT Matematika',
                  subtitle: 'CBT Matematika - #1\n5 Juli 2024',
                  benar: 40,
                  salah: 35,
                  kosong: 15,
                  type: "MATEMATIKA",
                ),
              ],
            ),

            // ============================
            // COMPUTATIONAL THINKING
            // ============================
            ExpansionTile(
              title: Text('CBT Potensi akademik - computational thinking'),
              shape: Border(),
              collapsedShape: Border(),
              children: [
                _buildStyledCard(
                  title: 'CBT Computational Thinking',
                  subtitle: 'CBT Computational Thinking - #1\n2 Juli 2024',
                  benar: 45,
                  salah: 30,
                  kosong: 15,
                  type: "CT",
                ),
              ],
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

  // ===============================================================
  // CARD BUILDER
  // SEKARANG SUDAH PUNYA PARAMETER TYPE UNTUK PEMILIHAN HALAMAN
  // ===============================================================
  Widget _buildStyledCard({
    required String title,
    required String subtitle,
    required int benar,
    required int salah,
    required int kosong,
    required String type,
  }) {
    final dataMap = {
      "Benar": benar.toDouble(),
      "Salah": salah.toDouble(),
      "Kosong": kosong.toDouble(),
    };

    return Container(
      margin: EdgeInsets.symmetric(vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Colors.grey.shade300,
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 12,
            spreadRadius: 1,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 4),
            Text(subtitle, style: TextStyle(fontSize: 14, color: Colors.grey[600])),
            SizedBox(height: 16),

            PieChart(
              dataMap: dataMap,
              animationDuration: Duration(milliseconds: 800),
              chartRadius: MediaQuery.of(context).size.width / 2.5,
              colorList: const [
                Color(0xFF00BCD4),
                Color(0xFF3F51B5),
                Color(0xFF448AFF),
              ],
              chartType: ChartType.disc,
              legendOptions: LegendOptions(
                showLegends: true,
                legendPosition: LegendPosition.right,
                legendTextStyle: TextStyle(fontSize: 12),
              ),
              chartValuesOptions: ChartValuesOptions(
                showChartValuesInPercentage: false,
                showChartValues: false,
              ),
            ),

            SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text('Benar: $benar', style: TextStyle(fontSize: 14)),
                Text('Salah: $salah', style: TextStyle(fontSize: 14)),
                Text('Kosong: $kosong', style: TextStyle(fontSize: 14)),
              ],
            ),

            SizedBox(height: 8),
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () {
                  // ============================================
                  // ROUTING BERDASARKAN TIPE TES
                  // ============================================
                  if (type == "UMP") {
                    Navigator.pushNamed(context, '/test_result_ump');
                  } else if (type == "SAINS") {
                    Navigator.pushNamed(context, '/test_result_sains');
                  } 
                },
                child: const Text('Lihat jawaban'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

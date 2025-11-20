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
      backgroundColor: Color(0xFFF5F6F8),
      appBar: TopBar(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            Text(
              'Hasil Tes CBT Potensi Akademik',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            TextField(
              decoration: InputDecoration(
                hintText: 'Cari disini',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
              ),
            ),
            SizedBox(height: 8),

            // UMP
            ExpansionTile(
              title: Text(
                'Simulasi Ujian Mandiri Polibatam (UMP)',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              shape: Border(),
              collapsedShape: Border(),
              children: [
                _buildStyledCard(
                  title: 'Simulasi Ujian Mandiri Polibatam (UMP)',
                  subtitle: RichText(
                    text: TextSpan(
                      style: TextStyle(color: Colors.grey[700], fontSize: 14),
                      children: [
                        TextSpan(
                          text: 'Simulasi Ujian Mandiri Polibatam (UMP) - #1\n20 Agustus 2024',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                  benar: 55,
                  salah: 45,
                  kosong: 0,
                  type: "UMP",
                ),
              ],
            ),

            // SAINS
            ExpansionTile(
              title: Text(
                'CBT - Sains',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              shape: Border(),
              collapsedShape: Border(),
              children: [
                _buildStyledCard(
                  title: 'CBT Potensi Akademik - Sains',
                  subtitle: RichText(
                    text: TextSpan(
                      style: TextStyle(color: Colors.grey[700], fontSize: 14),
                      children: [
                        TextSpan(
                          text: 'CBT Potensi Akademik, Sains - #1\n10 Juli 2024',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                  benar: 50,
                  salah: 40,
                  kosong: 10,
                  type: "Sains",
                ),
              ],
            ),

            ExpansionTile(
              title: Text(
                'CBT - Matematika',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              shape: Border(),
              collapsedShape: Border(),
              children: [
                _buildStyledCard(
                  title: 'CBT Potensi Akademik - Matematika',
                  subtitle: RichText(
                    text: TextSpan(
                      style: TextStyle(color: Colors.grey[700], fontSize: 14),
                      children: [
                        TextSpan(
                          text: 'CBT Potensi Akademik, Matematika - #1\n5 Juli 2024',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                  benar: 50,
                  salah: 35,
                  kosong: 15,
                  type: "Matematika",
                ),
              ],
            ),

            ExpansionTile(
              title: Text(
                'CBT - Computational Thinking',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              shape: Border(),
              collapsedShape: Border(),
              children: [
                _buildStyledCard(
                  title: 'CBT Potensi Akademik Computational Thinking',
                  subtitle: RichText(
                    text: TextSpan(
                      style: TextStyle(color: Colors.grey[700], fontSize: 14),
                      children: [
                        TextSpan(
                          text: 'CBT Potensi Akademik, Computational Thinking - #1\n10 Juni 2024',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                  benar: 80,
                  salah: 10,
                  kosong: 10,
                  type: "CT",
                ),
              ],
            ),

            ExpansionTile(
              title: Text(
                'CBT - Bahasa Inggris',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              shape: Border(),
              collapsedShape: Border(),
              children: [
                _buildStyledCard(
                  title: 'CBT Potensi Akademik Bahasa Inggris',
                  subtitle: RichText(
                    text: TextSpan(
                      style: TextStyle(color: Colors.grey[700], fontSize: 14),
                      children: [
                        TextSpan(
                          text: 'CBT Potensi Akademik, Bahasa Inggris - #1\n11 Juni 2024',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                  benar: 60,
                  salah: 30,
                  kosong: 10,
                  type: "Inggris",
                ),
              ],
            ),

            ExpansionTile(
              title: Text(
                'CBT - Bahasa Indonesia',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              shape: Border(),
              collapsedShape: Border(),
              children: [
                _buildStyledCard(
                  title: 'CBT Potensi Akademik Bahasa Indonesia',
                  subtitle: RichText(
                    text: TextSpan(
                      style: TextStyle(color: Colors.grey[700], fontSize: 14),
                      children: [
                        TextSpan(
                          text: 'CBT Potensi Akademik, Bahasa Indonesia - #1\n12 Juni 2024',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                  benar: 70,
                  salah: 30,
                  kosong: 0,
                  type: "Indonesia",
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

  Widget _buildStyledCard({
    required String title,
    required Widget subtitle,   // ← DIGANTI MENJADI WIDGET
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

            subtitle, // ← SEKARANG JADI WIDGET
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
                  if (type == "UMP") {
                    Navigator.pushNamed(context, '/test_result_ump');
                  } else if (type == "Sains") {
                    Navigator.pushNamed(context, '/test_result_sains');
                  } else if (type == "Matematika") {
                    Navigator.pushNamed(context, '/test_result_mtk');
                  } else if (type == "CT") {
                    Navigator.pushNamed(context, '/test_result_ct');
                  } else if (type == "Inggris") {
                    Navigator.pushNamed(context, '/test_result_inggris');
                  } else if (type == "Indonesia") {
                    Navigator.pushNamed(context, '/test_result_indonesia');
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

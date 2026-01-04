import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:skorify/components/misc/bottom_navbar.dart';
import 'package:skorify/components/misc/top_bar.dart';
import 'package:skorify/handlers/api/scores/fetch_all.dart';
import 'package:skorify/handlers/classes.dart';
import 'package:skorify/handlers/secure_storage_service.dart';

class ActivityScreen extends StatefulWidget {
  const ActivityScreen({super.key});

  @override
  State<ActivityScreen> createState() => _ActivityScreenState();
}

class _ActivityScreenState extends State<ActivityScreen> {
  final SecureStorageService _secureStorage = getStorage();

  int _selectedNavbarIndex = 1;
  late List<ScoreData> scores = [];

  @override
  void initState() {
    super.initState();
    fetchScores();
  }

  void fetchScores() async {
    String sessionId = await _secureStorage.get('session') ?? '';
    ScoreDataAPIResult result = await fetchAll(sessionId);

    if (!result.success) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Maaf, terjadi kesalahan saat mengambil informasi skor kamu',
          ),
        ),
      );
    }

    setState(() {
      scores = result.scores;
    });
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedNavbarIndex = index;
    });
    if (index == 0) {
      Navigator.pushNamed(context, '/homepage');
    } else if (index == 2) {
      Navigator.pushNamed(context, '/account');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF5F6F8),
      appBar: TopBar(),
      body: RefreshIndicator(
        color: const Color.fromRGBO(70, 121, 159, 1.0),
        backgroundColor: const Color.fromRGBO(255, 255, 255, 1),
        onRefresh: () async {
          fetchScores();
        },
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ListView(
            children: [
              Text(
                'Aktivitas',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 16),

              for (var i = 0; i < scores.length; i++) ...[
                ExpansionTile(
                  backgroundColor: const Color(0xFFBDD8E9),
                  collapsedBackgroundColor: const Color(0xFFBDD8E9),
                  title: Padding(
                    padding: EdgeInsetsGeometry.only(
                      left: 10,
                      top: 5,
                      bottom: 5,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          scores[i].name,
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(
                          scores[i].recordedAt,
                          style: TextStyle(fontSize: 13),
                        ),
                      ],
                    ),
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  ),
                  collapsedShape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  ),
                  children: [
                    _buildStyledCard(
                      benar: scores[i].answerSummary.correct,
                      salah: scores[i].answerSummary.incorrect,
                      kosong: scores[i].answerSummary.empty,
                      scoreId: scores[i].id,
                    ),
                  ],
                ),
                const SizedBox(height: 10),
              ],
            ],
          ),
        ),
      ),

      bottomNavigationBar: BottomNavbar(
        index: _selectedNavbarIndex,
        onTap: _onItemTapped,
      ),
    );
  }

  Widget _buildStyledCard({
    required int benar,
    required int salah,
    required int kosong,
    required String scoreId,
  }) {
    final dataMap = {
      "Benar": benar.toDouble(),
      "Salah": salah.toDouble(),
      "Kosong": kosong.toDouble(),
    };

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          PieChart(
            dataMap: dataMap,
            animationDuration: Duration(milliseconds: 800),
            chartRadius: MediaQuery.of(context).size.width / 2.5,
            colorList: const [
              Color(0xFF4CAF50),
              Color(0xFFF44336),
              Color.fromARGB(255, 0, 0, 0),
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
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text('Benar: $benar', style: TextStyle(fontSize: 14)),
                Text('Salah: $salah', style: TextStyle(fontSize: 14)),
                Text('Kosong: $kosong', style: TextStyle(fontSize: 14)),
              ],
            ),
          ),

          Padding(
            padding: EdgeInsetsGeometry.only(top: 12, right: 20, bottom: 12),
            child: Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/result/$scoreId');
                },
                child: const Text('Lihat jawaban'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

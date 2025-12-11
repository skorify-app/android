import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:skorify/components/homepage/timeline_item.dart';
import 'package:skorify/pages/loading_screen.dart';

class SimulationDialog extends StatelessWidget {
  const SimulationDialog({
    super.key,
    required this.context,
    required this.animation,
  });

  final BuildContext context;
  final Animation<double> animation;

  @override
  Widget build(BuildContext ctx) {
    return Opacity(
      opacity: animation.value,
      child: Dialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
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
                  style: GoogleFonts.inter(fontSize: 13, color: Colors.black54),
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
              TimelineItem(
                title: 'Matematika',
                duraton: '30 menit',
                totalQuestions: '25 soal',
              ),
              TimelineItem(
                title: 'Sains',
                duraton: '30 menit',
                totalQuestions: '25 soal',
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
                            const LoadingScreen(subtestId: '3'),
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
    );
  }
}

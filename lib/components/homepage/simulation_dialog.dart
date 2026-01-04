import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:skorify/components/homepage/timeline_item.dart';
import 'package:skorify/handlers/classes.dart';
import 'package:skorify/handlers/util.dart';
import 'package:skorify/pages/loading_questions_screen.dart';

class SimulationDialog extends StatelessWidget {
  const SimulationDialog({
    super.key,
    required this.context,
    required this.animation,
    required this.umpbData,
  });

  final BuildContext context;
  final Animation<double> animation;
  final UMPB umpbData;

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
                  'Detail Simulasi UMPB',
                  style: GoogleFonts.inter(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: const Color(0xFF001D39),
                  ),
                ),
              ),

              const SizedBox(height: 20),
              Row(
                children: [
                  const Icon(Icons.timer, color: Color(0xFF002855)),
                  const SizedBox(width: 8),
                  Text(
                    'Total durasi: ${formatTime(umpbData.duration)}',
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
                    "Total soal: ${umpbData.totalQuestions} soal",
                    style: GoogleFonts.inter(fontSize: 14),
                  ),
                ],
              ),

              const Divider(height: 30, thickness: 1),
              ...umpbData.subtests.map<Widget>((item) {
                return TimelineItem(
                  title: item.name,
                  totalQuestions: '${item.amount} soal',
                );
              }),

              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => LoadingQuestionScreen(
                          type: 'umpb',
                          subtestId: null,
                          duration: umpbData.duration,
                        ),
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

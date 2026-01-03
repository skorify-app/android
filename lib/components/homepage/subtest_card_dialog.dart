import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:skorify/components/homepage/subtest_details.dart';
import 'package:skorify/handlers/util.dart';
import 'package:skorify/pages/loading_questions_screen.dart';

class SubtestCardDialog extends StatelessWidget {
  const SubtestCardDialog({
    super.key,
    required this.context,
    required this.subtest,
  });

  final BuildContext context;
  final Map<String, dynamic> subtest;

  @override
  Widget build(BuildContext ctx) {
    String duration = subtest['duration_seconds'];

    return Dialog(
      backgroundColor: const Color(0xFFF5F6F8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
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
              'Detail Uji ${subtest['subtest_name']}',
              textAlign: TextAlign.center,
              style: GoogleFonts.inter(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: const Color(0xFF001D39),
              ),
            ),

            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                children: [
                  SubtestDetails(
                    icon: Icons.timer_outlined,
                    label: 'Total waktu',
                    value: formatTime(int.parse(duration)),
                  ),
                  const SizedBox(height: 6),
                  const Divider(thickness: 1, color: Color(0xFFE0E0E0)),
                  const SizedBox(height: 8),
                  SubtestDetails(
                    icon: Icons.list_alt_rounded,
                    label: 'Total soal',
                    value: '${subtest['total_questions']} soal',
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
                      builder: (context) => LoadingQuestionScreen(
                        subtestId: '${subtest['subtest_id']}',
                        duration: int.parse(duration),
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
                  'MULAI',
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
    );
  }
}

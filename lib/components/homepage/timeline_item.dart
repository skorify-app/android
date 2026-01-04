import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TimelineItem extends StatelessWidget {
  const TimelineItem({
    super.key,
    required this.title,
    required this.totalQuestions,
  });

  final String title;
  final String totalQuestions;

  @override
  Widget build(BuildContext ctx) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          children: [
            Container(
              width: 10,
              height: 10,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Color(0xFF002855),
              ),
            ),
            Container(width: 2, height: 40, color: Colors.grey.shade300),
          ],
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: GoogleFonts.inter(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFF002855),
                  ),
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    const Icon(
                      Icons.article_outlined,
                      size: 14,
                      color: Colors.black54,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      totalQuestions,
                      style: GoogleFonts.inter(
                        fontSize: 12,
                        color: Colors.black54,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

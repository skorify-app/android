import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SubtestDetails extends StatelessWidget {
  const SubtestDetails({
    super.key,
    required this.icon,
    required this.label,
    required this.value,
  });

  final IconData icon;
  final String label;
  final String value;

  @override
  Widget build(BuildContext ctx) {
    return Row(
      children: [
        Icon(icon, color: const Color(0xFF002855)),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            label,
            style: GoogleFonts.inter(fontSize: 14, color: Colors.black87),
          ),
        ),
        Text(
          value,
          style: GoogleFonts.inter(
            fontSize: 14,
            color: Colors.grey[700],
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}

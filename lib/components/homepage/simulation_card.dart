import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SimulationCard extends StatelessWidget {
  const SimulationCard({super.key});

  @override
  Widget build(BuildContext ctx) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: const Color(0xFFBDD8E9),
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Color.fromRGBO(0, 0, 0, 0.05),
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 70,
            height: 70,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(14),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Image.asset('assets/images/UMPB.png', fit: BoxFit.contain),
            ),
          ),

          const SizedBox(width: 14),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Simulasi Ujian Mandiri Polibatam (UMPB)",
                  style: GoogleFonts.inter(
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    color: const Color(0xFF001D39),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  "Uji dan asah pengetahuanmu dengan latihan simulasi UMP sungguhan!",
                  style: GoogleFonts.inter(
                    fontSize: 13,
                    height: 1.3,
                    color: const Color(0xFF001D39),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

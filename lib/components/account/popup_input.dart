import 'package:flutter/material.dart';

ButtonStyle popupStyle = ElevatedButton.styleFrom(
  backgroundColor: const Color(0xFF001D39),
  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
  padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 12),
);

Widget popupButtonText = Text(
  "SIMPAN",
  style: TextStyle(
    color: Colors.white,
    fontSize: 16,
    fontWeight: FontWeight.bold,
  ),
);

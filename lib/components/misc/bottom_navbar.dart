import 'package:flutter/material.dart';

class BottomNavbar extends StatelessWidget {
  const BottomNavbar({super.key, required this.index, required this.onTap});

  final int index;
  final Function(int) onTap;

  @override
  Widget build(BuildContext ctx) {
    return ClipRRect(
      child: BottomNavigationBar(
        backgroundColor: const Color(0xFF001D39),
        currentIndex: index,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white70,
        onTap: onTap,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_rounded),
            label: "Beranda",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.assignment_rounded),
            label: "Aktivitas",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_rounded),
            label: "Akun",
          ),
        ],
      ),
    );
  }
}

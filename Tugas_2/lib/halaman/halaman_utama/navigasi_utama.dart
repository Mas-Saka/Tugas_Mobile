import 'package:flutter/material.dart';

import 'beranda_screen.dart';
import '../stopwatch/stopwatch_screen.dart';
import '../bantuan/bantuan_screen.dart';

class NavigasiUtama extends StatefulWidget {
  const NavigasiUtama({super.key});

  @override
  State<NavigasiUtama> createState() => _NavigasiUtamaState();
}

class _NavigasiUtamaState extends State<NavigasiUtama> {
  int halamanAktif = 0;

  final List<Widget> halaman = const [
    BerandaScreen(),
    StopwatchScreen(),
    BantuanScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(index: halamanAktif, children: halaman),

      bottomNavigationBar: Container(
        decoration: const BoxDecoration(color: Colors.white),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(12, 8, 12, 8),
            child: Row(
              children: [
                tombolNavigasi('Home', 0),
                tombolNavigasi('Stopwatch', 1),
                tombolNavigasi('Bantuan', 2),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget tombolNavigasi(String teks, int index) {
    final bool aktif = halamanAktif == index;

    return Expanded(
      child: GestureDetector(
        onTap: () {
          setState(() {
            halamanAktif = index;
          });
        },
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            color: aktif ? const Color(0xFFE7EFE8) : Colors.transparent,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Text(
            teks,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: aktif ? const Color(0xFF4F7D58) : const Color(0xFF66736A),
              fontWeight: aktif ? FontWeight.bold : FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

import '../../komponen/kartu_menu.dart';
import 'pertanian_screen.dart';
import 'saka_bali_screen.dart';
import 'weton_screen.dart';

class KalenderScreen extends StatelessWidget {
  const KalenderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Kalender',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          const Text(
            'Informasi Kalender',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Color(0xFF26382B),
            ),
          ),

          const SizedBox(height: 8),

          const Text(
            'Pilih jenis informasi kalender yang ingin dilihat.',
            style: TextStyle(color: Color(0xFF66736A)),
          ),

          const SizedBox(height: 22),

          KartuMenu(
            judul: 'Kalender',
            deskripsi: 'Informasi kalender umum.',
            ketikaDitekan: () {},
          ),

          const SizedBox(height: 12),

          KartuMenu(
            judul: 'Weton Jawa',
            deskripsi: 'Perhitungan dan informasi Weton Jawa.',
            ketikaDitekan: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const WetonScreen()),
              );
            },
          ),

          const SizedBox(height: 12),

          KartuMenu(
            judul: 'Saka Bali',
            deskripsi: 'Informasi kalender Saka Bali.',
            ketikaDitekan: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const SakaBaliScreen()),
              );
            },
          ),

          const SizedBox(height: 12),

          KartuMenu(
            judul: 'Kalender Pertanian',
            deskripsi: 'Informasi kalender yang berkaitan dengan pertanian.',
            ketikaDitekan: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const PertanianScreen()),
              );
            },
          ),
        ],
      ),
    );
  }
}

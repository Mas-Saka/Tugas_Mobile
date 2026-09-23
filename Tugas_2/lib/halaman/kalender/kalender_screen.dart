import 'package:flutter/material.dart';

import '../../komponen/kartu_menu.dart';
import 'halaman_kalender.dart';
import 'pertanian_screen.dart';
import 'saka_bali_screen.dart';
import 'weton_screen.dart';
import 'hijri_screen.dart';

/// Halaman Menu Utama Kalender yang menampilkan pilihan fitur kalender.
class KalenderScreen extends StatelessWidget {
  const KalenderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF1F4EC),
      appBar: AppBar(
        title: const Text(
          'Kalender',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        backgroundColor: const Color(0xFF4F7D58),
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
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

          // Menu 1: Ringkasan Kalender Umum
          KartuMenu(
            judul: 'Kalender',
            deskripsi: 'Informasi dan ringkasan kalender umum.',
            ketikaDitekan: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const HalamanKalender()),
              );
            },
          ),

          const SizedBox(height: 12),

          KartuMenu(
            judul: 'Konversi Tanggal Hijriah',
            deskripsi: 'Mengubah tanggal Masehi menjadi tanggal Hijriah.',
            ketikaDitekan: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const HijriScreen()),
              );
            },
          ),

          const SizedBox(height: 12),

          // Menu 2: Weton Jawa
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

          // Menu 3: Saka Bali
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

          // Menu 4: Kalender Pertanian
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

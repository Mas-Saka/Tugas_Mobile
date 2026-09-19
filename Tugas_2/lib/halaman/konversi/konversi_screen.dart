import 'package:flutter/material.dart';

import '../../komponen/kartu_menu.dart';
import 'tanggal_lahir_screen.dart';
import 'waktu_screen.dart';

class KonversiScreen extends StatelessWidget {
  const KonversiScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Konversi',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          const Text(
            'Konversi Tanggal & Waktu',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Color(0xFF26382B),
            ),
          ),

          const SizedBox(height: 8),

          const Text(
            'Pilih jenis konversi yang tersedia.',
            style: TextStyle(color: Color(0xFF66736A)),
          ),

          const SizedBox(height: 22),

          KartuMenu(
            judul: 'Konversi Tanggal Lahir',
            deskripsi: 'Mengolah informasi berdasarkan tanggal lahir.',
            ketikaDitekan: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const TanggalLahirScreen()),
              );
            },
          ),

          const SizedBox(height: 12),

          KartuMenu(
            judul: 'Konversi Waktu',
            deskripsi: 'Mengubah informasi waktu sesuai kebutuhan.',
            ketikaDitekan: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const WaktuScreen()),
              );
            },
          ),
        ],
      ),
    );
  }
}

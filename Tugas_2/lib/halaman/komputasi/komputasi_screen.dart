import 'package:flutter/material.dart';

import '../../komponen/kartu_menu.dart';
import 'selisih_tanggal_screen.dart';
import 'tambah_tanggal_screen.dart';
import 'kurang_tanggal_screen.dart';
import 'menentukan_hari_screen.dart';

class KomputasiScreen extends StatelessWidget {
  const KomputasiScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Komputasi',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          const Text(
            'Komputasi Tanggal',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Color(0xFF26382B),
            ),
          ),

          const SizedBox(height: 8),

          const Text(
            'Pilih perhitungan yang ingin dilakukan.',
            style: TextStyle(color: Color(0xFF66736A)),
          ),

          const SizedBox(height: 22),

          KartuMenu(
            judul: 'Selisih Tanggal',
            deskripsi: 'Menghitung jarak antara dua tanggal.',
            ketikaDitekan: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const SelisihTanggalScreen()),
              );
            },
          ),

          const SizedBox(height: 12),

          KartuMenu(
            judul: 'Tambah Tanggal',
            deskripsi: 'Menambahkan sejumlah hari ke tanggal tertentu.',
            ketikaDitekan: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const TambahTanggalScreen()),
              );
            },
          ),

          const SizedBox(height: 12),

          KartuMenu(
            judul: 'Kurang Tanggal',
            deskripsi: 'Mengurangi sejumlah hari dari tanggal tertentu.',
            ketikaDitekan: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const KurangTanggalScreen()),
              );
            },
          ),

          const SizedBox(height: 12),

          KartuMenu(
            judul: 'Menentukan Hari',
            deskripsi: 'Menentukan nama hari berdasarkan tanggal.',
            ketikaDitekan: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const MenentukanHariScreen()),
              );
            },
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';

import 'tambah_tanggal_screen.dart';
import 'kurang_tanggal_screen.dart';
import 'selisih_tanggal_screen.dart';
import 'menentukan_hari_screen.dart';

class KomputasiScreen extends StatelessWidget {
  const KomputasiScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Menu Komputasi Tani'),
        backgroundColor: const Color(0xFF3F6849),
        foregroundColor: Colors.white,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildMenuItem(
            context,
            title: 'Tambah Tanggal',
            subtitle: 'Menghitung estimasi tanggal panen',
            icon: Icons.add_circle_outline,
            page: const TambahTanggalScreen(),
          ),
          _buildMenuItem(
            context,
            title: 'Kurang Tanggal',
            subtitle: 'Menghitung waktu mulai semai atau rendam',
            icon: Icons.remove_circle_outline,
            page: const KurangTanggalScreen(),
          ),
          _buildMenuItem(
            context,
            title: 'Selisih Tanggal',
            subtitle: 'Menghitung jarak antara dua tanggal',
            icon: Icons.date_range,
            page: const SelisihTanggalScreen(),
          ),
          _buildMenuItem(
            context,
            title: 'Menentukan Hari',
            subtitle: 'Mengetahui hari berdasarkan tanggal',
            icon: Icons.today,
            page: const MenentukanHariScreen(),
          ),
        ],
      ),
    );
  }

  Widget _buildMenuItem(
    BuildContext context, {
    required String title,
    required String subtitle,
    required IconData icon,
    required Widget page,
  }) {
    return Card(
      margin: const EdgeInsets.only(bottom: 14),
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 18,
          vertical: 10,
        ),
        leading: Container(
          width: 48,
          height: 48,
          decoration: BoxDecoration(
            color: const Color(0xFFE7EFE8),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(
            icon,
            color: const Color(0xFF4F7D58),
          ),
        ),
        title: Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 4),
          child: Text(
            subtitle,
            style: const TextStyle(
              color: Color(0xFF748078),
              fontSize: 13,
            ),
          ),
        ),
        trailing: const Icon(
          Icons.arrow_forward_ios,
          size: 17,
          color: Color(0xFF748078),
        ),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => page,
            ),
          );
        },
      ),
    );
  }
}
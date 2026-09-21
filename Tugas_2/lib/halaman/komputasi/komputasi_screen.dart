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
      appBar: AppBar(title: const Text('Menu Komputasi Tani')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildMenuItem(
            context,
            'Tambah Tanggal (Estimasi Panen)',
            Icons.add_circle_outline,
            const TambahTanggalScreen(),
          ),
          _buildMenuItem(
            context,
            'Kurang Tanggal (Hitung Mundur Semai)',
            Icons.remove_circle_outline,
            const KurangTanggalScreen(),
          ),
          _buildMenuItem(
            context,
            'Selisih Tanggal Tanam & Panen',
            Icons.date_range,
            const SelisihTanggalScreen(),
          ),
          _buildMenuItem(
            context,
            'Menentukan Hari Tanam',
            Icons.today,
            const MenentukanHariScreen(),
          ),
        ],
      ),
    );
  }

  Widget _buildMenuItem(
    BuildContext context,
    String title,
    IconData icon,
    Widget page,
  ) {
    return Card(
      child: ListTile(
        leading: Icon(icon, color: Colors.green),
        title: Text(title),
        trailing: const Icon(Icons.arrow_forward_ios),
        onTap: () =>
            Navigator.push(context, MaterialPageRoute(builder: (_) => page)),
      ),
    );
  }
}

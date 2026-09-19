import 'package:flutter/material.dart';

import '../../komponen/kartu_menu.dart';
import 'tambah_agenda_screen.dart';
import 'riwayat_agenda_screen.dart';

class AgendaScreen extends StatelessWidget {
  const AgendaScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Agenda',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          const Text(
            'Agenda Kegiatan',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Color(0xFF26382B),
            ),
          ),

          const SizedBox(height: 8),

          const Text(
            'Kelola kegiatan yang ingin dicatat.',
            style: TextStyle(color: Color(0xFF66736A)),
          ),

          const SizedBox(height: 22),

          KartuMenu(
            judul: 'Daftar Kegiatan',
            deskripsi: 'Melihat seluruh kegiatan yang tersimpan.',
            ketikaDitekan: () {},
          ),

          const SizedBox(height: 12),

          KartuMenu(
            judul: 'Tambah Kegiatan',
            deskripsi: 'Menambahkan kegiatan baru ke agenda.',
            ketikaDitekan: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const TambahAgendaScreen()),
              );
            },
          ),

          const SizedBox(height: 12),

          KartuMenu(
            judul: 'Riwayat',
            deskripsi: 'Melihat riwayat kegiatan.',
            ketikaDitekan: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const RiwayatAgendaScreen()),
              );
            },
          ),
        ],
      ),
    );
  }
}

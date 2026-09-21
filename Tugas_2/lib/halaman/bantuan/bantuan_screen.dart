import 'package:flutter/material.dart';
import '../../layanan/layanan_auth.dart';

class BantuanScreen extends StatelessWidget {
  const BantuanScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF1F4EC),
      appBar: AppBar(
        title: const Text(
          'Bantuan',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: const Color(0xFF4F7D58),
        foregroundColor: Colors.white,
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: const [
          BantuanItem(
            judul: 'Menu Home',
            isi:
                'Home digunakan sebagai halaman utama untuk '
                'mengakses Kalender, Konversi, Komputasi, '
                'Agenda, dan Anggota.',
          ),

          BantuanItem(
            judul: 'Menu Agenda',
            isi:
                'Digunakan untuk menambahkan dan mengelola '
                'kegiatan, mengatur waktu, status, dan melihat '
                'riwayat agenda.',
          ),

          BantuanItem(
            judul: 'Menu Komputasi',
            isi:
                'Digunakan untuk menghitung umur tanaman, '
                'prediksi panen, kebutuhan pupuk, dan jumlah tanaman.',
          ),

          BantuanItem(
            judul: 'Menu Konversi',
            isi:
                'Digunakan untuk menghitung umur berdasarkan '
                'tanggal lahir serta melakukan konversi waktu.',
          ),

          BantuanItem(
            judul: 'Menu Kalender',
            isi:
                'Digunakan untuk melihat kalender Masehi, '
                'Weton Jawa, Jogja, Bali, Hijriah, dan Saka.',
          ),

          BantuanItem(
            judul: 'Logout',
            isi:
                'Gunakan tombol KELUAR di pojok kanan atas '
                'untuk keluar dari akun.',
          ),
        ],
      ),
    );
  }
}

class BantuanItem extends StatelessWidget {
  final String judul;
  final String isi;

  const BantuanItem({super.key, required this.judul, required this.isi});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(17),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFD9E2D5)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            judul,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Color(0xFF26382B),
            ),
          ),
          const SizedBox(height: 7),
          Text(
            isi,
            style: const TextStyle(
              fontSize: 14,
              height: 1.5,
              color: Color(0xFF66736A),
            ),
          ),
        ],
      ),
    );
  }
}

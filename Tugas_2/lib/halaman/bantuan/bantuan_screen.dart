import 'package:flutter/material.dart';

class BantuanScreen extends StatelessWidget {
  const BantuanScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Bantuan',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: const [
          BantuanItem(
            judul: 'Cara Login',
            isi:
                'Masukkan email dan password yang sudah '
                'terdaftar pada Firebase Authentication.',
          ),
          BantuanItem(
            judul: 'Menu Home',
            isi:
                'Home digunakan sebagai halaman utama untuk '
                'mengakses Kalender, Komputasi, Konversi, '
                'Agenda, dan Anggota.',
          ),
          BantuanItem(
            judul: 'Menu Komputasi',
            isi:
                'Digunakan untuk melakukan perhitungan '
                'tanggal sesuai fitur yang tersedia.',
          ),
          BantuanItem(
            judul: 'Menu Agenda',
            isi:
                'Digunakan untuk menambahkan dan mengelola '
                'kegiatan.',
          ),
          BantuanItem(
            judul: 'Menu Konversi',
            isi:
                'Digunakan untuk melakukan konversi tanggal '
                'lahir dan waktu.',
          ),
          BantuanItem(
            judul: 'Menu Kalender',
            isi:
                'Digunakan untuk melihat kalender, Weton Jawa, '
                'Saka Bali, dan kalender pertanian.',
          ),
          BantuanItem(
            judul: 'Stopwatch',
            isi:
                'Gunakan tombol Mulai untuk menjalankan waktu, '
                'Berhenti untuk menghentikan sementara, '
                'Lanjutkan untuk meneruskan, dan Reset untuk '
                'mengulang dari awal.',
          ),
          BantuanItem(
            judul: 'Logout',
            isi:
                'Gunakan tombol Logout pada halaman Home untuk '
                'keluar dari akun.',
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

import 'package:flutter/material.dart';

import '../agenda/agenda_screen.dart';
import '../anggota/anggota_screen.dart';
import '../komputasi/komputasi_screen.dart';
import '../konversi/konversi_screen.dart';
import '../kalender/kalender_screen.dart';
import '../../layanan/layanan_auth.dart';

class BerandaScreen extends StatelessWidget {
  const BerandaScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF1F4EC),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              // HEADER
              Container(
                width: double.infinity,
                padding: const EdgeInsets.fromLTRB(24, 30, 24, 34),
                decoration: const BoxDecoration(
                  color: Color(0xFF4F7D58),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(38),
                    bottomRight: Radius.circular(38),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'AGROTIME - KALENDER PERTANIAN',
                      style: TextStyle(
                        fontSize: 27,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),

                    const SizedBox(height: 7),

                    const Text(
                      'Pilih aktivitas yang ingin dilakukan',
                      style: TextStyle(fontSize: 14, color: Color(0xFFE2ECE1)),
                    ),

                    const SizedBox(height: 24),

                    // DEKORASI LAHAN
                    Row(
                      children: [
                        Expanded(
                          flex: 3,
                          child: Container(
                            height: 12,
                            decoration: BoxDecoration(
                              color: const Color(0xFFA9C38F),
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                        ),
                        const SizedBox(width: 6),
                        Expanded(
                          flex: 2,
                          child: Container(
                            height: 12,
                            decoration: BoxDecoration(
                              color: const Color(0xFFD0DFB8),
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                        ),
                        const SizedBox(width: 6),
                        Expanded(
                          child: Container(
                            height: 12,
                            decoration: BoxDecoration(
                              color: const Color(0xFF789C67),
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 22),

              // 01 KALENDER
              _MenuUtama(
                nomor: '01',
                icon: Icons.calendar_month,
                judul: 'Kalender',
                deskripsi:
                    'Lihat kalender, Weton Jawa, Saka Bali, dan kalender pertanian.',
                warna: const Color(0xFFE1EBCF),
                ketikaDitekan: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const KalenderScreen()),
                  );
                },
              ),

              const SizedBox(height: 14),

              // 02 KOMPUTASI
              _MenuUtama(
                nomor: '02',
                icon: Icons.calculate,
                judul: 'Komputasi',
                deskripsi:
                    'Hitung umur tanaman, prediksi panen, kebutuhan pupuk, dan jumlah tanaman.',
                warna: const Color(0xFFE9E4C9),
                ketikaDitekan: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const KomputasiScreen()),
                  );
                },
              ),

              const SizedBox(height: 14),

              // 03 KONVERSI
              _MenuUtama(
                nomor: '03',
                icon: Icons.swap_horiz,
                judul: 'Konversi',
                deskripsi:
                    'Konversi tanggal lahir dan waktu dengan cara yang sederhana.',
                warna: const Color(0xFFDCE9D9),
                ketikaDitekan: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const KonversiScreen()),
                  );
                },
              ),

              const SizedBox(height: 14),

              // 04 AGENDA
              _MenuUtama(
                nomor: '04',
                icon: Icons.event_note,
                judul: 'Agenda',
                deskripsi:
                    'Catat kegiatan dan rencanakan aktivitas yang akan dilakukan.',
                warna: const Color(0xFFE8E2D1),
                ketikaDitekan: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const AgendaMainTab()),
                  );
                },
              ),

              const SizedBox(height: 20),

              // ANGGOTA KELOMPOK
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: InkWell(
                  borderRadius: BorderRadius.circular(16),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const AnggotaScreen()),
                    );
                  },
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 18,
                      vertical: 15,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: const Color(0xFFD9E2D5)),
                    ),
                    child: const Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Anggota Kelompok',
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF26382B),
                                ),
                              ),
                              SizedBox(height: 3),
                              Text(
                                'Lihat anggota.',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Color(0xFF718078),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Text(
                          'LIHAT',
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF4F7D58),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 14),

              // LOGOUT
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: SizedBox(
                  width: double.infinity,
                  height: 46,
                  child: OutlinedButton(
                    onPressed: () async {
                      await LayananAuth().logout();
                    },
                    style: OutlinedButton.styleFrom(
                      foregroundColor: const Color(0xFF9E4D4D),
                      side: const BorderSide(color: Color(0xFFDDBABA)),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                    ),
                    child: const Text(
                      'KELUAR',
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 28),

              const Text(
                'KALENDER PERTANIAN DIGITAL',
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.2,
                  color: Color(0xFF7A897D),
                ),
              ),

              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}

/// KARTU MENU UTAMA
class _MenuUtama extends StatelessWidget {
  final String nomor;
  final String judul;
  final String deskripsi;
  final Color warna;
  final VoidCallback ketikaDitekan;
  final IconData? icon;

  const _MenuUtama({
    required this.nomor,
    required this.judul,
    required this.deskripsi,
    required this.warna,
    required this.ketikaDitekan,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Material(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        child: InkWell(
          onTap: ketikaDitekan,
          borderRadius: BorderRadius.circular(20),
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: const Color(0xFFDDE5D9)),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.04),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Row(
              children: [
                Container(
                  width: 54,
                  height: 54,
                  decoration: BoxDecoration(
                    color: warna,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Center(
                    child: icon != null
                        ? Icon(icon, color: const Color(0xFF49604E), size: 27)
                        : Text(
                            nomor,
                            style: const TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF49604E),
                            ),
                          ),
                  ),
                ),

                const SizedBox(width: 15),

                // TEKS
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        judul,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF26382B),
                        ),
                      ),

                      const SizedBox(height: 4),

                      Text(
                        deskripsi,
                        style: const TextStyle(
                          fontSize: 12,
                          height: 1.35,
                          color: Color(0xFF718078),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(width: 10),

                // DEKORASI GARIS
                Column(
                  children: [
                    Container(
                      width: 4,
                      height: 16,
                      decoration: BoxDecoration(
                        color: const Color(0xFF4F7D58),
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Container(
                      width: 4,
                      height: 7,
                      decoration: BoxDecoration(
                        color: const Color(0xFFA9C38F),
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

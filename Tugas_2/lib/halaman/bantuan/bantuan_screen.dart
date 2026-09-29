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
        children: [
          const BantuanItem(
            judul: 'Menu Home',
            isi:
                'Home digunakan sebagai halaman utama untuk '
                'mengakses Kalender, Konversi, Komputasi, '
                'Agenda, dan Anggota.',
          ),

          const BantuanItem(
            judul: 'Menu Agenda',
            isi:
                'Digunakan untuk menambahkan dan mengelola '
                'kegiatan, mengatur waktu, status, dan melihat '
                'riwayat agenda.',
          ),

          const BantuanItem(
            judul: 'Menu Komputasi',
            isi:
                'Digunakan untuk menghitung umur tanaman, '
                'prediksi panen, kebutuhan pupuk, dan jumlah tanaman.',
          ),

          const BantuanItem(
            judul: 'Menu Konversi',
            isi:
                'Digunakan untuk menghitung umur berdasarkan '
                'tanggal lahir serta melakukan konversi waktu.',
          ),

          const BantuanItem(
            judul: 'Menu Kalender',
            isi:
                'Digunakan untuk melihat kalender Masehi, '
                'Weton Jawa, Jogja, Bali, Hijriah, dan Saka.',
          ),

          const BantuanItem(
            judul: 'Logout',
            isi:
                'Gunakan tombol KELUAR di bagian bawah halaman '
                'untuk keluar dari akun.',
          ),

          const SizedBox(height: 16),

          // TOMBOL LOGOUT
          SizedBox(
            width: double.infinity,
            height: 50,
            child: OutlinedButton(
              onPressed: () async {
                final keluar = await showDialog<bool>(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: const Text(
                        'Keluar dari akun?',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      content: const Text(
                        'Apakah kamu yakin ingin keluar dari akun?',
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context, false);
                          },
                          child: const Text(
                            'BATAL',
                            style: TextStyle(
                              color: Color(0xFF4F7D58),
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.pop(context, true);
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFFD9534F),
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: const Text(
                            'KELUAR',
                            style: TextStyle(fontWeight: FontWeight.w600),
                          ),
                        ),
                      ],
                    );
                  },
                );

                if (keluar == true) {
                  await LayananAuth().logout();
                }
              },

              style: OutlinedButton.styleFrom(
                foregroundColor: const Color(0xFFD9534F),
                side: const BorderSide(color: Color(0xFFE5A09D), width: 1.5),
                backgroundColor: const Color(0xFFFFF8F7),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
              ),

              child: const Text(
                'KELUAR DARI AKUN',
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
              ),
            ),
          ),

          const SizedBox(height: 20),
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

import 'package:flutter/material.dart';

class TanggalLahirScreen extends StatefulWidget {
  const TanggalLahirScreen({super.key});

  @override
  State<TanggalLahirScreen> createState() => _TanggalLahirScreenState();
}

class _TanggalLahirScreenState extends State<TanggalLahirScreen> {
  DateTime? tanggalLahir;

  void pilihTanggal() async {
    DateTime? tanggal = await showDatePicker(
      context: context,
      initialDate: DateTime(2000),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );

    if (tanggal != null) {
      setState(() {
        tanggalLahir = tanggal;
      });
    }
  }

  String hitungUmur() {
    if (tanggalLahir == null) {
      return '-';
    }

    DateTime sekarang = DateTime.now();

    int tahun = sekarang.year - tanggalLahir!.year;
    int bulan = sekarang.month - tanggalLahir!.month;
    int hari = sekarang.day - tanggalLahir!.day;

    if (hari < 0) {
      bulan--;

      int bulanSebelumnya = sekarang.month - 1;
      int tahunSebelumnya = sekarang.year;

      if (bulanSebelumnya == 0) {
        bulanSebelumnya = 12;
        tahunSebelumnya--;
      }

      hari += DateTime(
        tahunSebelumnya,
        bulanSebelumnya + 1,
        0,
      ).day;
    }

    if (bulan < 0) {
      tahun--;
      bulan += 12;
    }

    return '$tahun Tahun $bulan Bulan $hari Hari';
  }

  int totalHari() {
    if (tanggalLahir == null) {
      return 0;
    }

    DateTime sekarang = DateTime.now();
    return sekarang.difference(tanggalLahir!).inDays;
  }

  @override
  Widget build(BuildContext context) {
    int hari = totalHari();

    return Scaffold(
      backgroundColor: const Color(0xFFF1F4EC),
      appBar: AppBar(
        title: const Text('Konversi Tanggal Lahir'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Konversi Tanggal Lahir',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Color(0xFF26382B),
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Pilih tanggal lahir untuk menghitung umur.',
              style: TextStyle(color: Color(0xFF66736A)),
            ),
            const SizedBox(height: 20),
            const Text(
              'Tanggal Lahir',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Color(0xFF34453A),
              ),
            ),
            const SizedBox(height: 10),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: OutlinedButton(
                onPressed: pilihTanggal,
                child: Text(
                  tanggalLahir == null
                      ? 'Pilih Tanggal'
                      : '${tanggalLahir!.day}/${tanggalLahir!.month}/${tanggalLahir!.year}',
                ),
              ),
            ),
            const SizedBox(height: 20),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: const Color(0xFFE1EBCF),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Umur Saat Ini',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF49604E),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    hitungUmur(),
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF26382B),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Konversi Total',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Color(0xFF34453A),
              ),
            ),
            const SizedBox(height: 10),
            Text('Total Hari  : $hari hari'),
            Text('Total Jam   : ${hari * 24} jam'),
            Text('Total Menit : ${hari * 24 * 60} menit'),
            Text('Total Detik  : ${hari * 24 * 60 * 60} detik'),
          ],
        ),
      ),
    );
  }
}

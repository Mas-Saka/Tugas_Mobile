import 'package:flutter/material.dart';
import 'package:hijri_core/hijri_core.dart';

class HijriScreen extends StatefulWidget {
  const HijriScreen({super.key});

  @override
  State<HijriScreen> createState() => _HijriScreenState();
}

class _HijriScreenState extends State<HijriScreen> {
  DateTime? tanggalMasehi;
  String hasilHijriah = '-';

  final List<String> namaBulanHijriah = [
    'Muharram',
    'Safar',
    'Rabiul Awal',
    'Rabiul Akhir',
    'Jumadil Awal',
    'Jumadil Akhir',
    'Rajab',
    'Syaban',
    'Ramadan',
    'Syawal',
    'Zulkaidah',
    'Zulhijah',
  ];

  Future<void> pilihTanggal() async {
    final tanggal = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2076),
    );

    if (tanggal != null) {
      final hasil = toHijri(
        DateTime.utc(tanggal.year, tanggal.month, tanggal.day),
      );

      setState(() {
        tanggalMasehi = tanggal;

        if (hasil != null) {
          hasilHijriah =
              '${hasil.hd} ${namaBulanHijriah[hasil.hm - 1]} ${hasil.hy} H';
        } else {
          hasilHijriah = 'Tanggal tidak dapat dikonversi';
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF1F4EC),
      appBar: AppBar(title: const Text('Konversi Tanggal Hijriah')),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Konversi Tanggal Hijriah',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Color(0xFF26382B),
              ),
            ),

            const SizedBox(height: 8),

            const Text(
              'Ubah tanggal Masehi menjadi tanggal Hijriah.',
              style: TextStyle(color: Color(0xFF66736A)),
            ),

            const SizedBox(height: 24),

            const Text(
              'Tanggal Masehi',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Color(0xFF34453A),
              ),
            ),

            const SizedBox(height: 10),

            SizedBox(
              width: double.infinity,
              height: 50,
              child: OutlinedButton.icon(
                onPressed: pilihTanggal,
                icon: const Icon(Icons.calendar_month),
                label: Text(
                  tanggalMasehi == null
                      ? 'Pilih Tanggal'
                      : '${tanggalMasehi!.day}/${tanggalMasehi!.month}/${tanggalMasehi!.year}',
                ),
              ),
            ),

            const SizedBox(height: 24),

            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: const Color(0xFFE1EBCF),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Hasil Konversi',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF49604E),
                    ),
                  ),

                  const SizedBox(height: 10),

                  Text(
                    hasilHijriah,
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF26382B),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

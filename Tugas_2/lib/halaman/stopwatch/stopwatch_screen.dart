import 'dart:async';

import 'package:flutter/material.dart';

class StopwatchScreen extends StatefulWidget {
  const StopwatchScreen({super.key});

  @override
  State<StopwatchScreen> createState() => _StopwatchScreenState();
}

class _StopwatchScreenState extends State<StopwatchScreen> {
  final Duration waktuAwalTesting = const Duration(
    hours: 71,
    minutes: 59,
    seconds: 55,
  );

  Duration waktu = Duration.zero;
  DateTime? waktuMulai;
  Timer? timer;
  bool sedangBerjalan = false;

  @override
  void initState() {
    super.initState();
    waktu = waktuAwalTesting;
  }

  void mulai() {
    if (sedangBerjalan) {
      return;
    }

    waktuMulai = DateTime.now().subtract(waktu);
    sedangBerjalan = true;

    timer?.cancel();

    timer = Timer.periodic(const Duration(milliseconds: 50), (timer) {
      if (mounted && sedangBerjalan) {
        setState(() {
          waktu = DateTime.now().difference(waktuMulai!);
        });
      }
    });

    setState(() {});
  }

  void berhenti() {
    if (!sedangBerjalan) {
      return;
    }

    waktu = DateTime.now().difference(waktuMulai!);
    sedangBerjalan = false;

    timer?.cancel();
    timer = null;

    setState(() {});
  }

  void reset() {
    sedangBerjalan = false;
    waktuMulai = null;

    timer?.cancel();
    timer = null;

    setState(() {
      waktu = Duration.zero;
    });
  }

  String tampilkanWaktu() {
    String jam = waktu.inHours.toString().padLeft(2, '0');

    String menit = waktu.inMinutes.remainder(60).toString().padLeft(2, '0');

    String detik = waktu.inSeconds.remainder(60).toString().padLeft(2, '0');

    String mili = (waktu.inMilliseconds.remainder(1000) ~/ 10)
        .toString()
        .padLeft(2, '0');

    return '$jam:$menit:$detik.$mili';
  }

  String tampilkanHari() {
    int hari = waktu.inDays;

    if (hari == 0) {
      return '';
    }

    if (hari == 1) {
      return 'Telah lewat 1 hari';
    }

    return 'Telah lewat $hari hari';
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    String informasiHari = tampilkanHari();

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Stopwatch',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 42, horizontal: 20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(18),
              ),
              child: Column(
                children: [
                  const Text(
                    'Waktu berjalan',
                    style: TextStyle(color: Color(0xFF66736A)),
                  ),
                  const SizedBox(height: 18),
                  FittedBox(
                    child: Text(
                      tampilkanWaktu(),
                      style: const TextStyle(
                        fontSize: 48,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF26382B),
                      ),
                    ),
                  ),
                  if (informasiHari.isNotEmpty) ...[
                    const SizedBox(height: 14),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 14,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFFEAF2EA),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        informasiHari,
                        style: const TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF4F7D58),
                        ),
                      ),
                    ),
                  ],
                ],
              ),
            ),
            const SizedBox(height: 20),
            if (!sedangBerjalan)
              tombol('MULAI', mulai, utama: true)
            else
              tombol('BERHENTI', berhenti, utama: true),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(child: tombol('RESET', reset)),
                const SizedBox(width: 12),
                Expanded(child: tombol('LANJUTKAN', mulai)),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget tombol(String teks, VoidCallback fungsi, {bool utama = false}) {
    return SizedBox(
      height: 48,
      width: double.infinity,
      child: utama
          ? ElevatedButton(
              onPressed: fungsi,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF4F7D58),
                foregroundColor: Colors.white,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
              ),
              child: Text(
                teks,
                style: const TextStyle(fontWeight: FontWeight.w600),
              ),
            )
          : OutlinedButton(
              onPressed: fungsi,
              style: OutlinedButton.styleFrom(
                foregroundColor: const Color(0xFF4F7D58),
                side: const BorderSide(color: Color(0xFFB9C9BB)),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
              ),
              child: Text(
                teks,
                style: const TextStyle(fontWeight: FontWeight.w600),
              ),
            ),
    );
  }
}

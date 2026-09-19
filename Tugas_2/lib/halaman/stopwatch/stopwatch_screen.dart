import 'dart:async';

import 'package:flutter/material.dart';

class StopwatchScreen extends StatefulWidget {
  const StopwatchScreen({super.key});

  @override
  State<StopwatchScreen> createState() => _StopwatchScreenState();
}

class _StopwatchScreenState extends State<StopwatchScreen> {
  final Stopwatch stopwatch = Stopwatch();
  Timer? timer;

  void mulai() {
    stopwatch.start();

    timer ??= Timer.periodic(const Duration(milliseconds: 10), (timer) {
      if (mounted) {
        setState(() {});
      }
    });

    setState(() {});
  }

  void berhenti() {
    stopwatch.stop();
    setState(() {});
  }

  void reset() {
    stopwatch.reset();
    setState(() {});
  }

  String tampilkanWaktu() {
    Duration waktu = stopwatch.elapsed;

    String jam = waktu.inHours.toString().padLeft(2, '0');
    String menit = waktu.inMinutes.remainder(60).toString().padLeft(2, '0');
    String detik = waktu.inSeconds.remainder(60).toString().padLeft(2, '0');
    String mili = (waktu.inMilliseconds.remainder(1000) ~/ 10)
        .toString()
        .padLeft(2, '0');

    return '$jam:$menit:$detik.$mili';
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bool sedangBerjalan = stopwatch.isRunning;

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
              child: Text(teks),
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
              child: Text(teks),
            ),
    );
  }
}

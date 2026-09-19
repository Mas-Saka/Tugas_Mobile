import 'package:flutter/material.dart';

class SelisihTanggalScreen extends StatelessWidget {
  const SelisihTanggalScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Selisih Tanggal')),
      body: const Center(
        child: Text(
          'Halaman Selisih Tanggal\n\nFitur akan dibuat oleh Orang 2.',
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}

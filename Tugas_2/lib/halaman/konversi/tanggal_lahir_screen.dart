import 'package:flutter/material.dart';

class TanggalLahirScreen extends StatelessWidget {
  const TanggalLahirScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Konversi Tanggal Lahir')),
      body: const Center(
        child: Text(
          'Halaman Konversi Tanggal Lahir\n\n'
          'Fitur akan dibuat oleh Orang 3.',
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}

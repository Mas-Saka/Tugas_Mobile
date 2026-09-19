import 'package:flutter/material.dart';

class TambahTanggalScreen extends StatelessWidget {
  const TambahTanggalScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Tambah Tanggal')),
      body: const Center(
        child: Text(
          'Halaman Tambah Tanggal\n\nFitur akan dibuat oleh Orang 2.',
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}

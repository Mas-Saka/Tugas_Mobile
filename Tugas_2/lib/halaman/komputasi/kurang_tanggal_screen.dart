import 'package:flutter/material.dart';

class KurangTanggalScreen extends StatelessWidget {
  const KurangTanggalScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Kurang Tanggal')),
      body: const Center(
        child: Text(
          'Halaman Kurang Tanggal\n\nFitur akan dibuat oleh Orang 2.',
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}

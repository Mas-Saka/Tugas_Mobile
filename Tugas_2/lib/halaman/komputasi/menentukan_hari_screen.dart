import 'package:flutter/material.dart';

class MenentukanHariScreen extends StatelessWidget {
  const MenentukanHariScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Menentukan Hari')),
      body: const Center(
        child: Text(
          'Halaman Menentukan Hari\n\nFitur akan dibuat oleh Orang 2.',
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}

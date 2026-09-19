import 'package:flutter/material.dart';

class WetonScreen extends StatelessWidget {
  const WetonScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const HalamanKosong(judul: 'Weton Jawa');
  }
}

class HalamanKosong extends StatelessWidget {
  final String judul;

  const HalamanKosong({super.key, required this.judul});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(judul)),
      body: const Center(
        child: Padding(
          padding: EdgeInsets.all(24),
          child: Text(
            'Fitur ini akan dikembangkan oleh Orang 4.',
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}

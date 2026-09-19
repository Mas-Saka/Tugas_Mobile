import 'package:flutter/material.dart';

class RiwayatAgendaScreen extends StatelessWidget {
  const RiwayatAgendaScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Riwayat Agenda')),
      body: const Center(
        child: Text(
          'Halaman Riwayat Agenda\n\n'
          'Fitur akan dibuat oleh Orang 2.',
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}

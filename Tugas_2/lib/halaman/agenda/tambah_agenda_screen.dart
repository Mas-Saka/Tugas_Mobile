import 'package:flutter/material.dart';

class TambahAgendaScreen extends StatelessWidget {
  const TambahAgendaScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Tambah Agenda')),
      body: const Center(
        child: Text(
          'Halaman Tambah Agenda\n\n'
          'Fitur akan dibuat oleh Orang 2.',
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}

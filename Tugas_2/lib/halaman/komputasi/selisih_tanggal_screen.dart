import 'package:flutter/material.dart';

class SelisihTanggalScreen extends StatefulWidget {
  const SelisihTanggalScreen({super.key});

  @override
  State<SelisihTanggalScreen> createState() => _SelisihTanggalScreenState();
}

class _SelisihTanggalScreenState extends State<SelisihTanggalScreen> {
  DateTime? _tanggal1;
  DateTime? _tanggal2;
  int? _selisihHari;

  Future<void> _pilihTanggal(
    BuildContext context,
    bool isTanggalPertama,
  ) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      setState(() {
        if (isTanggalPertama) {
          _tanggal1 = picked;
        } else {
          _tanggal2 = picked;
        }
        if (_tanggal1 != null && _tanggal2 != null) {
          _selisihHari = _tanggal2!.difference(_tanggal1!).inDays.abs();
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Hitung Selisih Hari')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            ElevatedButton(
              onPressed: () => _pilihTanggal(context, true),
              child: Text(
                _tanggal1 == null
                    ? 'Pilih Tanggal 1'
                    : 'Tgl 1: ${_tanggal1!.day}/${_tanggal1!.month}/${_tanggal1!.year}',
              ),
            ),
            const SizedBox(height: 12),
            ElevatedButton(
              onPressed: () => _pilihTanggal(context, false),
              child: Text(
                _tanggal2 == null
                    ? 'Pilih Tanggal 2'
                    : 'Tgl 2: ${_tanggal2!.day}/${_tanggal2!.month}/${_tanggal2!.year}',
              ),
            ),
            const SizedBox(height: 24),
            if (_selisihHari != null)
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    'Selisih: $_selisihHari Hari',
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

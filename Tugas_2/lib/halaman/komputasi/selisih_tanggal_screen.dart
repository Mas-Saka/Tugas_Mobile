import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class SelisihTanggalScreen extends StatefulWidget {
  const SelisihTanggalScreen({super.key});

  @override
  State<SelisihTanggalScreen> createState() =>
      _SelisihTanggalScreenState();
}

class _SelisihTanggalScreenState
    extends State<SelisihTanggalScreen> {
  DateTime? _tanggal1;
  DateTime? _tanggal2;
  int? _selisihHari;

  Future<void> _pilihTanggal(bool tanggalPertama) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2100),
    );

    if (picked == null) return;

    setState(() {
      if (tanggalPertama) {
        _tanggal1 = picked;
      } else {
        _tanggal2 = picked;
      }

      if (_tanggal1 != null && _tanggal2 != null) {
        _selisihHari = _tanggal2!
            .difference(_tanggal1!)
            .inDays
            .abs();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Hitung Selisih Hari'),
        backgroundColor: const Color(0xFF3F6849),
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            SizedBox(
              width: double.infinity,
              child: OutlinedButton.icon(
                onPressed: () => _pilihTanggal(true),
                icon: const Icon(Icons.calendar_today),
                label: Text(
                  _tanggal1 == null
                      ? 'Pilih Tanggal Tanam'
                      : 'Tanam: ${DateFormat(
                          'dd MMMM yyyy',
                          'id_ID',
                        ).format(_tanggal1!)}',
                ),
              ),
            ),

            const SizedBox(height: 12),

            SizedBox(
              width: double.infinity,
              child: OutlinedButton.icon(
                onPressed: () => _pilihTanggal(false),
                icon: const Icon(Icons.calendar_today),
                label: Text(
                  _tanggal2 == null
                      ? 'Pilih Tanggal Panen'
                      : 'Panen: ${DateFormat(
                          'dd MMMM yyyy',
                          'id_ID',
                        ).format(_tanggal2!)}',
                ),
              ),
            ),

            const SizedBox(height: 24),

            if (_selisihHari != null)
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: const Color(0xFFE7EFE8),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  children: [
                    const Text(
                      'Selisih Waktu',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 8),

                    Text(
                      '$_selisihHari Hari',
                      style: const TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF3F6849),
                      ),
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}
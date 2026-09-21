import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class MenentukanHariScreen extends StatefulWidget {
  const MenentukanHariScreen({super.key});

  @override
  State<MenentukanHariScreen> createState() =>
      _MenentukanHariScreenState();
}

class _MenentukanHariScreenState
    extends State<MenentukanHariScreen> {
  DateTime? _selectedDate;
  String _namaHari = '';

  final List<String> _hariIndonesia = [
    'Senin',
    'Selasa',
    'Rabu',
    'Kamis',
    'Jumat',
    'Sabtu',
    'Minggu',
  ];

  Future<void> _pilihTanggal() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (picked == null) return;

    setState(() {
      _selectedDate = picked;
      _namaHari = _hariIndonesia[picked.weekday - 1];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Menentukan Hari'),
        backgroundColor: const Color(0xFF3F6849),
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            SizedBox(
              width: double.infinity,
              child: OutlinedButton.icon(
                onPressed: _pilihTanggal,
                icon: const Icon(Icons.calendar_today),
                label: Text(
                  _selectedDate == null
                      ? 'Pilih Tanggal'
                      : DateFormat(
                          'dd MMMM yyyy',
                          'id_ID',
                        ).format(_selectedDate!),
                ),
              ),
            ),

            const SizedBox(height: 24),

            if (_selectedDate != null)
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: const Color(0xFFE7EFE8),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  children: [
                    const Text(
                      'Tanggal tersebut jatuh pada hari',
                      textAlign: TextAlign.center,
                    ),

                    const SizedBox(height: 10),

                    Text(
                      _namaHari,
                      style: const TextStyle(
                        fontSize: 30,
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
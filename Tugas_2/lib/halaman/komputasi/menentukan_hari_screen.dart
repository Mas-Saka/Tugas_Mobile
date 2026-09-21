import 'package:flutter/material.dart';

class MenentukanHariScreen extends StatefulWidget {
  const MenentukanHariScreen({super.key});

  @override
  State<MenentukanHariScreen> createState() => _MenentukanHariScreenState();
}

class _MenentukanHariScreenState extends State<MenentukanHariScreen> {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Cek Hari Tanggal Tanam')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            ElevatedButton(
              onPressed: () async {
                final date = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2100),
                );
                if (date != null) {
                  setState(() {
                    _selectedDate = date;
                    _namaHari = _hariIndonesia[date.weekday - 1];
                  });
                }
              },
              child: const Text('Pilih Tanggal'),
            ),
            const SizedBox(height: 24),
            if (_selectedDate != null)
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    'Tanggal ${_selectedDate!.day}/${_selectedDate!.month}/${_selectedDate!.year} Jatuh Pada Hari: $_namaHari',
                    style: const TextStyle(
                      fontSize: 18,
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

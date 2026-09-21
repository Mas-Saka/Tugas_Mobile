import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TambahTanggalScreen extends StatefulWidget {
  const TambahTanggalScreen({super.key});

  @override
  State<TambahTanggalScreen> createState() => _TambahTanggalScreenState();
}

class _TambahTanggalScreenState extends State<TambahTanggalScreen> {
  DateTime? _tanggalAwal;
  final TextEditingController _hariController = TextEditingController();
  DateTime? _tanggalHasil;

  @override
  void dispose() {
    _hariController.dispose();
    super.dispose();
  }

  Future<void> _pilihTanggal() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _tanggalAwal ?? DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2100),
    );

    if (picked != null) {
      setState(() {
        _tanggalAwal = picked;
      });

      _hitungTanggal();
    }
  }

  void _hitungTanggal() {
    if (_tanggalAwal == null) return;

    final int? jumlahHari = int.tryParse(
      _hariController.text.trim(),
    );

    if (jumlahHari == null || jumlahHari < 0) {
      setState(() {
        _tanggalHasil = null;
      });
      return;
    }

    setState(() {
      _tanggalHasil = _tanggalAwal!.add(
        Duration(days: jumlahHari),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Estimasi Tanggal Panen'),
        backgroundColor: const Color(0xFF3F6849),
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Tanggal Tanam / Mulai',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 15,
              ),
            ),

            const SizedBox(height: 8),

            SizedBox(
              width: double.infinity,
              child: OutlinedButton.icon(
                onPressed: _pilihTanggal,
                icon: const Icon(Icons.calendar_today),
                label: Text(
                  _tanggalAwal == null
                      ? 'Pilih Tanggal'
                      : DateFormat(
                          'dd MMMM yyyy',
                          'id_ID',
                        ).format(_tanggalAwal!),
                ),
              ),
            ),

            const SizedBox(height: 18),

            const Text(
              'Masa Tumbuh',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 15,
              ),
            ),

            const SizedBox(height: 8),

            TextField(
              controller: _hariController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Jumlah Hari',
                hintText: 'Contoh: 90',
                border: OutlineInputBorder(),
                suffixText: 'hari',
              ),
              onChanged: (_) => _hitungTanggal(),
            ),

            const SizedBox(height: 24),

            if (_tanggalHasil != null)
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
                      'Perkiraan Tanggal Panen',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF34453A),
                      ),
                    ),

                    const SizedBox(height: 10),

                    Text(
                      DateFormat(
                        'dd MMMM yyyy',
                        'id_ID',
                      ).format(_tanggalHasil!),
                      style: const TextStyle(
                        fontSize: 24,
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
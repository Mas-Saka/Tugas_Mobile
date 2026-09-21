import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class KurangTanggalScreen extends StatefulWidget {
  const KurangTanggalScreen({super.key});

  @override
  State<KurangTanggalScreen> createState() => _KurangTanggalScreenState();
}

class _KurangTanggalScreenState extends State<KurangTanggalScreen> {
  DateTime? _tanggalTarget;

  final TextEditingController _hariController =
      TextEditingController();

  DateTime? _tanggalMulai;

  @override
  void dispose() {
    _hariController.dispose();
    super.dispose();
  }

  Future<void> _pilihTanggal() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _tanggalTarget ?? DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2100),
    );

    if (picked != null) {
      setState(() {
        _tanggalTarget = picked;
      });

      _hitung();
    }
  }

  void _hitung() {
    if (_tanggalTarget == null) return;

    final int? hari = int.tryParse(
      _hariController.text.trim(),
    );

    if (hari == null || hari < 0) {
      setState(() {
        _tanggalMulai = null;
      });
      return;
    }

    setState(() {
      _tanggalMulai = _tanggalTarget!.subtract(
        Duration(days: hari),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Hitung Mundur Persiapan'),
        backgroundColor: const Color(0xFF3F6849),
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Tanggal Target Tanam',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 8),

            SizedBox(
              width: double.infinity,
              child: OutlinedButton.icon(
                onPressed: _pilihTanggal,
                icon: const Icon(Icons.calendar_today),
                label: Text(
                  _tanggalTarget == null
                      ? 'Pilih Tanggal Target'
                      : DateFormat(
                          'dd MMMM yyyy',
                          'id_ID',
                        ).format(_tanggalTarget!),
                ),
              ),
            ),

            const SizedBox(height: 18),

            TextField(
              controller: _hariController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Masa Perendaman / Persemaian',
                hintText: 'Contoh: 14',
                border: OutlineInputBorder(),
                suffixText: 'hari',
              ),
              onChanged: (_) => _hitung(),
            ),

            const SizedBox(height: 24),

            if (_tanggalMulai != null)
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
                      'Harus Mulai Rendam / Semai',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 10),

                    Text(
                      DateFormat(
                        'dd MMMM yyyy',
                        'id_ID',
                      ).format(_tanggalMulai!),
                      style: const TextStyle(
                        fontSize: 23,
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
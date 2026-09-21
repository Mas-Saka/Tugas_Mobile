import 'package:flutter/material.dart';

class TambahTanggalScreen extends StatefulWidget {
  const TambahTanggalScreen({super.key});

  @override
  State<TambahTanggalScreen> createState() => _TambahTanggalScreenState();
}

class _TambahTanggalScreenState extends State<TambahTanggalScreen> {
  DateTime? _tanggalAwal;
  final TextEditingController _hariController = TextEditingController();
  DateTime? _tanggalHasil;

  void _pilihTanggal(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      setState(() {
        _tanggalAwal = picked;
        _hitungTanggal();
      });
    }
  }

  void _hitungTanggal() {
    if (_tanggalAwal != null && _hariController.text.isNotEmpty) {
      int jumlahHari = int.tryParse(_hariController.text) ?? 0;
      setState(() {
        _tanggalHasil = _tanggalAwal!.add(Duration(days: jumlahHari));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Estimasi Tanggal Panen (+Hari)')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            OutlinedButton.icon(
              onPressed: () => _pilihTanggal(context),
              icon: const Icon(Icons.calendar_today),
              label: Text(
                _tanggalAwal == null
                    ? 'Pilih Tanggal Tanam / Mulai'
                    : 'Mulai: ${_tanggalAwal!.day}/${_tanggalAwal!.month}/${_tanggalAwal!.year}',
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _hariController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Masa Tumbuh (Jumlah Hari)',
                border: OutlineInputBorder(),
              ),
              onChanged: (_) => _hitungTanggal(),
            ),
            const SizedBox(height: 24),
            if (_tanggalHasil != null)
              Card(
                color: Colors.green.shade50,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      const Text(
                        'Perkiraan Tanggal Panen:',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        '${_tanggalHasil!.day}/${_tanggalHasil!.month}/${_tanggalHasil!.year}',
                        style: const TextStyle(
                          fontSize: 22,
                          color: Colors.green,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

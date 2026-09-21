import 'package:flutter/material.dart';

class KurangTanggalScreen extends StatefulWidget {
  const KurangTanggalScreen({super.key});

  @override
  State<KurangTanggalScreen> createState() => _KurangTanggalScreenState();
}

class _KurangTanggalScreenState extends State<KurangTanggalScreen> {
  DateTime? _tanggalTarget;
  final TextEditingController _hariController = TextEditingController();
  DateTime? _tanggalMulai;

  void _hitung() {
    if (_tanggalTarget != null && _hariController.text.isNotEmpty) {
      int hari = int.tryParse(_hariController.text) ?? 0;
      setState(() {
        _tanggalMulai = _tanggalTarget!.subtract(Duration(days: hari));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Hitung Mundur Persiapan')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            OutlinedButton.icon(
              onPressed: () async {
                final date = await showDatePicker(context: context, initialDate: DateTime.now(), firstDate: DateTime(2020), lastDate: DateTime(2100));
                if (date != null) {
                  setState(() => _tanggalTarget = date);
                  _hitung();
                }
              },
              icon: const Icon(Icons.calendar_today),
              label: Text(_tanggalTarget == null ? 'Pilih Tanggal Target Tanam' : 'Target: ${_tanggalTarget!.day}/${_tanggalTarget!.month}/${_tanggalTarget!.year}'),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _hariController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: 'Masa Perendaman/Persemaian (Hari)', border: OutlineInputBorder()),
              onChanged: (_) => _hitung(),
            ),
            const SizedBox(height: 24),
            if (_tanggalMulai != null)
              Card(
                color: Colors.lightGreen.shade50,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text('Harus Mulai Rendam/Semai Tanggal: ${_tanggalMulai!.day}/${_tanggalMulai!.month}/${_tanggalMulai!.year}', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                ),
              )
          ],
        ),
      ),
    );
  }
}
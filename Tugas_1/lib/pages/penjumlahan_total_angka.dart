import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Kalkulator Total Angka',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HitungTotalPage(),
    );
  }
}

class HitungTotalPage extends StatefulWidget {
  const HitungTotalPage({super.key});

  @override
  State<HitungTotalPage> createState() => _HitungTotalPageState();
}

class _HitungTotalPageState extends State<HitungTotalPage> {
  // Controller untuk mengambil data dari TextField
  final TextEditingController _inputController = TextEditingController();

  // Variable untuk menyimpan hasil perhitungan
  double _total = 0;
  int _jumlahAngkaValid = 0;
  String _errorMessage = '';

  // Fungsi logika utama untuk menghitung total angka
  void _hitungTotal() {
    setState(() {
      _errorMessage = '';
      _total = 0;
      _jumlahAngkaValid = 0;

      String input = _inputController.text.trim();

      if (input.isEmpty) {
        _errorMessage = 'Silakan masukkan beberapa angka terlebih dahulu.';
        return;
      }

      // Memisah input berdasarkan koma, spasi, atau baris baru
      List<String> elemen = input.split(RegExp(r'[\s,\n]+'));

      for (String item in elemen) {
        if (item.isNotEmpty) {
          double? angka = double.tryParse(item);
          if (angka != null) {
            _total += angka;
            _jumlahAngkaValid++;
          }
        }
      }

      if (_jumlahAngkaValid == 0) {
        _errorMessage = 'Tidak ada angka valid yang ditemukan.';
      }
    });
  }

  // Fungsi untuk mengosongkan input dan hasil
  void _reset() {
    setState(() {
      _inputController.clear();
      _total = 0;
      _jumlahAngkaValid = 0;
      _errorMessage = '';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Menu Hitung Total Angka'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Masukkan Angka:',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: _inputController,
              keyboardType: TextInputType.multiline,
              maxLines: 3,
              decoration: const InputDecoration(
                hintText: 'Contoh: 10, 20.5, 30 atau pisahkan dengan spasi',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: _hitungTotal,
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                    ),
                    child: const Text('Hitung Total', style: TextStyle(fontSize: 16)),
                  ),
                ),
                const SizedBox(width: 8),
                OutlinedButton(
                  onPressed: _reset,
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                  ),
                  child: const Text('Reset', style: TextStyle(fontSize: 16)),
                ),
              ],
            ),
            const SizedBox(height: 24),
            
            // Pesan Error jika ada
            if (_errorMessage.isNotEmpty)
              Text(
                _errorMessage,
                style: const TextStyle(color: Colors.red, fontSize: 14),
              ),

            // Tampilan Hasil
            Card(
              color: Colors.blue.shade50,
              elevation: 2,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Text(
                      'Jumlah Angka Valid: $_jumlahAngkaValid',
                      style: const TextStyle(fontSize: 14, color: Colors.black87),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Total Keseluruhan:',
                      style: TextStyle(fontSize: 16, color: Colors.blue.shade900),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      _total.toStringAsFixed(_total.truncateToDouble() == _total ? 0 : 2),
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue.shade900,
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
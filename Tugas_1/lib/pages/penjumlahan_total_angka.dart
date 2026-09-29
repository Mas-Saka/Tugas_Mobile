import 'package:flutter/material.dart';
import '../widgets/sidebar.dart';

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
      drawer: const AppSidebar(),

      appBar: AppBar(
        title: const Text(
          'Hitung Total Angka',
          style: TextStyle(fontWeight: FontWeight.w700),
        ),
        centerTitle: false,
        backgroundColor: Colors.white,
        foregroundColor: const Color(0xFF24332F),
        elevation: 0,
      ),

      backgroundColor: const Color(0xFFF6F8F7),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Judul halaman
            const Text(
              'Penjumlahan Total Angka',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w700,
                color: Color(0xFF24332F),
              ),
            ),

            const SizedBox(height: 6),

            const Text(
              'Masukkan beberapa angka untuk menghitung jumlah keseluruhannya.',
              style: TextStyle(fontSize: 14, color: Color(0xFF6D7975)),
            ),

            const SizedBox(height: 24),

            // Card Input
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: const Color(0xFFE1E8E5)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Masukkan Angka',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF24332F),
                    ),
                  ),

                  const SizedBox(height: 6),

                  const Text(
                    'Pisahkan angka dengan koma, spasi, atau baris baru.',
                    style: TextStyle(fontSize: 13, color: Color(0xFF7A8581)),
                  ),

                  const SizedBox(height: 14),

                  TextField(
                    controller: _inputController,
                    keyboardType: TextInputType.multiline,
                    maxLines: 4,
                    decoration: InputDecoration(
                      hintText: 'Contoh: 10, 20.5, 30',
                      hintStyle: const TextStyle(color: Color(0xFF9AA5A1)),
                      filled: true,
                      fillColor: const Color(0xFFF6F8F7),
                      contentPadding: const EdgeInsets.all(16),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: const BorderSide(color: Color(0xFFDDE5E1)),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: const BorderSide(color: Color(0xFFDDE5E1)),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: const BorderSide(
                          color: Color(0xFF2F7D6D),
                          width: 1.5,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 16),

                  // Tombol
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: _hitungTotal,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF2F7D6D),
                            foregroundColor: Colors.white,
                            elevation: 0,
                            padding: const EdgeInsets.symmetric(vertical: 14),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: const Text(
                            'Hitung Total',
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(width: 10),

                      OutlinedButton(
                        onPressed: _reset,
                        style: OutlinedButton.styleFrom(
                          foregroundColor: const Color(0xFF2F7D6D),
                          padding: const EdgeInsets.symmetric(
                            vertical: 14,
                            horizontal: 20,
                          ),
                          side: const BorderSide(color: Color(0xFF2F7D6D)),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: const Text(
                          'Reset',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // Pesan Error
            if (_errorMessage.isNotEmpty)
              Container(
                width: double.infinity,
                margin: const EdgeInsets.only(bottom: 20),
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: const Color(0xFFFFF1F1),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: const Color(0xFFF1CACA)),
                ),
                child: Text(
                  _errorMessage,
                  style: const TextStyle(
                    color: Color(0xFFB04A4A),
                    fontSize: 14,
                  ),
                ),
              ),

            // Card Hasil
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(22),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: const Color(0xFFE1E8E5)),
              ),
              child: Column(
                children: [
                  const Text(
                    'Hasil Perhitungan',
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF24332F),
                    ),
                  ),

                  const SizedBox(height: 20),

                  // Jumlah angka valid
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF6F8F7),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      children: [
                        const Text(
                          'Jumlah Angka Valid',
                          style: TextStyle(
                            fontSize: 13,
                            color: Color(0xFF6D7975),
                          ),
                        ),

                        const SizedBox(height: 5),

                        Text(
                          '$_jumlahAngkaValid',
                          style: const TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.w700,
                            color: Color(0xFF2F7D6D),
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 12),

                  // Total
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: const Color(0xFFE8F2EF),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      children: [
                        const Text(
                          'Total Keseluruhan',
                          style: TextStyle(
                            fontSize: 14,
                            color: Color(0xFF52716A),
                          ),
                        ),

                        const SizedBox(height: 6),

                        Text(
                          _total.toStringAsFixed(
                            _total.truncateToDouble() == _total ? 0 : 2,
                          ),
                          style: const TextStyle(
                            fontSize: 36,
                            fontWeight: FontWeight.w700,
                            color: Color(0xFF2F7D6D),
                          ),
                        ),
                      ],
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

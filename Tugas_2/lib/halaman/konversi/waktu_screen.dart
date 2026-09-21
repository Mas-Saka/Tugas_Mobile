import 'package:flutter/material.dart';

class WaktuScreen extends StatefulWidget {
  const WaktuScreen({super.key});

  @override
  State<WaktuScreen> createState() => _WaktuScreenState();
}

class _WaktuScreenState extends State<WaktuScreen> {
  TextEditingController nilaiController = TextEditingController();

  String dari = 'Jam';
  String ke = 'Menit';
  String hasil = '';

  void konversi() {
    double? nilai = double.tryParse(nilaiController.text);

    if (nilai == null) {
      setState(() {
        hasil = 'Masukkan angka yang benar';
      });
      return;
    }

    double hasilKonversi = nilai;

    if (dari == 'Jam' && ke == 'Menit') {
      hasilKonversi = nilai * 60;
    } else if (dari == 'Jam' && ke == 'Detik') {
      hasilKonversi = nilai * 3600;
    } else if (dari == 'Menit' && ke == 'Jam') {
      hasilKonversi = nilai / 60;
    } else if (dari == 'Menit' && ke == 'Detik') {
      hasilKonversi = nilai * 60;
    } else if (dari == 'Detik' && ke == 'Jam') {
      hasilKonversi = nilai / 3600;
    } else if (dari == 'Detik' && ke == 'Menit') {
      hasilKonversi = nilai / 60;
    }

    setState(() {
      hasil = '$hasilKonversi $ke';
    });
  }

  void reset() {
    setState(() {
      nilaiController.clear();
      dari = 'Jam';
      ke = 'Menit';
      hasil = '';
    });
  }

  @override
  void dispose() {
    nilaiController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF1F4EC),
      appBar: AppBar(
        title: const Text('Konversi Waktu'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Konversi Waktu',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Color(0xFF26382B),
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Ubah jam, menit, dan detik sesuai kebutuhan.',
              style: TextStyle(color: Color(0xFF66736A)),
            ),
            const SizedBox(height: 20),
            const Text(
              'Nilai',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Color(0xFF34453A),
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: nilaiController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Masukkan nilai',
              ),
            ),
            const SizedBox(height: 15),
            const Text(
              'Dari',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Color(0xFF34453A),
              ),
            ),
            DropdownButton<String>(
              value: dari,
              items: const [
                DropdownMenuItem(value: 'Jam', child: Text('Jam')),
                DropdownMenuItem(value: 'Menit', child: Text('Menit')),
                DropdownMenuItem(value: 'Detik', child: Text('Detik')),
              ],
              onChanged: (value) {
                setState(() {
                  dari = value!;
                });
              },
            ),
            const SizedBox(height: 10),
            const Text(
              'Ke',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Color(0xFF34453A),
              ),
            ),
            DropdownButton<String>(
              value: ke,
              items: const [
                DropdownMenuItem(value: 'Jam', child: Text('Jam')),
                DropdownMenuItem(value: 'Menit', child: Text('Menit')),
                DropdownMenuItem(value: 'Detik', child: Text('Detik')),
              ],
              onChanged: (value) {
                setState(() {
                  ke = value!;
                });
              },
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: konversi,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF4F7D58),
                      foregroundColor: Colors.white,
                    ),
                    child: const Text('KONVERSI'),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: OutlinedButton(
                    onPressed: reset,
                    child: const Text('RESET'),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Text(
              hasil.isEmpty ? 'Hasil: -' : 'Hasil: $hasil',
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color(0xFF26382B),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

class ArithmeticPage extends StatefulWidget {
  const ArithmeticPage({super.key});

  @override
  State<ArithmeticPage> createState() => _ArithmeticPageState();
}

class _ArithmeticPageState extends State<ArithmeticPage> {
  final TextEditingController angka1Controller = TextEditingController();
  final TextEditingController angka2Controller = TextEditingController();

  String hasil = '0';

  void hitung(String operasi) {
    double? angka1 = double.tryParse(angka1Controller.text);
    double? angka2 = double.tryParse(angka2Controller.text);

    if (angka1 == null || angka2 == null) {
      setState(() {
        hasil = 'Masukkan angka yang valid';
      });
      return;
    }

    double hasilPerhitungan;

    switch (operasi) {
      case '+':
        hasilPerhitungan = angka1 + angka2;
        break;

      case '-':
        hasilPerhitungan = angka1 - angka2;
        break;

      case '×':
        hasilPerhitungan = angka1 * angka2;
        break;

      case '÷':
        if (angka2 == 0) {
          setState(() {
            hasil = 'Tidak bisa dibagi 0';
          });
          return;
        }

        hasilPerhitungan = angka1 / angka2;
        break;

      default:
        hasilPerhitungan = 0;
    }

    setState(() {
      hasil = hasilPerhitungan.toString();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Aritmatika'),
      ),

      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Operasi Aritmatika',
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),

            const SizedBox(height: 30),

            TextField(
              controller: angka1Controller,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Angka Pertama',
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 15),

            TextField(
              controller: angka2Controller,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Angka Kedua',
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 25),

            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () => hitung('+'),
                    child: const Text(
                      '+',
                      style: TextStyle(fontSize: 24),
                    ),
                  ),
                ),

                const SizedBox(width: 10),

                Expanded(
                  child: ElevatedButton(
                    onPressed: () => hitung('-'),
                    child: const Text(
                      '-',
                      style: TextStyle(fontSize: 24),
                    ),
                  ),
                ),

                const SizedBox(width: 10),

                Expanded(
                  child: ElevatedButton(
                    onPressed: () => hitung('×'),
                    child: const Text(
                      '×',
                      style: TextStyle(fontSize: 24),
                    ),
                  ),
                ),

                const SizedBox(width: 10),

                Expanded(
                  child: ElevatedButton(
                    onPressed: () => hitung('÷'),
                    child: const Text(
                      '÷',
                      style: TextStyle(fontSize: 24),
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 30),

            Card(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    const Text(
                      'Hasil',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 10),

                    Text(
                      hasil,
                      style: const TextStyle(
                        fontSize: 28,
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
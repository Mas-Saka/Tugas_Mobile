import 'package:flutter/material.dart';
import 'package:decimal/decimal.dart';
import '../widgets/sidebar.dart';

class ArithmeticPage extends StatefulWidget {
  const ArithmeticPage({super.key});

  @override
  State<ArithmeticPage> createState() => _ArithmeticPageState();
}

class _ArithmeticPageState extends State<ArithmeticPage> {
  final TextEditingController angka1Controller = TextEditingController();

  final TextEditingController angka2Controller = TextEditingController();

  String hasil = '';

  void hitung(String operasi) {
    Decimal? angka1 = Decimal.tryParse(angka1Controller.text);
    Decimal? angka2 = Decimal.tryParse(angka2Controller.text);

    if (angka1 == null || angka2 == null) {
      setState(() {
        hasil = 'Masukkan angka yang valid.';
      });
      return;
    }

    if (operasi == '/' && angka2 == Decimal.zero) {
      setState(() {
        hasil = 'Tidak dapat membagi dengan nol.';
      });
      return;
    }

    Decimal hasilHitung = Decimal.zero;

    if (operasi == '+') {
      hasilHitung = angka1 + angka2;
    } else if (operasi == '-') {
      hasilHitung = angka1 - angka2;
    } else if (operasi == '×') {
      hasilHitung = angka1 * angka2;
    } else if (operasi == '/') {
      setState(() {
        hasil = (angka1 / angka2)
            .toDecimal(scaleOnInfinitePrecision: 20)
            .toString();
      });
      return;
    }

    setState(() {
      hasil = hasilHitung.toString();
    });

    setState(() {
      hasil = hasilHitung.toString();
    });
  }

  @override
  void dispose() {
    angka1Controller.dispose();
    angka2Controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Aritmatika Dasar')),
      drawer: const AppSidebar(),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 650),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Latihan Operasi Dasar',
                    style: TextStyle(
                      fontSize: 23,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF24332F),
                    ),
                  ),

                  const SizedBox(height: 7),

                  const Text(
                    'Masukkan dua angka, lalu pilih operasi yang ingin digunakan.',
                    style: TextStyle(fontSize: 14, color: Color(0xFF71807B)),
                  ),

                  const SizedBox(height: 24),

                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(color: const Color(0xFFE1E8E5)),
                    ),
                    child: Column(
                      children: [
                        TextField(
                          controller: angka1Controller,
                          keyboardType: const TextInputType.numberWithOptions(
                            decimal: true,
                            signed: true,
                          ),
                          decoration: const InputDecoration(
                            labelText: 'Angka pertama',
                          ),
                        ),

                        const SizedBox(height: 14),

                        TextField(
                          controller: angka2Controller,
                          keyboardType: const TextInputType.numberWithOptions(
                            decimal: true,
                            signed: true,
                          ),
                          decoration: const InputDecoration(
                            labelText: 'Angka kedua',
                          ),
                        ),

                        const SizedBox(height: 22),

                        const Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Pilih operasi',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: Color(0xFF3D4B46),
                            ),
                          ),
                        ),

                        const SizedBox(height: 10),

                        Row(
                          children: [
                            _operationButton('+'),
                            const SizedBox(width: 8),
                            _operationButton('-'),
                            const SizedBox(width: 8),
                            _operationButton('×'),
                            const SizedBox(width: 8),
                            _operationButton('/'),
                          ],
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 18),

                  if (hasil.isNotEmpty)
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: const Color(0xFFE8F2EF),
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(color: const Color(0xFFD2E5DF)),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Hasil',
                            style: TextStyle(
                              fontSize: 13,
                              color: Color(0xFF60706A),
                            ),
                          ),

                          const SizedBox(height: 5),

                          Text(
                            hasil,
                            style: const TextStyle(
                              fontSize: 28,
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
          ),
        ),
      ),
    );
  }

  Widget _operationButton(String operasi) {
    return Expanded(
      child: OutlinedButton(
        onPressed: () {
          hitung(operasi);
        },
        style: OutlinedButton.styleFrom(
          minimumSize: const Size(0, 46),
          foregroundColor: const Color(0xFF2F7D6D),
          side: const BorderSide(color: Color(0xFFB9D5CC)),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        child: Text(
          operasi,
          style: const TextStyle(fontSize: 19, fontWeight: FontWeight.w600),
        ),
      ),
    );
  }
}

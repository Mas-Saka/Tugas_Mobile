import 'package:flutter/material.dart';
import '../widgets/sidebar.dart';

class GanjilGenapPage extends StatefulWidget {
  const GanjilGenapPage({super.key});

  @override
  State<GanjilGenapPage> createState() => _GanjilGenapPageState();
}

class _GanjilGenapPageState extends State<GanjilGenapPage> {
  final TextEditingController angkaController = TextEditingController();

  String hasil = '';

  void cekGanjilGenap() {
    int? angka = int.tryParse(angkaController.text);

    if (angka == null) {
      setState(() {
        hasil = 'Masukkan bilangan bulat yang valid.';
      });
      return;
    }

    setState(() {
      if (angka % 2 == 0) {
        hasil = '$angka adalah bilangan genap.';
      } else {
        hasil = '$angka adalah bilangan ganjil.';
      }
    });
  }

  @override
  void dispose() {
    angkaController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Cek Ganjil/Genap')),
      drawer: const AppSidebar(),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 600),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Cek Ganjil atau Genap',
                    style: TextStyle(
                      fontSize: 23,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF24332F),
                    ),
                  ),

                  const SizedBox(height: 7),

                  const Text(
                    'Masukkan sebuah angka untuk mengetahui jenis bilangannya.',
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
                          controller: angkaController,
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                            labelText: 'Masukkan angka',
                          ),
                        ),

                        const SizedBox(height: 18),

                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: cekGanjilGenap,
                            child: const Text('Cek Angka'),
                          ),
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
                      child: Text(
                        hasil,
                        style: const TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF2F7D6D),
                        ),
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
}

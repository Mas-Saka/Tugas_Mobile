import 'package:flutter/material.dart';

import '../../layanan/layanan_auth.dart';

class DaftarScreen extends StatefulWidget {
  const DaftarScreen({super.key});

  @override
  State<DaftarScreen> createState() => _DaftarScreenState();
}

class _DaftarScreenState extends State<DaftarScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController konfirmasiController = TextEditingController();

  bool sedangDaftar = false;
  String pesanError = '';

  Future<void> prosesDaftar() async {
    if (emailController.text.trim().isEmpty ||
        passwordController.text.trim().isEmpty ||
        konfirmasiController.text.trim().isEmpty) {
      setState(() {
        pesanError = 'Semua data harus diisi.';
      });
      return;
    }

    if (passwordController.text.trim() != konfirmasiController.text.trim()) {
      setState(() {
        pesanError = 'Konfirmasi password tidak sesuai.';
      });
      return;
    }

    setState(() {
      sedangDaftar = true;
      pesanError = '';
    });

    String? hasil = await LayananAuth().daftar(
      emailController.text.trim(),
      passwordController.text.trim(),
    );

    if (!mounted) return;

    if (hasil != null) {
      setState(() {
        sedangDaftar = false;
        pesanError = hasil;
      });
      return;
    }

    setState(() {
      sedangDaftar = false;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Akun berhasil dibuat. Silakan masuk.')),
    );

    Navigator.pop(context);
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    konfirmasiController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE8F0E4),
      appBar: AppBar(
        title: const Text(
          'Daftar Akun',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: const Color(0xFF3F6849),
        foregroundColor: Colors.white,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.all(22),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(24),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.06),
                  blurRadius: 16,
                  offset: const Offset(0, 6),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Buat Akun Baru',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF26382B),
                  ),
                ),

                const SizedBox(height: 6),

                const Text(
                  'Daftarkan akun untuk menggunakan '
                  'Kalender & Pertanian.',
                  style: TextStyle(
                    fontSize: 13,
                    height: 1.4,
                    color: Color(0xFF718078),
                  ),
                ),

                const SizedBox(height: 24),

                const Text(
                  'Email',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF34453A),
                  ),
                ),

                const SizedBox(height: 8),

                TextField(
                  controller: emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    hintText: 'Masukkan email',
                    filled: true,
                    fillColor: const Color(0xFFF3F6F1),
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 15,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(14),
                      borderSide: BorderSide.none,
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(14),
                      borderSide: const BorderSide(color: Color(0xFFE0E7DD)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(14),
                      borderSide: const BorderSide(
                        color: Color(0xFF4F7D58),
                        width: 1.5,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 16),

                const Text(
                  'Password',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF34453A),
                  ),
                ),

                const SizedBox(height: 8),

                TextField(
                  controller: passwordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    hintText: 'Masukkan password',
                    filled: true,
                    fillColor: const Color(0xFFF3F6F1),
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 15,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(14),
                      borderSide: BorderSide.none,
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(14),
                      borderSide: const BorderSide(color: Color(0xFFE0E7DD)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(14),
                      borderSide: const BorderSide(
                        color: Color(0xFF4F7D58),
                        width: 1.5,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 16),

                const Text(
                  'Konfirmasi Password',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF34453A),
                  ),
                ),

                const SizedBox(height: 8),

                TextField(
                  controller: konfirmasiController,
                  obscureText: true,
                  decoration: InputDecoration(
                    hintText: 'Ulangi password',
                    filled: true,
                    fillColor: const Color(0xFFF3F6F1),
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 15,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(14),
                      borderSide: BorderSide.none,
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(14),
                      borderSide: const BorderSide(color: Color(0xFFE0E7DD)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(14),
                      borderSide: const BorderSide(
                        color: Color(0xFF4F7D58),
                        width: 1.5,
                      ),
                    ),
                  ),
                ),

                if (pesanError.isNotEmpty) ...[
                  const SizedBox(height: 12),
                  Text(
                    pesanError,
                    style: const TextStyle(
                      color: Color(0xFFB54A4A),
                      fontSize: 13,
                    ),
                  ),
                ],

                const SizedBox(height: 24),

                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: sedangDaftar ? null : prosesDaftar,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF4F7D58),
                      foregroundColor: Colors.white,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                    child: sedangDaftar
                        ? const SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              color: Colors.white,
                            ),
                          )
                        : const Text(
                            'DAFTAR',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

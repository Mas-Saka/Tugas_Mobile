import 'package:flutter/material.dart';
import 'daftar_screen.dart';
import '../../layanan/layanan_auth.dart';
import '../halaman_utama/navigasi_utama.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  bool sedangLogin = false;
  String pesanError = '';

  Future<void> prosesLogin() async {
    setState(() {
      sedangLogin = true;
      pesanError = '';
    });

    String? hasil = await LayananAuth().login(
      emailController.text.trim(),
      passwordController.text.trim(),
    );

    if (hasil == null) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const NavigasiUtama()),
      );
    } else {
      setState(() {
        sedangLogin = false;
        pesanError = hasil;
      });
    }
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE8F0E4),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                width: double.infinity,
                padding: const EdgeInsets.fromLTRB(28, 42, 28, 36),
                decoration: const BoxDecoration(
                  color: Color(0xFF3F6849),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(42),
                    bottomRight: Radius.circular(42),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'KALENDER PERTANIAN',
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 2,
                        color: Color(0xFFDDE9D8),
                      ),
                    ),

                    const SizedBox(height: 28),

                    const Text(
                      'Atur Waktu,\nRencanakan Pertanian.',
                      style: TextStyle(
                        fontSize: 32,
                        height: 1.15,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),

                    const SizedBox(height: 14),

                    const Text(
                      'Kelola kalender, waktu, agenda, dan '
                      'informasi pertanian dalam satu aplikasi.',
                      style: TextStyle(
                        fontSize: 14,
                        height: 1.5,
                        color: Color(0xFFE7EFE4),
                      ),
                    ),

                    const SizedBox(height: 28),

                    Row(
                      children: [
                        Expanded(
                          flex: 3,
                          child: Container(
                            height: 8,
                            decoration: BoxDecoration(
                              color: const Color(0xFF9FBD82),
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                        ),
                        const SizedBox(width: 7),
                        Expanded(
                          flex: 2,
                          child: Container(
                            height: 8,
                            decoration: BoxDecoration(
                              color: const Color(0xFFC7D9A8),
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                        ),
                        const SizedBox(width: 7),
                        Expanded(
                          child: Container(
                            height: 8,
                            decoration: BoxDecoration(
                              color: const Color(0xFF789C67),
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              Transform.translate(
                offset: const Offset(0, -8),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(22),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(24),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.08),
                          blurRadius: 20,
                          offset: const Offset(0, 8),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Masuk ke Aplikasi',
                          style: TextStyle(
                            fontSize: 21,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF26382B),
                          ),
                        ),

                        const SizedBox(height: 6),

                        const Text(
                          'Silakan masukkan akun kamu untuk melanjutkan.',
                          style: TextStyle(
                            fontSize: 13,
                            color: Color(0xFF748078),
                          ),
                        ),

                        const SizedBox(height: 22),

                        const Text(
                          'Email',
                          style: TextStyle(
                            fontSize: 13,
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
                              borderSide: const BorderSide(
                                color: Color(0xFFE0E7DD),
                              ),
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
                            fontSize: 13,
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
                              borderSide: const BorderSide(
                                color: Color(0xFFE0E7DD),
                              ),
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

                        const SizedBox(height: 22),

                        SizedBox(
                          width: double.infinity,
                          height: 52,
                          child: ElevatedButton(
                            onPressed: sedangLogin ? null : prosesLogin,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF4F7D58),
                              foregroundColor: Colors.white,
                              disabledBackgroundColor: const Color(0xFFAAB9AD),
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                            ),
                            child: sedangLogin
                                ? const SizedBox(
                                    width: 20,
                                    height: 20,
                                    child: CircularProgressIndicator(
                                      strokeWidth: 2,
                                      color: Colors.white,
                                    ),
                                  )
                                : const Text(
                                    'MASUK',
                                    style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                      letterSpacing: 0.5,
                                    ),
                                  ),
                          ),
                        ),
                        const SizedBox(height: 12),

                        SizedBox(
                          width: double.infinity,
                          height: 50,
                          child: OutlinedButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => const DaftarScreen(),
                                ),
                              );
                            },
                            style: OutlinedButton.styleFrom(
                              foregroundColor: const Color(0xFF4F7D58),
                              side: const BorderSide(color: Color(0xFF4F7D58)),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                            ),
                            child: const Text(
                              'BUAT AKUN',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              const Padding(
                padding: EdgeInsets.fromLTRB(28, 8, 28, 28),
                child: Column(
                  children: [
                    Text(
                      'Kalender & Pertanian Digital',
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF4F6855),
                      ),
                    ),
                    SizedBox(height: 5),
                    Text(
                      'Sederhana untuk digunakan, nyaman untuk aktivitas sehari-hari.',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 12, color: Color(0xFF7A877D)),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'firebase_options.dart';
import 'layanan/layanan_auth.dart';
import 'halaman/login/login_screen.dart';
import 'halaman/halaman_utama/navigasi_utama.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(const AplikasiKalenderPertanian());
}

class AplikasiKalenderPertanian extends StatelessWidget {
  const AplikasiKalenderPertanian({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Kalender & Pertanian',
      theme: ThemeData(
        useMaterial3: true,
        fontFamily: 'Poppins',
        scaffoldBackgroundColor: const Color(0xFFF7F5EF),
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF4F7D58)),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFFF7F5EF),
          foregroundColor: Color(0xFF26382B),
          elevation: 0,
          centerTitle: false,
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: BorderSide.none,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: const BorderSide(color: Color(0xFF4F7D58), width: 1.5),
          ),
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 15,
          ),
        ),
      ),
      home: const PemeriksaLogin(),
    );
  }
}

class PemeriksaLogin extends StatelessWidget {
  const PemeriksaLogin({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: LayananAuth().statusLogin,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(color: Color(0xFF4F7D58)),
            ),
          );
        }

        if (snapshot.hasData) {
          return const NavigasiUtama();
        }

        return const LoginScreen();
      },
    );
  }
}

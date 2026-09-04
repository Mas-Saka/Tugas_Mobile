import 'package:flutter/material.dart';
import 'pages/login_page.dart';
import 'pages/dashboard_page.dart';
import 'pages/aritmatika_page.dart';

import 'pages/anggota_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tugas Aplikasi Pertama',

      initialRoute: '/login',

      routes: {
        '/login': (context) => const LoginPage(),
        '/dashboard': (context) => const DashboardPage(),
        '/anggota': (context) => const AnggotaPage(),
        '/Aritmatika': (context) => const ArithmeticPage(),
      },
    );
  }
}

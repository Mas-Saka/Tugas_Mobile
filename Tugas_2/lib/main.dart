import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart'; // File yang baru saja dibuat otomatis
import 'agenda_screen.dart';   // File halaman agenda kamu

void main() async {
  // Wajib dipanggil sebelum mengoperasikan Firebase
  WidgetsFlutterBinding.ensureInitialized(); 
  
  // Inisialisasi Firebase
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Aplikasi Agenda',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.green),
      home: const AgendaScreen(), // Menampilkan halaman agenda_screen.dart
    );
  }
}
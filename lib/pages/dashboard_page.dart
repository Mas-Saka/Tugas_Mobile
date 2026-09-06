import 'package:flutter/material.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Dashboard')),

      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              child: Text('Fitur Aplikasi', style: TextStyle(fontSize: 30)),
            ),
            ListTile(
              title: Text('Dashboard'),
              onTap: () {
                Navigator.pushNamed(context, '/dashboard');
              },
            ),
            ListTile(
              title: Text('Aritmatika'),
              onTap: () {
                Navigator.pushNamed(context, '/Aritmatika');
              },
            ),

            ListTile(
              title: Text('Penjumlahan Total Angka Satu Field'),
              onTap: () {
                Navigator.pushNamed(
                  context,
                  '/Penjumlahan Total Angka Satu Field',
                );
              },
            ),

            ListTile(
              title: Text('Ganjil / Genap'),
              onTap: () {
                Navigator.pushNamed(context, '/ganjil-genap');
              },
            ),

            ListTile(
              title: Text('Anggota Kelompok'),
              onTap: () {
                Navigator.pushNamed(context, '/anggota');
              },
            ),

            ListTile(
              title: Text('Logout'),
              onTap: () {
                Navigator.pushReplacementNamed(context, '/login');
              },
            ),
          ],
        ),
      ),

      body: Center(
        child: Text(
          'Selamat Datang di Dashboard',
          style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}

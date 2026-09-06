import 'package:flutter/material.dart';

class Sidebar extends StatelessWidget {
  const Sidebar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 230,
      color: const Color.fromARGB(97, 97, 107, 115),
      child: Column(
        children: [
          const SizedBox(height: 40),

          const Text(
            'APLIKASI DART',
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 30),

          // Dashboard
          ListTile(
            title: const Text(
              'Dashboard',
              style: TextStyle(color: Colors.white),
            ),
            onTap: () {},
          ),

          // Penjumlahan & Pengurangan
          ListTile(
            title: const Text(
              'Penjumlahan & Pengurangan',
              style: TextStyle(color: Colors.white),
            ),
            onTap: () {
              Navigator.pushNamed(context, '/penjumlahan');
            },
          ),

          // Perkalian & Pembagian
          ListTile(
            title: const Text(
              'Perkalian & Pembagian',
              style: TextStyle(color: Colors.white),
            ),
            onTap: () {
              Navigator.pushNamed(context, '/perkalian');
            },
          ),


          // Total Angka 
          ListTile(
            title: const Text(
              'Penjumlahan Total Angka',
              style: TextStyle(color: Colors.white),
            ),
            onTap: () {
              Navigator.pushNamed(context, '/Penjumlahan Total Angka Satu Field'); // MENGHUBUNGKAN KE RUTE BARU
            },
          ),

          // Ganjil / Genap
          ListTile(
            title: const Text(
              'Ganjil / Genap',
              style: TextStyle(color: Colors.white),
            ),
            onTap: () {
              Navigator.pushNamed(context, '/ganjil-genap');
            },
          ),

          // Anggota Kelompok
          ListTile(
            title: const Text(
              'Nama Anggota Kelompok',
              style: TextStyle(color: Colors.white),
            ),
            onTap: () {
              Navigator.pushNamed(context, '/anggota');
            },
          ),

          const Spacer(),

          // Logout
          ListTile(
            title: const Text('Logout', style: TextStyle(color: Colors.white)),
            onTap: () {
              Navigator.pushReplacementNamed(context, '/login');
            },
          ),

          const SizedBox(height: 20),
        ],
      ),
    );
  }
}

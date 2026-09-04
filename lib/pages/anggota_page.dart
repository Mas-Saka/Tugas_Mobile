import 'package:flutter/material.dart';

class AnggotaPage extends StatelessWidget {
  const AnggotaPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Anggota Kelompok')),

      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              child: Text('Fitur Aplikasi', style: TextStyle(fontSize: 22)),
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

      body: Padding(
        padding: EdgeInsets.all(20),

        child: GridView.count(
          crossAxisCount: 2,
          crossAxisSpacing: 15,
          mainAxisSpacing: 15,

          children: [
            Card(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ClipOval(
                    child: Image.asset(
                      'gambar/saka.jpeg',
                      width: 100,
                      height: 100,
                      fit: BoxFit.cover,
                    ),
                  ),

                  SizedBox(height: 10),

                  Text(
                    'Isyaka Dhafa Maulana',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),

                  Text('NIM: 124240131'),
                ],
              ),
            ),

            Card(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ClipOval(
                    child: Image.asset(
                      'gambar/anggota2.jpg',
                      width: 100,
                      height: 100,
                      fit: BoxFit.cover,
                    ),
                  ),

                  SizedBox(height: 10),

                  Text(
                    'Nama Anggota 2',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),

                  Text('NIM: 123456789'),
                ],
              ),
            ),

            Card(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ClipOval(
                    child: Image.asset(
                      'gambar/anggota3.jpg',
                      width: 100,
                      height: 100,
                      fit: BoxFit.cover,
                    ),
                  ),

                  SizedBox(height: 10),

                  Text(
                    'Nama Anggota 3',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),

                  Text('NIM: 123456789'),
                ],
              ),
            ),

            Card(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ClipOval(
                    child: Image.asset(
                      'gambar/anggota4.jpg',
                      width: 100,
                      height: 100,
                      fit: BoxFit.cover,
                    ),
                  ),

                  SizedBox(height: 10),

                  Text(
                    'Nama Anggota 4',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),

                  Text('NIM: 123456789'),
                ],
              ),
            ),

            Card(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ClipOval(
                    child: Image.asset(
                      'gambar/anggota5.jpg',
                      width: 100,
                      height: 100,
                      fit: BoxFit.cover,
                      centerSlice: Rect.fromLTWH(0, 0, 100, 100),
                    ),
                  ),

                  SizedBox(height: 10),

                  Text(
                    'Nama Anggota 5',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),

                  Text('NIM: 123456789'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

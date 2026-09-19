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

      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            Text(
              'Selamat Datang di Dashboard',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                fontFamily: 'Roboto',
              ),
            ),

            Text(
              'Pilih fitur yang ingin digunakan',
              style: TextStyle(fontSize: 18),
            ),

            SizedBox(height: 30),

            SizedBox(
              width: double.infinity,
              height: 65,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/Aritmatika');
                },
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: Row(
                  children: [
                    SizedBox(width: 15),
                    Text('Aritmatika', style: TextStyle(fontSize: 18)),
                    Spacer(),
                    Icon(Icons.arrow_forward_ios),
                  ],
                ),
              ),
            ),

            SizedBox(height: 15),

            SizedBox(
              width: double.infinity,
              height: 65,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onPressed: () {
                  Navigator.pushNamed(
                    context,
                    '/Penjumlahan Total Angka Satu Field',
                  );
                },
                child: Row(
                  children: [
                    SizedBox(width: 15),
                    Text('Total Angka', style: TextStyle(fontSize: 18)),
                    Spacer(),
                    Icon(Icons.arrow_forward_ios),
                  ],
                ),
              ),
            ),

            SizedBox(height: 15),

            SizedBox(
              width: double.infinity,
              height: 65,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/ganjil-genap');
                },
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: Row(
                  children: [
                    SizedBox(width: 15),
                    Text('Ganjil / Genap', style: TextStyle(fontSize: 18)),
                    Spacer(),
                    Icon(Icons.arrow_forward_ios),
                  ],
                ),
              ),
            ),

            SizedBox(height: 15),

            SizedBox(
              width: double.infinity,
              height: 65,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/anggota');
                },
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: Row(
                  children: [
                    SizedBox(width: 15),
                    Text('Anggota Kelompok', style: TextStyle(fontSize: 18)),
                    Spacer(),
                    Icon(Icons.arrow_forward_ios),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

class AnggotaScreen extends StatelessWidget {
  const AnggotaScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Anggota Kelompok'),
        automaticallyImplyLeading: true,
      ),

      body: Padding(
        padding: const EdgeInsets.all(20),

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

                  const SizedBox(height: 10),

                  const Text(
                    'Isyaka Dhafa Maulana',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),

                  const Text('NIM: 124240131'),
                ],
              ),
            ),

            Card(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ClipOval(
                    child: Image.asset(
                      'gambar/abraham.jpeg',
                      width: 100,
                      height: 100,
                      fit: BoxFit.cover,
                    ),
                  ),

                  const SizedBox(height: 10),

                  const Text(
                    'Abraham Valentino Tarigan',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),

                  const Text('NIM: 124240099'),
                ],
              ),
            ),

            Card(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ClipOval(
                    child: Image.asset(
                      'gambar/jasson.jpeg',
                      width: 100,
                      height: 100,
                      fit: BoxFit.cover,
                    ),
                  ),

                  const SizedBox(height: 10),

                  const Text(
                    'Jasson Edward Te Victoria',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),

                  const Text('NIM: 124240116'),
                ],
              ),
            ),

            Card(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ClipOval(
                    child: Image.asset(
                      'gambar/yefaqih.jpeg',
                      width: 100,
                      height: 100,
                      fit: BoxFit.cover,
                    ),
                  ),

                  const SizedBox(height: 10),

                  const Text(
                    'Yefa Faqihan Azfar',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),

                  const Text('NIM: 124240091'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

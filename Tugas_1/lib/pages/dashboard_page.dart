import 'package:flutter/material.dart';
import '../widgets/sidebar.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Dashboard')),
      drawer: const AppSidebar(),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(20, 10, 20, 30),
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 900),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(22),
                    decoration: BoxDecoration(
                      color: const Color(0xFFE8F2EF),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Selamat datang di MathBuddy',
                          style: TextStyle(
                            fontSize: 23,
                            fontWeight: FontWeight.w700,
                            color: Color(0xFF24332F),
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          'Gunakan menu di bawah untuk berlatih dan memahami operasi matematika dasar.',
                          style: TextStyle(
                            fontSize: 14,
                            height: 1.5,
                            color: Color(0xFF596963),
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 28),

                  const Text(
                    'Materi Pembelajaran',
                    style: TextStyle(
                      fontSize: 19,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF24332F),
                    ),
                  ),

                  const SizedBox(height: 6),

                  const Text(
                    'Pilih materi yang ingin kamu pelajari.',
                    style: TextStyle(fontSize: 13, color: Color(0xFF71807B)),
                  ),

                  const SizedBox(height: 16),

                  LayoutBuilder(
                    builder: (context, constraints) {
                      int columns = 1;

                      if (constraints.maxWidth >= 650) {
                        columns = 2;
                      }

                      return GridView.count(
                        crossAxisCount: columns,
                        crossAxisSpacing: 14,
                        mainAxisSpacing: 14,
                        childAspectRatio: columns == 1 ? 3.0 : 2.0,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        children: [
                          _buildMenuCard(
                            context,
                            icon: Icons.calculate_outlined,
                            title: 'Aritmatika Dasar',
                            description:
                                'Latihan penjumlahan, pengurangan, perkalian, dan pembagian.',
                            route: '/Aritmatika',
                          ),
                          _buildMenuCard(
                            context,
                            icon: Icons.functions_outlined,
                            title: 'Hitung Total Angka',
                            description:
                                'Masukkan beberapa angka dan hitung jumlah keseluruhannya.',
                            route: '/Penjumlahan Total Angka Satu Field',
                          ),
                          _buildMenuCard(
                            context,
                            icon: Icons.numbers_outlined,
                            title: 'Cek Ganjil/Genap',
                            description:
                                'Periksa apakah sebuah angka termasuk ganjil atau genap.',
                            route: '/ganjil-genap',
                          ),
                          _buildMenuCard(
                            context,
                            icon: Icons.groups_outlined,
                            title: 'Anggota Kelompok',
                            description:
                                'Lihat informasi anggota kelompok MathBuddy.',
                            route: '/anggota',
                          ),
                        ],
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildMenuCard(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String description,
    required String route,
  }) {
    return InkWell(
      borderRadius: BorderRadius.circular(14),
      onTap: () {
        Navigator.pushNamed(context, route);
      },
      child: Container(
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: const Color(0xFFE1E8E5)),
        ),
        child: Row(
          children: [
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: const Color(0xFFE8F2EF),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon, color: const Color(0xFF2F7D6D), size: 24),
            ),

            const SizedBox(width: 15),

            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF283631),
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    description,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 12,
                      height: 1.35,
                      color: Color(0xFF71807B),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(width: 8),

            const Icon(Icons.chevron_right, color: Color(0xFF899590)),
          ],
        ),
      ),
    );
  }
}

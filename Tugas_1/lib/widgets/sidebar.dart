import 'package:flutter/material.dart';

class AppSidebar extends StatelessWidget {
  const AppSidebar({super.key});

  @override
  Widget build(BuildContext context) {
    final currentRoute = ModalRoute.of(context)?.settings.name;

    return Drawer(
      backgroundColor: Colors.white,
      child: SafeArea(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.fromLTRB(22, 26, 22, 24),
              color: const Color(0xFF2F7D6D),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(
                    radius: 25,
                    backgroundColor: Colors.white,
                    child: Icon(
                      Icons.calculate_outlined,
                      color: Color(0xFF2F7D6D),
                      size: 27,
                    ),
                  ),
                  SizedBox(height: 15),
                  Text(
                    'MathBuddy',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 21,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    'Menu Belajar',
                    style: TextStyle(color: Color(0xFFDDEDE8), fontSize: 13),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 12),

            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                children: [
                  _buildMenuItem(
                    context,
                    icon: Icons.dashboard_outlined,
                    title: 'Dashboard',
                    route: '/dashboard',
                    currentRoute: currentRoute,
                  ),
                  _buildMenuItem(
                    context,
                    icon: Icons.calculate_outlined,
                    title: 'Aritmatika Dasar',
                    route: '/Aritmatika',
                    currentRoute: currentRoute,
                  ),
                  _buildMenuItem(
                    context,
                    icon: Icons.functions_outlined,
                    title: 'Hitung Total Angka',
                    route: '/Penjumlahan Total Angka Satu Field',
                    currentRoute: currentRoute,
                  ),
                  _buildMenuItem(
                    context,
                    icon: Icons.numbers_outlined,
                    title: 'Cek Ganjil/Genap',
                    route: '/ganjil-genap',
                    currentRoute: currentRoute,
                  ),
                  _buildMenuItem(
                    context,
                    icon: Icons.groups_outlined,
                    title: 'Anggota Kelompok',
                    route: '/anggota',
                    currentRoute: currentRoute,
                  ),
                ],
              ),
            ),

            const Divider(height: 1, color: Color(0xFFE5EBE8)),

            Padding(
              padding: const EdgeInsets.fromLTRB(10, 10, 10, 14),
              child: ListTile(
                leading: const Icon(
                  Icons.logout_outlined,
                  color: Color(0xFFB04A4A),
                ),
                title: const Text(
                  'Logout',
                  style: TextStyle(
                    color: Color(0xFFB04A4A),
                    fontWeight: FontWeight.w600,
                  ),
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                onTap: () {
                  Navigator.pushNamedAndRemoveUntil(
                    context,
                    '/login',
                    (route) => false,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuItem(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String route,
    required String? currentRoute,
  }) {
    final isActive = currentRoute == route;

    return Container(
      margin: const EdgeInsets.only(bottom: 4),
      child: ListTile(
        leading: Icon(
          icon,
          size: 21,
          color: isActive ? const Color(0xFF2F7D6D) : const Color(0xFF6D7975),
        ),
        title: Text(
          title,
          style: TextStyle(
            fontSize: 14,
            fontWeight: isActive ? FontWeight.w600 : FontWeight.w500,
            color: isActive ? const Color(0xFF2F7D6D) : const Color(0xFF35413D),
          ),
        ),
        tileColor: isActive ? const Color(0xFFE8F2EF) : Colors.transparent,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        onTap: () {
          Navigator.pop(context);

          if (currentRoute != route) {
            Navigator.pushReplacementNamed(context, route);
          }
        },
      ),
    );
  }
}

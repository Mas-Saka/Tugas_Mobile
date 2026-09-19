import 'package:flutter/material.dart';

class KartuMenu extends StatelessWidget {
  final String judul;
  final String deskripsi;
  final VoidCallback ketikaDitekan;

  const KartuMenu({
    super.key,
    required this.judul,
    required this.deskripsi,
    required this.ketikaDitekan,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(16),
      child: InkWell(
        onTap: ketikaDitekan,
        borderRadius: BorderRadius.circular(16),
        child: Container(
          padding: const EdgeInsets.all(18),
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(16)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                judul,
                style: const TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF26382B),
                ),
              ),
              const SizedBox(height: 8),
              Text(
                deskripsi,
                style: const TextStyle(
                  fontSize: 13,
                  height: 1.4,
                  color: Color(0xFF66736A),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

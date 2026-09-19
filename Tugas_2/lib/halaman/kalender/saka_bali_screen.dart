import 'package:flutter/material.dart';

class SakaBaliScreen extends StatelessWidget {
  const SakaBaliScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Saka Bali')),
      body: const Center(
        child: Padding(
          padding: EdgeInsets.all(24),
          child: Text(
            'Fitur ini akan dikembangkan oleh Orang 4.',
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'logika_kalender.dart';

/// Halaman khusus untuk Perhitungan dan Informasi Weton Jawa
class WetonScreen extends StatefulWidget {
  const WetonScreen({super.key});

  @override
  State<WetonScreen> createState() => _WetonScreenState();
}

class _WetonScreenState extends State<WetonScreen> {
  DateTime _selectedDay = DateTime.now();
  DateTime _focusedDay = DateTime.now();

  @override
  Widget build(BuildContext context) {
    // Memanggil algoritma Weton Jawa dari logika_kalender.dart
    final HasilWeton wetonInfo = LogikaKalender.hitungWeton(_selectedDay);

    return Scaffold(
      backgroundColor: const Color(0xFFF1F4EC),
      appBar: AppBar(
        title: const Text(
          'Weton Jawa',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        backgroundColor: const Color(0xFF4F7D58),
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header Penjelasan
            const Text(
              'Perhitungan Weton Jawa',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Color(0xFF26382B),
              ),
            ),
            const SizedBox(height: 6),
            const Text(
              'Pilih tanggal di bawah untuk menghitung Hari, Pasaran, dan Nilai Neptu Jawa.',
              style: TextStyle(color: Color(0xFF66736A), fontSize: 13),
            ),

            const SizedBox(height: 16),

            // Kalender Interaktif
            Card(
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: TableCalendar(
                  firstDay: DateTime(1990, 1, 1),
                  lastDay: DateTime(2050, 12, 31),
                  focusedDay: _focusedDay,
                  selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
                  onDaySelected: (selectedDay, focusedDay) {
                    setState(() {
                      _selectedDay = selectedDay;
                      _focusedDay = focusedDay;
                    });
                  },
                  headerStyle: HeaderStyle(
                    formatButtonVisible: false,
                    titleCentered: true,
                    titleTextStyle: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF26382B),
                    ),
                  ),
                  calendarStyle: CalendarStyle(
                    todayDecoration: const BoxDecoration(
                      color: Color(0xFFA9C38F),
                      shape: BoxShape.circle,
                    ),
                    selectedDecoration: const BoxDecoration(
                      color: Color(0xFF4F7D58),
                      shape: BoxShape.circle,
                    ),
                    selectedTextStyle: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 16),

            // Ringkasan Tanggal Masehi
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: const Color(0xFFE7EFE8),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: const Color(0xFFC7DBC9)),
              ),
              child: Row(
                children: [
                  const Icon(Icons.event, color: Color(0xFF4F7D58)),
                  const SizedBox(width: 10),
                  Text(
                    'Tanggal: ${LogikaKalender.formatTanggalIndonesia(_selectedDay)}',
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF26382B),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16),

            // Kartu Detail Hasil Weton
            Card(
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(18.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: const [
                        Icon(Icons.brightness_5, color: Colors.amber, size: 24),
                        SizedBox(width: 8),
                        Text(
                          'Hasil Perhitungan Weton',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF26382B),
                          ),
                        ),
                      ],
                    ),
                    const Divider(height: 20, thickness: 1),

                    // Tampilan Weton Utama
                    Center(
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 12),
                        decoration: BoxDecoration(
                          color: const Color(0xFFFFF8E7),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: const Color(0xFFFFE0B2)),
                        ),
                        child: Text(
                          wetonInfo.weton,
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: Colors.amber.shade900,
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 20),

                    // Detail Rincian Neptu
                    _buildRowItem('Hari Masehi',
                        '${wetonInfo.hari} (Neptu: ${wetonInfo.neptuHari})'),
                    const SizedBox(height: 10),
                    _buildRowItem('Pasaran Jawa',
                        '${wetonInfo.pasaran} (Neptu: ${wetonInfo.neptuPasaran})'),
                    const SizedBox(height: 10),
                    _buildRowItem(
                      'Total Neptu Weton',
                      '${wetonInfo.totalNeptu}',
                      isBold: true,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRowItem(String label, String value, {bool isBold = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: const TextStyle(fontSize: 14, color: Color(0xFF66736A)),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: 14,
            fontWeight: isBold ? FontWeight.bold : FontWeight.w600,
            color: isBold ? const Color(0xFF4F7D58) : const Color(0xFF26382B),
          ),
        ),
      ],
    );
  }
}

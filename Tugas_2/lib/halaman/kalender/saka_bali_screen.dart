import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'logika_kalender.dart';

/// Halaman khusus untuk Informasi dan Perhitungan Kalender Saka Bali
class SakaBaliScreen extends StatefulWidget {
  const SakaBaliScreen({super.key});

  @override
  State<SakaBaliScreen> createState() => _SakaBaliScreenState();
}

class _SakaBaliScreenState extends State<SakaBaliScreen> {
  DateTime _selectedDay = DateTime.now();
  DateTime _focusedDay = DateTime.now();

  @override
  Widget build(BuildContext context) {
    // Memanggil algoritma Saka Bali dari logika_kalender.dart
    final HasilSaka sakaInfo = LogikaKalender.hitungSakaBali(_selectedDay);

    return Scaffold(
      backgroundColor: const Color(0xFFF1F4EC),
      appBar: AppBar(
        title: const Text(
          'Kalender Saka Bali',
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
              'Penanggalan Saka Bali',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Color(0xFF26382B),
              ),
            ),
            const SizedBox(height: 6),
            const Text(
              'Pilih tanggal untuk melihat Tahun Saka, Sasih, dan Wuku berdasarkan algoritma Pawukon.',
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
                  const Icon(Icons.temple_hindu, color: Color(0xFF4F7D58)),
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

            // Kartu Detail Hasil Saka Bali
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
                        Icon(Icons.brightness_7, color: Colors.deepOrange, size: 24),
                        SizedBox(width: 8),
                        Text(
                          'Detail Saka Bali',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF26382B),
                          ),
                        ),
                      ],
                    ),
                    const Divider(height: 20, thickness: 1),

                    // Badge Utama Tahun Saka
                    Center(
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 12),
                        decoration: BoxDecoration(
                          color: const Color(0xFFFBE9E7),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: const Color(0xFFFFCCBC)),
                        ),
                        child: Text(
                          'Tahun ${sakaInfo.tahunSaka} Saka',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.deepOrange.shade900,
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 20),

                    // Detail Sasih dan Wuku
                    _buildRowItem('Sasih (Bulan Saka)', sakaInfo.sasih),
                    const SizedBox(height: 10),
                    _buildRowItem('Wuku (Siklus 210 Hari)', sakaInfo.wuku, isBold: true),
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

import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

import 'logika_kalender.dart';

/// Halaman Kalender Saka Bali.
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
    final HasilSaka sakaInfo = LogikaKalender.hitungSakaBali(_selectedDay);

    return Scaffold(
      backgroundColor: const Color(0xFFF1F4EC),

      // ========================================================
      // APP BAR
      // ========================================================
      appBar: AppBar(
        title: const Text(
          'Kalender Saka Bali',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        backgroundColor: const Color(0xFF4F7D58),
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
      ),

      // ========================================================
      // BODY
      // ========================================================
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ==================================================
            // JUDUL
            // ==================================================
            const Text(
              'Penanggalan Saka',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Color(0xFF26382B),
              ),
            ),

            const SizedBox(height: 6),

            const Text(
              'Pilih tanggal untuk melihat informasi '
              'Tahun Saka, Sasih, Wuku, Pancawara, dan Saptawara.',
              style: TextStyle(color: Color(0xFF66736A), fontSize: 13),
            ),

            const SizedBox(height: 16),

            // ==================================================
            // KALENDER
            // ==================================================
            Card(
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: TableCalendar(
                  firstDay: DateTime(1990, 1, 1),
                  lastDay: DateTime(2050, 12, 31),
                  focusedDay: _focusedDay,

                  selectedDayPredicate: (day) {
                    return isSameDay(_selectedDay, day);
                  },

                  onDaySelected: (selectedDay, focusedDay) {
                    setState(() {
                      _selectedDay = selectedDay;
                      _focusedDay = focusedDay;
                    });
                  },

                  calendarFormat: CalendarFormat.month,

                  headerStyle: const HeaderStyle(
                    formatButtonVisible: false,
                    titleCentered: true,
                    titleTextStyle: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF26382B),
                    ),
                  ),

                  calendarStyle: const CalendarStyle(
                    todayDecoration: BoxDecoration(
                      color: Color(0xFFA9C38F),
                      shape: BoxShape.circle,
                    ),

                    selectedDecoration: BoxDecoration(
                      color: Color(0xFF4F7D58),
                      shape: BoxShape.circle,
                    ),

                    selectedTextStyle: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 16),

            // ==================================================
            // TANGGAL MASEHI
            // ==================================================
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
                  const Icon(Icons.calendar_month, color: Color(0xFF4F7D58)),

                  const SizedBox(width: 10),

                  Expanded(
                    child: Text(
                      'Tanggal Masehi: '
                      '${LogikaKalender.formatTanggalIndonesia(_selectedDay)}',
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF26382B),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16),

            // ==================================================
            // KARTU HASIL SAKA BALI
            // ==================================================
            Card(
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(18),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // ==========================================
                    // HEADER
                    // ==========================================
                    const Row(
                      children: [
                        Icon(
                          Icons.wb_sunny,
                          color: Color(0xFF4F7D58),
                          size: 24,
                        ),

                        SizedBox(width: 8),

                        Text(
                          'Detail Kalender Saka',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF26382B),
                          ),
                        ),
                      ],
                    ),

                    const Divider(height: 20, thickness: 1),

                    // ==========================================
                    // TAHUN SAKA
                    // ==========================================
                    Center(
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 12,
                        ),
                        decoration: BoxDecoration(
                          color: const Color(0xFFF4E8D7),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: const Color(0xFFE3C9A5)),
                        ),
                        child: Text(
                          'Tahun Saka ${sakaInfo.tahunSaka}',
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF9A6A32),
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 20),

                    // ==========================================
                    // SASIH
                    // ==========================================
                    _buildRowItem('Sasih', sakaInfo.sasih),

                    const SizedBox(height: 12),

                    // ==========================================
                    // WUKU
                    // ==========================================
                    _buildRowItem('Wuku', sakaInfo.wuku),

                    const SizedBox(height: 12),

                    // ==========================================
                    // PANCAWARA
                    // ==========================================
                    _buildRowItem('Pancawara', sakaInfo.pancawara),

                    const SizedBox(height: 12),

                    // ==========================================
                    // SAPTAWARA
                    // ==========================================
                    _buildRowItem('Saptawara', sakaInfo.saptawara),

                    const SizedBox(height: 20),

                    // ==========================================
                    // INFORMASI SIKLUS
                    // ==========================================
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(
                        color: const Color(0xFFE7EFE8),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: const Color(0xFFC7DBC9)),
                      ),
                      child: const Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(Icons.info_outline, color: Color(0xFF4F7D58)),

                          SizedBox(width: 10),

                          Expanded(
                            child: Text(
                              'Kalender Saka Bali menggunakan sistem '
                              'penanggalan tradisional Bali. Informasi '
                              'wuku, pancawara, dan saptawara mengikuti '
                              'siklus kalender Bali.',
                              style: TextStyle(
                                fontSize: 13,
                                color: Color(0xFF66736A),
                              ),
                            ),
                          ),
                        ],
                      ),
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

  // ============================================================
  // WIDGET BARIS INFORMASI
  // ============================================================

  Widget _buildRowItem(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Text(
            label,
            style: const TextStyle(fontSize: 14, color: Color(0xFF66736A)),
          ),
        ),

        const SizedBox(width: 10),

        Flexible(
          child: Text(
            value,
            textAlign: TextAlign.right,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: Color(0xFF26382B),
            ),
          ),
        ),
      ],
    );
  }
}

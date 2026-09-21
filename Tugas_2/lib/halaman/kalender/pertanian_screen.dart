import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'logika_kalender.dart';

/// Halaman khusus untuk Informasi Kalender Hari Baik Pertanian dari Cloud Firestore
class PertanianScreen extends StatefulWidget {
  const PertanianScreen({super.key});

  @override
  State<PertanianScreen> createState() => _PertanianScreenState();
}

class _PertanianScreenState extends State<PertanianScreen> {
  DateTime _selectedDay = DateTime.now();
  DateTime _focusedDay = DateTime.now();

  @override
  Widget build(BuildContext context) {
    // Format tanggal ke String yyyy-MM-dd (contoh: 2026-09-21)
    final String formattedDate =
        "${_selectedDay.year.toString().padLeft(4, '0')}-${_selectedDay.month.toString().padLeft(2, '0')}-${_selectedDay.day.toString().padLeft(2, '0')}";

    return Scaffold(
      backgroundColor: const Color(0xFFF1F4EC),
      appBar: AppBar(
        title: const Text(
          'Kalender Pertanian',
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
              'Hari Baik Pertanian',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Color(0xFF26382B),
              ),
            ),
            const SizedBox(height: 6),
            const Text(
              'Pilih tanggal di bawah untuk memeriksa rekomendasi aktivitas dan jadwal tanam/panen.',
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
                  const Icon(Icons.eco, color: Color(0xFF4F7D58)),
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

            // FutureBuilder Data Firestore dengan QuerySnapshot
            FutureBuilder<QuerySnapshot>(
              future: FirebaseFirestore.instance
                  .collection('hari_baik_pertanian')
                  .where('tanggal', isEqualTo: formattedDate)
                  .get(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Padding(
                    padding: EdgeInsets.all(24.0),
                    child: Center(
                      child: CircularProgressIndicator(color: Color(0xFF4F7D58)),
                    ),
                  );
                }

                if (snapshot.hasError || !snapshot.hasData || snapshot.data!.docs.isEmpty) {
                  return _buildPesanWarning('Belum ada data pertanian untuk tanggal ini.');
                }

                final docs = snapshot.data!.docs;

                return Column(
                  children: docs.map((doc) {
                    final data = doc.data() as Map<String, dynamic>;
                    return Card(
                      elevation: 2,
                      margin: const EdgeInsets.only(bottom: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                      color: Colors.white,
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  data['kegiatan'] ?? 'Aktivitas Pertanian',
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFF26382B),
                                  ),
                                ),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 4),
                                  decoration: BoxDecoration(
                                    color: const Color(0xFF4F7D58),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Text(
                                    data['kategori'] ?? 'Umum',
                                    style: const TextStyle(
                                      fontSize: 11,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const Divider(height: 16, thickness: 1),
                            Text(
                              data['keterangan'] ?? '-',
                              style: const TextStyle(
                                fontSize: 13,
                                color: Color(0xFF66736A),
                                height: 1.4,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }).toList(),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPesanWarning(String message) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFFFF8E7),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFFFE0B2)),
      ),
      child: Row(
        children: [
          const Icon(Icons.info_outline, color: Colors.orange, size: 22),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              message,
              style: const TextStyle(fontSize: 14, color: Color(0xFF8C6B1B)),
            ),
          ),
        ],
      ),
    );
  }
}

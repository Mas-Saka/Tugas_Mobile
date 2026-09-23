import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'logika_kalender.dart';

/// Halaman utama Kalender yang menampilkan Kalender Masehi, Perhitungan Weton Jawa,
/// Kalender Saka Bali, serta Rekomendasi Hari Baik Pertanian dari Cloud Firestore.
class HalamanKalender extends StatefulWidget {
  const HalamanKalender({super.key});

  @override
  State<HalamanKalender> createState() => _HalamanKalenderState();
}

class _HalamanKalenderState extends State<HalamanKalender> {
  // Date state untuk menyimpan tanggal yang dipilih dan tanggal fokus di kalender
  DateTime _selectedDay = DateTime.now();
  DateTime _focusedDay = DateTime.now();

  @override
  Widget build(BuildContext context) {
    // Format tanggal ke String yyyy-MM-dd (contoh: 2026-09-21)
    final String formattedDate =
        "${_selectedDay.year.toString().padLeft(4, '0')}-${_selectedDay.month.toString().padLeft(2, '0')}-${_selectedDay.day.toString().padLeft(2, '0')}";

    // Perhitungan logika Weton Jawa dan Saka Bali untuk tanggal terpilih
    final HasilWeton wetonInfo = LogikaKalender.hitungWeton(_selectedDay);
    final HasilSaka sakaInfo = LogikaKalender.hitungSakaBali(_selectedDay);

    return Scaffold(
      backgroundColor: const Color(0xFFF1F4EC),
      appBar: AppBar(
        title: const Text(
          'Kalender & Weton Pertanian',
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
            // 1. WIDGET KALENDER MASEHI INTERAKTIF (table_calendar)
            Card(
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 8.0,
                  horizontal: 4.0,
                ),
                child: TableCalendar(
                  firstDay: DateTime(1990, 1, 1),
                  lastDay: DateTime(2050, 12, 31),
                  focusedDay: _focusedDay,
                  selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
                  onDaySelected: (selectedDay, focusedDay) {
                    // Update state saat user memilih tanggal di kalender
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

            // SUMMARY TANGGAL TERPILIH
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
                  const Icon(Icons.calendar_today, color: Color(0xFF4F7D58)),
                  const SizedBox(width: 10),
                  Text(
                    'Tanggal Terpilih: ${LogikaKalender.formatTanggalIndonesia(_selectedDay)}',
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

            // 2. KARTU WETON JAWA
            _buildSectionCard(
              title: 'Weton Jawa',
              icon: Icons.brightness_5,
              iconColor: Colors.amber.shade800,
              content: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildInfoRow('Weton', wetonInfo.weton, isBold: true),
                  const SizedBox(height: 6),
                  _buildInfoRow(
                    'Hari & Pasaran',
                    '${wetonInfo.hari} (${wetonInfo.neptuHari}) + ${wetonInfo.pasaran} (${wetonInfo.neptuPasaran})',
                  ),
                  const SizedBox(height: 6),
                  _buildInfoRow(
                    'Total Neptu',
                    '${wetonInfo.totalNeptu}',
                    isHighlight: true,
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16),

            // 3. KARTU KALENDER SAKA BALI
            _buildSectionCard(
              title: 'Kalender Saka Bali',
              icon: Icons.temple_hindu,
              iconColor: Colors.orange.shade700,
              content: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildInfoRow(
                    'Tahun Saka',
                    '${sakaInfo.tahunSaka} Saka',
                    isBold: true,
                  ),
                  const SizedBox(height: 6),
                  _buildInfoRow('Sasih', sakaInfo.sasih),
                  const SizedBox(height: 6),
                  _buildInfoRow('Wuku', sakaInfo.wuku),
                ],
              ),
            ),

            const SizedBox(height: 16),

            // 4. KARTU KALENDER PERTANIAN (FIRESTORE)
            _buildSectionCard(
              title: 'Hari Baik Pertanian (Firestore)',
              icon: Icons.eco,
              iconColor: Colors.green.shade700,
              content: FutureBuilder<QuerySnapshot>(
                future: FirebaseFirestore.instance
                    .collection('hari_baik_pertanian')
                    .where('tanggal', isEqualTo: formattedDate)
                    .get(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Center(
                        child: CircularProgressIndicator(
                          color: Color(0xFF4F7D58),
                        ),
                      ),
                    );
                  }

                  if (snapshot.hasError ||
                      !snapshot.hasData ||
                      snapshot.data!.docs.isEmpty) {
                    return _buildWarningWidget(
                      'Belum ada data pertanian untuk tanggal ini.',
                    );
                  }

                  final docs = snapshot.data!.docs;

                  return Column(
                    children: docs.map((doc) {
                      final item = doc.data() as Map<String, dynamic>;
                      return Container(
                        margin: const EdgeInsets.only(bottom: 10),
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: const Color(0xFFF9FBF8),
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: const Color(0xFFE0EBE1)),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  item['kegiatan'] ?? 'Kegiatan Pertanian',
                                  style: const TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFF26382B),
                                  ),
                                ),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 8,
                                    vertical: 3,
                                  ),
                                  decoration: BoxDecoration(
                                    color: const Color(0xFF4F7D58),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Text(
                                    item['kategori'] ?? 'Umum',
                                    style: const TextStyle(
                                      fontSize: 11,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 6),
                            Text(
                              item['keterangan'] ?? '-',
                              style: const TextStyle(
                                fontSize: 13,
                                color: Color(0xFF66736A),
                                height: 1.3,
                              ),
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Helper Widget untuk membuat Card Section yang rapi
  Widget _buildSectionCard({
    required String title,
    required IconData icon,
    required Color iconColor,
    required Widget content,
  }) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, color: iconColor, size: 22),
                const SizedBox(width: 8),
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF26382B),
                  ),
                ),
              ],
            ),
            const Divider(height: 20, thickness: 1),
            content,
          ],
        ),
      ),
    );
  }

  /// Helper Widget untuk baris informasi kunci-nilai
  Widget _buildInfoRow(
    String label,
    String value, {
    bool isBold = false,
    bool isHighlight = false,
  }) {
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
            fontWeight: (isBold || isHighlight)
                ? FontWeight.bold
                : FontWeight.normal,
            color: isHighlight
                ? const Color(0xFF4F7D58)
                : const Color(0xFF26382B),
          ),
        ),
      ],
    );
  }

  /// Helper Widget untuk pesan peringatan jika data kosong atau error
  Widget _buildWarningWidget(String message) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFFFFF8E7),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: const Color(0xFFFFE0B2)),
      ),
      child: Row(
        children: [
          const Icon(Icons.info_outline, color: Colors.orange, size: 20),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              message,
              style: const TextStyle(fontSize: 13, color: Color(0xFF8C6B1B)),
            ),
          ),
        ],
      ),
    );
  }
}

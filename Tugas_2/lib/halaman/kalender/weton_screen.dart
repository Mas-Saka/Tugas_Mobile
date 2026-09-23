import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

import 'logika_kalender.dart';

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
    final wetonInfo = LogikaKalender.hitungWeton(_selectedDay);

    return Scaffold(
      appBar: AppBar(title: const Text('Kalender Jawa'), centerTitle: true),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // =========================
            // KALENDER MASEHI
            // =========================
            Card(
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
                  ),

                  calendarStyle: const CalendarStyle(
                    todayDecoration: BoxDecoration(
                      color: Colors.orange,
                      shape: BoxShape.circle,
                    ),
                    selectedDecoration: BoxDecoration(
                      color: Colors.blue,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 20),

            // =========================
            // TANGGAL MASEHI
            // =========================
            Text(
              'Tanggal Masehi',
              style: Theme.of(context).textTheme.titleMedium,
            ),

            const SizedBox(height: 6),

            Text(
              LogikaKalender.formatTanggalIndonesia(_selectedDay),
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 20),

            // =========================
            // TAHUN JAWA
            // =========================
            Card(
              elevation: 2,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    const Icon(
                      Icons.calendar_month,
                      size: 40,
                      color: Color.fromARGB(255, 0, 0, 0),
                    ),

                    const SizedBox(height: 10),

                    const Text(
                      'Tahun Jawa',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 6),

                    Text(
                      '${wetonInfo.tahunJawa} ${wetonInfo.namaTahunJawa}',
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 16),

            // =========================
            // WETON
            // =========================
            Card(
              elevation: 3,
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    const Text(
                      'Weton',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 10),

                    Text(
                      wetonInfo.weton,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 8),

                    Text(
                      'Neptu ${wetonInfo.totalNeptu}',
                      style: const TextStyle(fontSize: 18),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 16),

            // =========================
            // DETAIL HARI
            // =========================
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Detail Hari',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),

                    const SizedBox(height: 16),

                    Row(
                      children: [
                        const Expanded(
                          child: Text(
                            'Hari Masehi',
                            style: TextStyle(fontSize: 16),
                          ),
                        ),

                        Text(
                          '${wetonInfo.hari} '
                          '(${wetonInfo.neptuHari})',
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),

                    const Divider(),

                    Row(
                      children: [
                        const Expanded(
                          child: Text(
                            'Pasaran Jawa',
                            style: TextStyle(fontSize: 16),
                          ),
                        ),

                        Text(
                          '${wetonInfo.pasaran} '
                          '(${wetonInfo.neptuPasaran})',
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),

                    const Divider(),

                    Row(
                      children: [
                        const Expanded(
                          child: Text(
                            'Total Neptu',
                            style: TextStyle(fontSize: 16),
                          ),
                        ),

                        Text(
                          '${wetonInfo.totalNeptu}',
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 20),

            // =========================
            // INFO
            // =========================
            Card(
              color: Colors.blue.shade50,
              child: const Padding(
                padding: EdgeInsets.all(16),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(Icons.info_outline, color: Colors.blue),

                    SizedBox(width: 10),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

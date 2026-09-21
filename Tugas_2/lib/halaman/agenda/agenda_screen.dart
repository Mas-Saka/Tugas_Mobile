import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AgendaScreen extends StatelessWidget {
  const AgendaScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final CollectionReference agendaRef = FirebaseFirestore.instance.collection(
      'agenda_tani',
    );

    return Scaffold(
      appBar: AppBar(title: const Text('Jadwal Kegiatan Tani')),
      body: StreamBuilder<QuerySnapshot>(
        stream: agendaRef.orderBy('tanggal', descending: false).snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          final docs = snapshot.data?.docs ?? [];

          if (docs.isEmpty) {
            return const Center(child: Text('Belum ada agenda tanam/panen.'));
          }

          return ListView.builder(
            itemCount: docs.length,
            itemBuilder: (context, index) {
              final rawData = docs[index].data();
              final data = rawData != null
                  ? rawData as Map<String, dynamic>
                  : {};

              String docId = docs[index].id;
              String judul = data['judul'] ?? 'Tanpa Judul';
              String jenisTanaman = data['jenis_tanaman'] ?? '-';
              String status = data['status'] ?? 'belum selesai';

              return Card(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                child: ListTile(
                  title: Text(
                    judul,
                    style: TextStyle(
                      decoration: status == 'selesai'
                          ? TextDecoration.lineThrough
                          : null,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  subtitle: Text('$jenisTanaman - Status: $status'),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: Icon(
                          status == 'selesai'
                              ? Icons.check_box
                              : Icons.check_box_outline_blank,
                          color: Colors.green,
                        ),
                        onPressed: () {
                          agendaRef.doc(docId).update({
                            'status': status == 'selesai'
                                ? 'belum selesai'
                                : 'selesai',
                          });
                        },
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete, color: Colors.red),
                        onPressed: () {
                          agendaRef.doc(docId).delete();
                        },
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () => _tambahAgendaDialog(context, agendaRef),
      ),
    );
  }

  static void _tambahAgendaDialog(
    BuildContext context,
    CollectionReference ref,
  ) {
    final judulController = TextEditingController();
    final tanamanController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Tambah Agenda Kegiatan'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: judulController,
              decoration: const InputDecoration(
                labelText: 'Nama Kegiatan (misal: Pemupukan)',
              ),
            ),
            TextField(
              controller: tanamanController,
              decoration: const InputDecoration(
                labelText: 'Jenis Tanaman (misal: Padi)',
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Batal'),
          ),
          ElevatedButton(
            onPressed: () {
              if (judulController.text.isNotEmpty) {
                ref.add({
                  'judul': judulController.text,
                  'jenis_tanaman': tanamanController.text,
                  'status': 'belum selesai',
                  'tanggal': Timestamp.now(),
                });
                Navigator.pop(context);
              }
            },
            child: const Text('Simpan'),
          ),
        ],
      ),
    );
  }
}

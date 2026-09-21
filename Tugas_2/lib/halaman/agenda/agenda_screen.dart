import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';

class AgendaMainTab extends StatelessWidget {
  const AgendaMainTab({super.key});

  static Future<void> showAgendaFormDialog(
    BuildContext context, {
    String? docId,
    String? initialKegiatan,
    String? initialKategori,
    DateTime? initialTanggal,
    TimeOfDay? initialWaktuMulai,
    TimeOfDay? initialWaktuSelesai,
    String? initialCatatan,
    String? initialStatus,
  }) async {
    final kegiatanController = TextEditingController(
      text: initialKegiatan ?? '',
    );

    final catatanController = TextEditingController(text: initialCatatan ?? '');

    String selectedKategori = initialKategori ?? 'Pertanian';
    String selectedStatus = initialStatus ?? 'Belum selesai';

    DateTime selectedTanggal = initialTanggal ?? DateTime.now();

    TimeOfDay waktuMulai =
        initialWaktuMulai ?? const TimeOfDay(hour: 7, minute: 0);

    TimeOfDay waktuSelesai =
        initialWaktuSelesai ?? const TimeOfDay(hour: 10, minute: 0);

    final categories = [
      'Pertanian',
      'Kegiatan Desa',
      'Kuliah',
      'Pelatihan',
      'Kegiatan Pribadi',
      'Lainnya',
    ];

    final statuses = ['Belum selesai', 'Selesai', 'Terlewat'];

    await showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setDialogState) {
            return AlertDialog(
              title: Text(docId == null ? 'Tambah Agenda Baru' : 'Edit Agenda'),
              content: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextField(
                      controller: kegiatanController,
                      decoration: const InputDecoration(
                        labelText: 'Nama Kegiatan',
                      ),
                    ),

                    const SizedBox(height: 12),

                    DropdownButtonFormField<String>(
                      initialValue: selectedKategori,
                      decoration: const InputDecoration(labelText: 'Kategori'),
                      items: categories
                          .map(
                            (kategori) => DropdownMenuItem(
                              value: kategori,
                              child: Text(kategori),
                            ),
                          )
                          .toList(),
                      onChanged: (value) {
                        if (value != null) {
                          setDialogState(() {
                            selectedKategori = value;
                          });
                        }
                      },
                    ),

                    const SizedBox(height: 12),

                    ListTile(
                      contentPadding: EdgeInsets.zero,
                      title: Text(
                        'Tanggal: ${DateFormat('dd MMMM yyyy', 'id_ID').format(selectedTanggal)}',
                      ),
                      trailing: const Icon(Icons.calendar_today),
                      onTap: () async {
                        final picked = await showDatePicker(
                          context: context,
                          initialDate: selectedTanggal,
                          firstDate: DateTime(2020),
                          lastDate: DateTime(2030),
                        );

                        if (picked != null) {
                          setDialogState(() {
                            selectedTanggal = picked;
                          });
                        }
                      },
                    ),

                    Row(
                      children: [
                        Expanded(
                          child: TextButton(
                            child: Text('Mulai: ${waktuMulai.format(context)}'),
                            onPressed: () async {
                              final picked = await showTimePicker(
                                context: context,
                                initialTime: waktuMulai,
                              );

                              if (picked != null) {
                                setDialogState(() {
                                  waktuMulai = picked;
                                });
                              }
                            },
                          ),
                        ),

                        Expanded(
                          child: TextButton(
                            child: Text(
                              'Selesai: ${waktuSelesai.format(context)}',
                            ),
                            onPressed: () async {
                              final picked = await showTimePicker(
                                context: context,
                                initialTime: waktuSelesai,
                              );

                              if (picked != null) {
                                setDialogState(() {
                                  waktuSelesai = picked;
                                });
                              }
                            },
                          ),
                        ),
                      ],
                    ),

                    TextField(
                      controller: catatanController,
                      decoration: const InputDecoration(labelText: 'Catatan'),
                      maxLines: 2,
                    ),

                    if (docId != null) ...[
                      const SizedBox(height: 12),

                      DropdownButtonFormField<String>(
                        initialValue: selectedStatus,
                        decoration: const InputDecoration(labelText: 'Status'),
                        items: statuses
                            .map(
                              (status) => DropdownMenuItem(
                                value: status,
                                child: Text(status),
                              ),
                            )
                            .toList(),
                        onChanged: (value) {
                          if (value != null) {
                            setDialogState(() {
                              selectedStatus = value;
                            });
                          }
                        },
                      ),
                    ],
                  ],
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('Batal'),
                ),

                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                  ),
                  onPressed: () async {
                    if (kegiatanController.text.trim().isEmpty) {
                      return;
                    }

                    final user = FirebaseAuth.instance.currentUser;

                    if (user == null) {
                      return;
                    }

                    final data = {
                      'userId': user.uid,
                      'kegiatan': kegiatanController.text.trim(),
                      'kategori': selectedKategori,
                      'tanggal': Timestamp.fromDate(selectedTanggal),
                      'waktuMulai':
                          '${waktuMulai.hour.toString().padLeft(2, '0')}.${waktuMulai.minute.toString().padLeft(2, '0')}',
                      'waktuSelesai':
                          '${waktuSelesai.hour.toString().padLeft(2, '0')}.${waktuSelesai.minute.toString().padLeft(2, '0')}',
                      'catatan': catatanController.text.trim(),
                      'status': selectedStatus,
                    };

                    if (docId == null) {
                      await FirebaseFirestore.instance
                          .collection('agenda')
                          .add(data);
                    } else {
                      await FirebaseFirestore.instance
                          .collection('agenda')
                          .doc(docId)
                          .update(data);
                    }

                    if (context.mounted) {
                      Navigator.pop(context);
                    }
                  },
                  child: const Text(
                    'Simpan',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }

  void _confirmDelete(BuildContext context, String docId, String namaKegiatan) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Konfirmasi Hapus'),
          content: Text('Hapus agenda "$namaKegiatan"?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Batal'),
            ),

            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
              onPressed: () async {
                await FirebaseFirestore.instance
                    .collection('agenda')
                    .doc(docId)
                    .delete();

                if (context.mounted) {
                  Navigator.pop(context);
                }
              },
              child: const Text('Hapus', style: TextStyle(color: Colors.white)),
            ),
          ],
        );
      },
    );
  }

  bool _sudahLewat(Map<String, dynamic> data) {
    final tanggal = (data['tanggal'] as Timestamp).toDate();

    final waktuSelesai = data['waktuSelesai']?.toString() ?? '00.00';

    final bagianWaktu = waktuSelesai.split('.');

    final jam = int.tryParse(bagianWaktu[0]) ?? 0;

    final menit =
        int.tryParse(bagianWaktu.length > 1 ? bagianWaktu[1] : '0') ?? 0;

    final batasWaktu = DateTime(
      tanggal.year,
      tanggal.month,
      tanggal.day,
      jam,
      menit,
    );

    return DateTime.now().isAfter(batasWaktu);
  }

  Future<void> _perbaruiStatusTerlewat(List<QueryDocumentSnapshot> docs) async {
    final batch = FirebaseFirestore.instance.batch();

    bool adaPerubahan = false;

    for (final doc in docs) {
      final data = doc.data() as Map<String, dynamic>;

      final status = data['status'] ?? 'Belum selesai';

      if (status == 'Belum selesai' && _sudahLewat(data)) {
        batch.update(doc.reference, {'status': 'Terlewat'});

        adaPerubahan = true;
      }
    }

    if (adaPerubahan) {
      await batch.commit();
    }
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Agenda / Kegiatan'),
          backgroundColor: const Color(0xFF4F7D58),
          foregroundColor: Colors.white,
          bottom: const TabBar(
            labelColor: Colors.white,
            indicatorColor: Colors.white,
            tabs: [
              Tab(text: 'Agenda Aktif'),
              Tab(text: 'Riwayat'),
            ],
          ),
        ),

        body: TabBarView(
          children: [
            _buildAgendaList(context, isRiwayat: false),
            _buildAgendaList(context, isRiwayat: true),
          ],
        ),

        floatingActionButton: FloatingActionButton.extended(
          backgroundColor: Colors.green,
          onPressed: () {
            showAgendaFormDialog(context);
          },
          icon: const Icon(Icons.add, color: Colors.white),
          label: const Text(
            'Tambah Agenda',
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }

  Widget _buildAgendaList(BuildContext context, {required bool isRiwayat}) {
    final user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      return const Center(child: Text('Silakan login terlebih dahulu.'));
    }

    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('agenda')
          .where('userId', isEqualTo: user.uid)
          .orderBy('tanggal', descending: false)
          .snapshots(),

      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasError) {
          return Center(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Text(
                'Gagal mengambil agenda.\n\n${snapshot.error}',
                textAlign: TextAlign.center,
              ),
            ),
          );
        }

        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return const Center(child: Text('Belum ada agenda.'));
        }

        final semuaDocs = snapshot.data!.docs;

        // Memperbarui agenda yang sudah melewati waktu selesai.
        _perbaruiStatusTerlewat(semuaDocs);

        final docs = semuaDocs.where((doc) {
          final data = doc.data() as Map<String, dynamic>;

          final status = data['status'] ?? 'Belum selesai';

          return isRiwayat
              ? (status == 'Selesai' || status == 'Terlewat')
              : status == 'Belum selesai';
        }).toList();

        if (docs.isEmpty) {
          return Center(
            child: Text(
              isRiwayat ? 'Belum ada riwayat.' : 'Belum ada agenda aktif.',
            ),
          );
        }

        return ListView.builder(
          itemCount: docs.length,
          padding: const EdgeInsets.all(12),

          itemBuilder: (context, index) {
            final doc = docs[index];

            final data = doc.data() as Map<String, dynamic>;

            final DateTime tanggal = (data['tanggal'] as Timestamp).toDate();

            return Card(
              elevation: 2,
              margin: const EdgeInsets.only(bottom: 12),

              child: ListTile(
                title: Text(
                  data['kegiatan'] ?? '',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),

                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 4),

                    Text(
                      '${DateFormat('dd MMMM yyyy', 'id_ID').format(tanggal)} '
                      '(${data['waktuMulai']} - ${data['waktuSelesai']})',
                    ),

                    Text('Kategori: ${data['kategori']}'),

                    if (data['catatan'] != null &&
                        data['catatan'].toString().isNotEmpty)
                      Text('Catatan: ${data['catatan']}'),

                    const SizedBox(height: 4),

                    Chip(
                      label: Text(
                        data['status'] ?? 'Belum selesai',
                        style: const TextStyle(
                          fontSize: 12,
                          color: Colors.white,
                        ),
                      ),
                      backgroundColor: _getStatusColor(data['status']),
                    ),
                  ],
                ),

                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.edit, color: Colors.blue),
                      onPressed: () {
                        showAgendaFormDialog(
                          context,
                          docId: doc.id,
                          initialKegiatan: data['kegiatan'],
                          initialKategori: data['kategori'],
                          initialTanggal: tanggal,
                          initialCatatan: data['catatan'],
                          initialStatus: data['status'],
                        );
                      },
                    ),

                    IconButton(
                      icon: const Icon(Icons.delete, color: Colors.red),
                      onPressed: () {
                        _confirmDelete(context, doc.id, data['kegiatan']);
                      },
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  Color _getStatusColor(String? status) {
    switch (status) {
      case 'Selesai':
        return Colors.green;

      case 'Terlewat':
        return Colors.red;

      default:
        return Colors.orange;
    }
  }
}

// ==========================================
// 2. BAGIAN KOMPUTASI PERTANIAN
// ==========================================

class KomputasiPertanianTab extends StatefulWidget {
  const KomputasiPertanianTab({super.key});

  @override
  State<KomputasiPertanianTab> createState() => _KomputasiPertanianTabState();
}

class _KomputasiPertanianTabState extends State<KomputasiPertanianTab> {
  // A. Umur Tanaman
  DateTime? _tglTanamUmur;
  int? _hasilUmurHari;

  // B. Prediksi Panen
  DateTime? _tglTanamPanen;
  final _lamaLahanController = TextEditingController();
  DateTime? _hasilTglPanen;

  // C. Kebutuhan Pupuk
  final _luasLahanController = TextEditingController();
  final _dosisPupukController = TextEditingController();
  double? _hasilPupuk;

  // D. Jumlah Tanaman
  final _panjangLahanController = TextEditingController();
  final _lebarLahanController = TextEditingController();
  final _jarakTanamController = TextEditingController();
  int? _hasilJumlahTanaman;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Komputasi Pertanian'),
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),

        child: Column(
          children: [
            _buildUmurTanamanCard(),

            const SizedBox(height: 16),

            _buildPrediksiPanenCard(),

            const SizedBox(height: 16),

            _buildKebutuhanPupukCard(),

            const SizedBox(height: 16),

            _buildJumlahTanamanCard(),
          ],
        ),
      ),
    );
  }

  // ==========================================
  // A. UMUR TANAMAN
  // ==========================================

  Widget _buildUmurTanamanCard() {
    return Card(
      elevation: 2,

      child: Padding(
        padding: const EdgeInsets.all(16),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [
            const Text(
              'A. Umur Tanaman',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 8),

            ListTile(
              contentPadding: EdgeInsets.zero,

              title: Text(
                _tglTanamUmur == null
                    ? 'Pilih Tanggal Tanam'
                    : 'Tanggal Tanam: '
                          '${DateFormat('dd MMMM yyyy', 'id_ID').format(_tglTanamUmur!)}',
              ),

              trailing: const Icon(Icons.calendar_today),

              onTap: () async {
                final picked = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(2020),
                  lastDate: DateTime.now(),
                );

                if (picked != null) {
                  setState(() {
                    _tglTanamUmur = picked;
                  });
                }
              },
            ),

            ElevatedButton(
              onPressed: _tglTanamUmur == null
                  ? null
                  : () {
                      setState(() {
                        _hasilUmurHari = DateTime.now()
                            .difference(_tglTanamUmur!)
                            .inDays;
                      });
                    },
              child: const Text('Hitung'),
            ),

            if (_hasilUmurHari != null) ...[
              const SizedBox(height: 8),

              Text(
                'Hasil: Umur tanaman $_hasilUmurHari hari',
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ],
          ],
        ),
      ),
    );
  }

  // ==========================================
  // B. PREDIKSI PANEN
  // ==========================================

  Widget _buildPrediksiPanenCard() {
    return Card(
      elevation: 2,

      child: Padding(
        padding: const EdgeInsets.all(16),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [
            const Text(
              'B. Prediksi Panen',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 8),

            ListTile(
              contentPadding: EdgeInsets.zero,

              title: Text(
                _tglTanamPanen == null
                    ? 'Pilih Tanggal Tanam'
                    : 'Tanggal Tanam: '
                          '${DateFormat('dd MMMM yyyy', 'id_ID').format(_tglTanamPanen!)}',
              ),

              trailing: const Icon(Icons.calendar_today),

              onTap: () async {
                final picked = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(2020),
                  lastDate: DateTime(2030),
                );

                if (picked != null) {
                  setState(() {
                    _tglTanamPanen = picked;
                  });
                }
              },
            ),

            TextField(
              controller: _lamaLahanController,
              keyboardType: TextInputType.number,

              decoration: const InputDecoration(
                labelText: 'Lama Pertumbuhan (hari)',
              ),
            ),

            const SizedBox(height: 8),

            ElevatedButton(
              onPressed: () {
                final lama = int.tryParse(_lamaLahanController.text);

                if (_tglTanamPanen != null && lama != null && lama > 0) {
                  setState(() {
                    _hasilTglPanen = _tglTanamPanen!.add(Duration(days: lama));
                  });
                }
              },
              child: const Text('Hitung'),
            ),

            if (_hasilTglPanen != null) ...[
              const SizedBox(height: 8),

              Text(
                'Perkiraan Tanggal Panen: '
                '${DateFormat('dd MMMM yyyy', 'id_ID').format(_hasilTglPanen!)}',
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),

              const SizedBox(height: 8),

              OutlinedButton.icon(
                icon: const Icon(Icons.add_task),

                label: const Text('Tambahkan ke Agenda'),

                onPressed: () {
                  AgendaMainTab.showAgendaFormDialog(
                    context,

                    initialKegiatan: 'Perkiraan Panen',

                    initialKategori: 'Pertanian',

                    initialTanggal: _hasilTglPanen!,

                    initialCatatan: 'Hasil prediksi dari perhitungan komputasi',
                  );
                },
              ),
            ],
          ],
        ),
      ),
    );
  }

  // ==========================================
  // C. KEBUTUHAN PUPUK
  // ==========================================

  Widget _buildKebutuhanPupukCard() {
    return Card(
      elevation: 2,

      child: Padding(
        padding: const EdgeInsets.all(16),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [
            const Text(
              'C. Kebutuhan Pupuk',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),

            TextField(
              controller: _luasLahanController,
              keyboardType: TextInputType.number,

              decoration: const InputDecoration(labelText: 'Luas Lahan (m²)'),
            ),

            TextField(
              controller: _dosisPupukController,

              keyboardType: const TextInputType.numberWithOptions(
                decimal: true,
              ),

              decoration: const InputDecoration(
                labelText: 'Dosis Pupuk (kg/m²)',
              ),
            ),

            const SizedBox(height: 8),

            ElevatedButton(
              onPressed: () {
                final luas = double.tryParse(_luasLahanController.text);

                final dosis = double.tryParse(
                  _dosisPupukController.text.replaceAll(',', '.'),
                );

                if (luas != null && dosis != null && luas >= 0 && dosis >= 0) {
                  setState(() {
                    _hasilPupuk = luas * dosis;
                  });
                }
              },
              child: const Text('Hitung'),
            ),

            if (_hasilPupuk != null) ...[
              const SizedBox(height: 8),

              Text(
                'Kebutuhan Pupuk: '
                '${_hasilPupuk!.toStringAsFixed(1)} kg',

                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ],
          ],
        ),
      ),
    );
  }

  // ==========================================
  // D. JUMLAH TANAMAN
  // ==========================================

  Widget _buildJumlahTanamanCard() {
    return Card(
      elevation: 2,

      child: Padding(
        padding: const EdgeInsets.all(16),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [
            const Text(
              'D. Jumlah Tanaman',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),

            TextField(
              controller: _panjangLahanController,
              keyboardType: TextInputType.number,

              decoration: const InputDecoration(labelText: 'Panjang Lahan (m)'),
            ),

            TextField(
              controller: _lebarLahanController,
              keyboardType: TextInputType.number,

              decoration: const InputDecoration(labelText: 'Lebar Lahan (m)'),
            ),

            TextField(
              controller: _jarakTanamController,

              keyboardType: const TextInputType.numberWithOptions(
                decimal: true,
              ),

              decoration: const InputDecoration(labelText: 'Jarak Tanam (m)'),
            ),

            const SizedBox(height: 8),

            ElevatedButton(
              onPressed: () {
                final p = double.tryParse(_panjangLahanController.text);

                final l = double.tryParse(_lebarLahanController.text);

                final j = double.tryParse(
                  _jarakTanamController.text.replaceAll(',', '.'),
                );

                if (p != null &&
                    l != null &&
                    j != null &&
                    p > 0 &&
                    l > 0 &&
                    j > 0) {
                  setState(() {
                    _hasilJumlahTanaman = ((p * l) / (j * j)).floor();
                  });
                }
              },
              child: const Text('Hitung'),
            ),

            if (_hasilJumlahTanaman != null) ...[
              const SizedBox(height: 8),

              Text(
                'Perkiraan Jumlah Tanaman: '
                '$_hasilJumlahTanaman tanaman',

                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ],
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _lamaLahanController.dispose();
    _luasLahanController.dispose();
    _dosisPupukController.dispose();
    _panjangLahanController.dispose();
    _lebarLahanController.dispose();
    _jarakTanamController.dispose();

    super.dispose();
  }
}

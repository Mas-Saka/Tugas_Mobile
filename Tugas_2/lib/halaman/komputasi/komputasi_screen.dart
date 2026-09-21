import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../layanan/layanan_tanaman.dart';

class KomputasiScreen extends StatelessWidget {
  const KomputasiScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F5EF),
      appBar: AppBar(
        title: const Text('Komputasi Pertanian'),
        backgroundColor: const Color(0xFF4F7D58),
        foregroundColor: Colors.white,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _menu(
            context,
            'Umur Tanaman',
            'Menghitung umur tanaman berdasarkan tanggal tanam',
            const UmurTanamanScreen(),
          ),
          _menu(
            context,
            'Prediksi Panen',
            'Membandingkan umur tanaman dengan data referensi',
            const PrediksiPanenScreen(),
          ),
          _menu(
            context,
            'Kebutuhan Pupuk',
            'Membandingkan penggunaan pupuk dengan data referensi',
            const KebutuhanPupukScreen(),
          ),
          _menu(
            context,
            'Jumlah Tanaman',
            'Menghitung perkiraan jumlah tanaman berdasarkan luas dan jarak tanam',
            const JumlahTanamanScreen(),
          ),
        ],
      ),
    );
  }

  Widget _menu(
    BuildContext context,
    String judul,
    String keterangan,
    Widget halaman,
  ) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => halaman),
          );
        },
        child: Padding(
          padding: const EdgeInsets.all(18),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                judul,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF26382B),
                ),
              ),
              const SizedBox(height: 6),
              Text(
                keterangan,
                style: const TextStyle(color: Colors.black54, height: 1.4),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ======================================================
// UMUR TANAMAN
// ======================================================

class UmurTanamanScreen extends StatefulWidget {
  const UmurTanamanScreen({super.key});

  @override
  State<UmurTanamanScreen> createState() => _UmurTanamanScreenState();
}

class _UmurTanamanScreenState extends State<UmurTanamanScreen> {
  DateTime? tanggalTanam;
  int? umurHari;

  Future<void> pilihTanggal() async {
    final tanggal = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
    );

    if (tanggal != null) {
      setState(() {
        tanggalTanam = tanggal;
        umurHari = DateTime.now().difference(tanggal).inDays;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F5EF),
      appBar: AppBar(
        title: const Text('Umur Tanaman'),
        backgroundColor: const Color(0xFF4F7D58),
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Tanggal Tanam',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),

            _tombolTanggal(tanggalTanam, pilihTanggal),

            const SizedBox(height: 20),

            if (umurHari != null) _hasil('Umur tanaman', '$umurHari hari'),
          ],
        ),
      ),
    );
  }
}

// ======================================================
// PREDIKSI PANEN
// ======================================================

class PrediksiPanenScreen extends StatefulWidget {
  const PrediksiPanenScreen({super.key});

  @override
  State<PrediksiPanenScreen> createState() => _PrediksiPanenScreenState();
}

class _PrediksiPanenScreenState extends State<PrediksiPanenScreen> {
  final LayananTanaman layananTanaman = LayananTanaman();

  List<DataTanaman> daftarTanaman = [];

  DataTanaman? tanamanTerpilih;

  DateTime? tanggalTanam;

  int? umurSekarang;

  DateTime? tanggalPrediksi;

  bool sedangMemuat = true;

  @override
  void initState() {
    super.initState();
    ambilDataTanaman();
  }

  Future<void> ambilDataTanaman() async {
    try {
      final data = await layananTanaman.ambilTanaman();

      if (!mounted) return;

      setState(() {
        daftarTanaman = data;
        sedangMemuat = false;
      });
    } catch (e) {
      if (!mounted) return;

      setState(() {
        sedangMemuat = false;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Gagal mengambil data tanaman: $e')),
      );
    }
  }

  Future<void> pilihTanggal() async {
    final tanggal = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
    );

    if (tanggal != null) {
      setState(() {
        tanggalTanam = tanggal;

        umurSekarang = DateTime.now().difference(tanggal).inDays;

        hitungPrediksi();
      });
    }
  }

  void hitungPrediksi() {
    if (tanggalTanam == null || tanamanTerpilih == null) {
      tanggalPrediksi = null;
      return;
    }

    tanggalPrediksi = tanggalTanam!.add(
      Duration(days: tanamanTerpilih!.umurPanenReferensi),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F5EF),
      appBar: AppBar(
        title: const Text('Prediksi Panen'),
        backgroundColor: const Color(0xFF4F7D58),
        foregroundColor: Colors.white,
      ),
      body: sedangMemuat
          ? const Center(child: CircularProgressIndicator())
          : daftarTanaman.isEmpty
          ? const Center(child: Text('Belum ada data tanaman.'))
          : ListView(
              padding: const EdgeInsets.all(16),
              children: [
                const Text(
                  'Pilih Tanaman',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),

                const SizedBox(height: 8),

                DropdownButtonFormField<DataTanaman>(
                  value: tanamanTerpilih,
                  decoration: _inputDecoration('Tanaman'),
                  items: daftarTanaman.map((tanaman) {
                    return DropdownMenuItem<DataTanaman>(
                      value: tanaman,
                      child: Text(tanaman.nama),
                    );
                  }).toList(),
                  onChanged: (nilai) {
                    setState(() {
                      tanamanTerpilih = nilai;
                      hitungPrediksi();
                    });
                  },
                ),

                const SizedBox(height: 20),

                const Text(
                  'Tanggal Tanam',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),

                const SizedBox(height: 8),

                _tombolTanggal(tanggalTanam, pilihTanggal),

                const SizedBox(height: 20),

                if (tanamanTerpilih != null)
                  _hasil(
                    'Rentang umur panen',
                    '${tanamanTerpilih!.umurPanenMin} - '
                        '${tanamanTerpilih!.umurPanenMax} hari',
                  ),

                if (tanamanTerpilih != null)
                  _hasil(
                    'Rata-rata lama panen',
                    '${tanamanTerpilih!.umurPanenReferensi} hari',
                  ),

                if (umurSekarang != null)
                  _hasil('Umur tanaman sekarang', '$umurSekarang hari'),

                if (tanggalPrediksi != null)
                  _hasil(
                    'Perkiraan tanggal panen berdasarkan rata-rata lama panen',
                    _formatTanggal(tanggalPrediksi!),
                  ),

                if (tanamanTerpilih != null)
                  _keterangan(tanamanTerpilih!.konteks),

                if (tanamanTerpilih != null)
                  _keterangan('Sumber: ${tanamanTerpilih!.sumber}'),
              ],
            ),
    );
  }
}

// ======================================================
// KEBUTUHAN PUPUK
// ======================================================

class KebutuhanPupukScreen extends StatefulWidget {
  const KebutuhanPupukScreen({super.key});

  @override
  State<KebutuhanPupukScreen> createState() => _KebutuhanPupukScreenState();
}

class _KebutuhanPupukScreenState extends State<KebutuhanPupukScreen> {
  final LayananTanaman layananTanaman = LayananTanaman();

  List<DataTanaman> daftarTanaman = [];
  DataTanaman? tanamanTerpilih;

  final luasController = TextEditingController();

  bool sedangMemuat = true;
  bool sudahDihitung = false;

  double? ureaMin;
  double? ureaMax;
  double? sp36Min;
  double? sp36Max;
  double? kclMin;
  double? kclMax;

  @override
  void initState() {
    super.initState();
    ambilDataTanaman();
  }

  Future<void> ambilDataTanaman() async {
    try {
      final hasil = await layananTanaman.ambilTanaman();

      if (!mounted) return;

      setState(() {
        daftarTanaman = hasil;
        sedangMemuat = false;
      });
    } catch (e) {
      if (!mounted) return;

      setState(() {
        sedangMemuat = false;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Gagal mengambil data tanaman: $e')),
      );
    }
  }

  void hitungKebutuhan() {
    if (tanamanTerpilih == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Silakan pilih tanaman terlebih dahulu.')),
      );
      return;
    }

    final luas = double.tryParse(luasController.text.replaceAll(',', '.'));

    if (luas == null || luas <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Masukkan luas lahan yang valid.')),
      );
      return;
    }

    // 1 hektar = 10.000 m²
    final faktorLuas = luas / 10000;

    setState(() {
      ureaMin = tanamanTerpilih!.ureaMin * faktorLuas;
      ureaMax = tanamanTerpilih!.ureaMax * faktorLuas;

      sp36Min = tanamanTerpilih!.sp36Min * faktorLuas;
      sp36Max = tanamanTerpilih!.sp36Max * faktorLuas;

      kclMin = tanamanTerpilih!.kclMin * faktorLuas;
      kclMax = tanamanTerpilih!.kclMax * faktorLuas;

      sudahDihitung = true;
    });
  }

  String formatAngka(double nilai) {
    if (nilai == nilai.roundToDouble()) {
      return nilai.toStringAsFixed(0);
    }

    return nilai.toStringAsFixed(2);
  }

  String hasilPupuk(double min, double max) {
    if (min == max) {
      return '${formatAngka(min)} kg';
    }

    return '${formatAngka(min)} - ${formatAngka(max)} kg';
  }

  @override
  void dispose() {
    luasController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F5EF),
      appBar: AppBar(
        title: const Text('Kebutuhan Pupuk'),
        backgroundColor: const Color(0xFF4F7D58),
        foregroundColor: Colors.white,
      ),
      body: sedangMemuat
          ? const Center(child: CircularProgressIndicator())
          : daftarTanaman.isEmpty
          ? const Center(child: Text('Belum ada data tanaman.'))
          : ListView(
              padding: const EdgeInsets.all(20),
              children: [
                const Text(
                  'Kebutuhan Pupuk',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF26382B),
                  ),
                ),

                const SizedBox(height: 8),

                const Text(
                  'Masukkan jenis tanaman dan luas lahan untuk menghitung '
                  'perkiraan kebutuhan pupuk.',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.black54,
                    height: 1.4,
                  ),
                ),

                const SizedBox(height: 24),

                const Text(
                  'Jenis Tanaman',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF26382B),
                  ),
                ),

                const SizedBox(height: 8),

                DropdownButtonFormField<DataTanaman>(
                  initialValue: tanamanTerpilih,
                  decoration: _inputDecoration('Pilih tanaman'),
                  items: daftarTanaman.map((tanaman) {
                    return DropdownMenuItem<DataTanaman>(
                      value: tanaman,
                      child: Text(tanaman.nama),
                    );
                  }).toList(),
                  onChanged: (nilai) {
                    setState(() {
                      tanamanTerpilih = nilai;
                      sudahDihitung = false;

                      ureaMin = null;
                      ureaMax = null;
                      sp36Min = null;
                      sp36Max = null;
                      kclMin = null;
                      kclMax = null;
                    });
                  },
                ),

                const SizedBox(height: 18),

                const Text(
                  'Luas Lahan',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF26382B),
                  ),
                ),

                const SizedBox(height: 8),

                TextField(
                  controller: luasController,
                  keyboardType: const TextInputType.numberWithOptions(
                    decimal: true,
                  ),
                  decoration: _inputDecoration(
                    'Masukkan luas lahan',
                    suffixText: 'm²',
                  ),
                ),

                const SizedBox(height: 20),

                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: hitungKebutuhan,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF4F7D58),
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: const Text(
                      'Hitung Kebutuhan Pupuk',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ),

                if (sudahDihitung &&
                    ureaMin != null &&
                    ureaMax != null &&
                    sp36Min != null &&
                    sp36Max != null &&
                    kclMin != null &&
                    kclMax != null) ...[
                  const SizedBox(height: 28),

                  Container(
                    padding: const EdgeInsets.all(18),
                    decoration: BoxDecoration(
                      color: Colors.green.shade50,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: Colors.green.shade100),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Hasil Perhitungan',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF26382B),
                          ),
                        ),

                        const SizedBox(height: 14),

                        Text(
                          'Tanaman: ${tanamanTerpilih!.nama}',
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),

                        const SizedBox(height: 4),

                        Text('Luas lahan: ${luasController.text} m²'),

                        const SizedBox(height: 20),

                        _hasilPupuk('Urea', hasilPupuk(ureaMin!, ureaMax!)),

                        const SizedBox(height: 12),

                        _hasilPupuk('SP-36', hasilPupuk(sp36Min!, sp36Max!)),

                        const SizedBox(height: 12),

                        _hasilPupuk('KCl', hasilPupuk(kclMin!, kclMax!)),

                        const SizedBox(height: 20),

                        const Text(
                          'Catatan:',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),

                        const SizedBox(height: 4),

                        const Text(
                          'Hasil merupakan perkiraan kebutuhan pupuk '
                          'berdasarkan data referensi tanaman yang '
                          'tersimpan di aplikasi. Kebutuhan aktual '
                          'dapat berbeda tergantung kondisi lahan, '
                          'varietas, dan kondisi tanaman.',
                          style: TextStyle(
                            fontSize: 13,
                            color: Colors.black54,
                            height: 1.4,
                          ),
                        ),

                        const SizedBox(height: 12),

                        Text(
                          'Sumber: ${tanamanTerpilih!.sumber}',
                          style: const TextStyle(
                            fontSize: 12,
                            color: Colors.black54,
                            height: 1.4,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ],
            ),
    );
  }

  Widget _hasilPupuk(String nama, String jumlah) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            nama,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
          ),
          Text(
            jumlah,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Color(0xFF4F7D58),
            ),
          ),
        ],
      ),
    );
  }
}

// ======================================================
// JUMLAH TANAMAN
// ======================================================

class JumlahTanamanScreen extends StatefulWidget {
  const JumlahTanamanScreen({super.key});

  @override
  State<JumlahTanamanScreen> createState() => _JumlahTanamanScreenState();
}

class _JumlahTanamanScreenState extends State<JumlahTanamanScreen> {
  final luasController = TextEditingController();

  final jarakBarisController = TextEditingController();

  final jarakTanamanController = TextEditingController();

  String hasil = '';

  @override
  void dispose() {
    luasController.dispose();
    jarakBarisController.dispose();
    jarakTanamanController.dispose();

    super.dispose();
  }

  void hitungJumlahTanaman() {
    final luas = double.tryParse(luasController.text);

    final jarakBaris = double.tryParse(jarakBarisController.text);

    final jarakTanaman = double.tryParse(jarakTanamanController.text);

    if (luas == null || luas <= 0) {
      _pesanError('Masukkan luas lahan yang benar.');
      return;
    }

    if (jarakBaris == null || jarakBaris <= 0) {
      _pesanError('Masukkan jarak antarbaris yang benar.');
      return;
    }

    if (jarakTanaman == null || jarakTanaman <= 0) {
      _pesanError('Masukkan jarak antartanaman yang benar.');
      return;
    }

    final luasTanaman = (jarakBaris / 100) * (jarakTanaman / 100);

    final jumlah = luas / luasTanaman;

    setState(() {
      hasil = '${jumlah.floor()} tanaman';
    });
  }

  void _pesanError(String pesan) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(pesan)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F5EF),
      appBar: AppBar(
        title: const Text('Jumlah Tanaman'),
        backgroundColor: const Color(0xFF4F7D58),
        foregroundColor: Colors.white,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          TextField(
            controller: luasController,
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            decoration: _inputDecoration('Luas lahan (m²)'),
          ),

          const SizedBox(height: 12),

          TextField(
            controller: jarakBarisController,
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            decoration: _inputDecoration('Jarak antarbaris (cm)'),
          ),

          const SizedBox(height: 12),

          TextField(
            controller: jarakTanamanController,
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            decoration: _inputDecoration('Jarak antartanaman (cm)'),
          ),

          const SizedBox(height: 20),

          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: hitungJumlahTanaman,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF4F7D58),
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 14),
              ),
              child: const Text('Hitung Jumlah Tanaman'),
            ),
          ),

          const SizedBox(height: 20),

          if (hasil.isNotEmpty) _hasil('Perkiraan jumlah tanaman', hasil),
        ],
      ),
    );
  }
}

// ======================================================
// WIDGET BANTUAN
// ======================================================

Widget _hasil(String judul, String isi) {
  return Container(
    width: double.infinity,
    margin: const EdgeInsets.only(bottom: 12),
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: const Color(0xFFDDE5DD)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          judul,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: Color(0xFF4F7D58),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          isi,
          style: const TextStyle(color: Color(0xFF26382B), height: 1.4),
        ),
      ],
    ),
  );
}

Widget _keterangan(String teks) {
  return Container(
    margin: const EdgeInsets.only(bottom: 12),
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: const Color(0xFFEAF0EA),
      borderRadius: BorderRadius.circular(10),
    ),
    child: Text(
      teks,
      style: const TextStyle(
        fontSize: 13,
        color: Color(0xFF26382B),
        height: 1.4,
      ),
    ),
  );
}

Widget _tombolTanggal(DateTime? tanggal, VoidCallback onPressed) {
  return SizedBox(
    width: double.infinity,
    child: OutlinedButton(
      onPressed: onPressed,
      style: OutlinedButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: 14),
      ),
      child: Text(tanggal == null ? 'Pilih tanggal' : _formatTanggal(tanggal)),
    ),
  );
}

InputDecoration _inputDecoration(String label, {String? suffixText}) {
  return InputDecoration(
    labelText: label,
    suffixText: suffixText,
    filled: true,
    fillColor: Colors.white,
    border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
  );
}

String _formatTanggal(DateTime tanggal) {
  return DateFormat('dd MMMM yyyy', 'id_ID').format(tanggal);
}

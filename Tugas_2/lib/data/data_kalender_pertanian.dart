import 'package:cloud_firestore/cloud_firestore.dart';

class DataKalenderPertanian {
  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  static const String _koleksiKalender = 'hari_baik_pertanian';
  static const String _koleksiFenomena = 'fenomena_pertanian';

  static Future<void> isiData() async {
    await _isiKalenderHarian();
    await _isiFenomenaPertanian();

    print('Data kalender pertanian selesai diisi.');
  }

  static Future<void> _isiKalenderHarian() async {
    final List<Map<String, dynamic>> data = [];

    DateTime tanggal = DateTime(2023, 1, 1);
    final DateTime akhir = DateTime(2029, 12, 31);

    while (!tanggal.isAfter(akhir)) {
      final hari = _namaHari(tanggal.weekday);
      final pasaran = _namaPasaran(tanggal);
      final neptuHari = _neptuHari(tanggal.weekday);
      final neptuPasaran = _neptuPasaran(pasaran);
      final mangsa = _tentukanMangsa(tanggal);

      data.add({
        'tanggal': _formatTanggal(tanggal),
        'tahun': tanggal.year,
        'hari': hari,
        'pasaran': pasaran,
        'neptu_hari': neptuHari,
        'neptu_pasaran': neptuPasaran,
        'neptu_total': neptuHari + neptuPasaran,
        'mangsa': mangsa.nama,
        'periode_mangsa': mangsa.periode,
        'kegiatan_pertanian': mangsa.kegiatan,
        'kategori': 'Kalender Pertanian Jawa',
        'kegiatan': mangsa.kegiatan,
        'keterangan':
            'Informasi Pranata Mangsa sebagai kalender pertanian '
            'tradisional Jawa. Kesesuaian kegiatan tetap perlu '
            'mempertimbangkan kondisi wilayah, ketersediaan air, '
            'cuaca, dan kondisi lahan.',
        'jenis_data': 'kalender_harian',
        'wilayah_referensi': 'Jawa',
        'sumber':
            'BRIN - Teknologi dan Kearifan Lokal untuk Adaptasi '
            'Perubahan Iklim',
      });

      tanggal = tanggal.add(const Duration(days: 1));
    }

    await _simpanBertahap(_koleksiKalender, data);
  }

  static Future<void> _isiFenomenaPertanian() async {
    final data = <Map<String, dynamic>>[
      {
        'id': 'banjir',
        'nama': 'Banjir dan genangan',
        'jenis': 'risiko_iklim',
        'dampak':
            'Banjir dan genangan dapat menyebabkan kerusakan tanaman '
            'dan menurunkan produksi tanaman pangan.',
        'saran':
            'Perhatikan kondisi saluran air, tinggi genangan, dan '
            'informasi peringatan banjir sebelum menentukan kegiatan tanam.',
        'tanaman_relevan': [
          'Padi sawah',
          'Jagung',
          'Kedelai',
          'Kacang tanah',
          'Kacang hijau',
        ],
        'sumber':
            'Kementerian Pertanian - Katam Terpadu Modern dan '
            'Si-PERDITAN',
      },
      {
        'id': 'kekeringan',
        'nama': 'Kekeringan',
        'jenis': 'risiko_iklim',
        'dampak':
            'Kekurangan air dapat mengganggu pertumbuhan tanaman '
            'dan meningkatkan risiko penurunan produksi.',
        'saran':
            'Sesuaikan waktu tanam dengan ketersediaan air dan '
            'informasi iklim setempat.',
        'tanaman_relevan': [
          'Padi sawah',
          'Jagung',
          'Kedelai',
          'Bawang merah',
          'Kacang hijau',
        ],
        'sumber':
            'Kementerian Pertanian - Katam Terpadu Modern dan '
            'kajian waktu tanam serta kebutuhan air tanaman',
      },
      {
        'id': 'opt',
        'nama': 'Organisme Pengganggu Tanaman (OPT)',
        'jenis': 'risiko_biologis',
        'dampak':
            'Serangan hama dan penyakit dapat mengganggu pertumbuhan '
            'dan menyebabkan kehilangan hasil.',
        'saran':
            'Pantau tanaman secara berkala dan gunakan pengendalian '
            'sesuai kondisi serta ambang kerusakan yang berlaku.',
        'tanaman_relevan': [
          'Padi sawah',
          'Jagung',
          'Kedelai',
          'Kacang tanah',
          'Kacang hijau',
          'Bawang merah',
        ],
        'sumber':
            'Kementerian Pertanian - Katam Terpadu Modern dan '
            'Si-PERDITAN',
      },
      {
        'id': 'anomali_iklim',
        'nama': 'Anomali iklim',
        'jenis': 'risiko_iklim',
        'dampak':
            'Perubahan atau penyimpangan pola curah hujan dan musim '
            'dapat mengganggu penentuan waktu dan pola tanam.',
        'saran':
            'Gunakan informasi iklim dan kalender tanam yang sesuai '
            'wilayah sebelum menentukan waktu tanam.',
        'tanaman_relevan': ['Padi sawah', 'Jagung', 'Kedelai'],
        'sumber': 'Kementerian Pertanian - Katam Terpadu Modern',
      },
    ];

    await _simpanBertahap(_koleksiFenomena, data);
  }

  static Future<void> _simpanBertahap(
    String namaKoleksi,
    List<Map<String, dynamic>> data,
  ) async {
    const ukuranBatch = 400;

    for (int mulai = 0; mulai < data.length; mulai += ukuranBatch) {
      final akhir = (mulai + ukuranBatch < data.length)
          ? mulai + ukuranBatch
          : data.length;

      final batch = _firestore.batch();

      for (int i = mulai; i < akhir; i++) {
        final item = data[i];

        final String id =
            item['id']?.toString() ??
            item['tanggal']?.toString() ??
            DateTime.now().millisecondsSinceEpoch.toString();

        final referensi = _firestore.collection(namaKoleksi).doc(id);

        batch.set(referensi, {
          ...item,
          'updated_at': FieldValue.serverTimestamp(),
        }, SetOptions(merge: true));
      }

      await batch.commit();

      print(
        'Firestore: $namaKoleksi '
        '${mulai + 1}-$akhir dari ${data.length}',
      );
    }
  }

  static String _formatTanggal(DateTime tanggal) {
    final bulan = tanggal.month.toString().padLeft(2, '0');
    final hari = tanggal.day.toString().padLeft(2, '0');

    return '${tanggal.year}-$bulan-$hari';
  }

  static String _namaHari(int weekday) {
    const hari = [
      'Senin',
      'Selasa',
      'Rabu',
      'Kamis',
      'Jumat',
      'Sabtu',
      'Minggu',
    ];

    return hari[weekday - 1];
  }

  static String _namaPasaran(DateTime tanggal) {
    final acuan = DateTime(2000, 1, 1);
    final selisih = tanggal.difference(acuan).inDays;

    const pasaran = ['Legi', 'Pahing', 'Pon', 'Wage', 'Kliwon'];

    return pasaran[(1 + selisih) % 5];
  }

  static int _neptuHari(int weekday) {
    const nilai = {1: 4, 2: 3, 3: 7, 4: 8, 5: 6, 6: 9, 7: 5};

    return nilai[weekday]!;
  }

  static int _neptuPasaran(String pasaran) {
    const nilai = {'Legi': 5, 'Pahing': 9, 'Pon': 7, 'Wage': 4, 'Kliwon': 8};

    return nilai[pasaran]!;
  }

  static _DataMangsa _tentukanMangsa(DateTime tanggal) {
    final tahun = tanggal.year;

    final batas = <_BatasMangsa>[
      _BatasMangsa(
        DateTime(tahun, 2, 3),
        'Kawolu',
        'Musim penghujan',
        'Masa penghujan; aktivitas pertanian mengikuti kondisi '
            'air dan lahan.',
      ),
      _BatasMangsa(
        DateTime(tahun, 3, 1),
        'Kasanga',
        'Musim penghujan',
        'Masa penghujan; memperhatikan kondisi air dan '
            'tanda-tanda alam.',
      ),
      _BatasMangsa(
        DateTime(tahun, 3, 26),
        'Kadasa',
        'Peralihan',
        'Masa peralihan; kegiatan pertanian mengikuti kondisi '
            'lahan dan air.',
      ),
      _BatasMangsa(
        DateTime(tahun, 4, 19),
        'Dhesta',
        'Peralihan',
        'Masa peralihan; memperhatikan perubahan kondisi musim.',
      ),
      _BatasMangsa(
        DateTime(tahun, 5, 13),
        'Sadha',
        'Musim kemarau',
        'Memasuki periode kemarau; ketersediaan air perlu '
            'diperhatikan.',
      ),
      _BatasMangsa(
        DateTime(tahun, 6, 22),
        'Kasa',
        'Musim kemarau',
        'Periode kemarau; pengelolaan air menjadi perhatian penting.',
      ),
      _BatasMangsa(
        DateTime(tahun, 8, 2),
        'Karo',
        'Musim kemarau',
        'Periode kemarau; kegiatan pertanian menyesuaikan '
            'ketersediaan air.',
      ),
      _BatasMangsa(
        DateTime(tahun, 8, 14),
        'Katelu',
        'Musim kemarau',
        'Periode kemarau; memperhatikan kondisi kelembapan lahan.',
      ),
      _BatasMangsa(
        DateTime(tahun, 9, 18),
        'Kapat',
        'Peralihan',
        'Masa peralihan; memperhatikan perubahan musim dan '
            'kondisi air.',
      ),
      _BatasMangsa(
        DateTime(tahun, 10, 13),
        'Kalima',
        'Musim penghujan',
        'Memasuki periode penghujan; persiapan lahan dan '
            'saluran air perlu diperhatikan.',
      ),
      _BatasMangsa(
        DateTime(tahun, 11, 9),
        'Kanem',
        'Musim penghujan',
        'Periode penghujan; kegiatan pertanian mengikuti '
            'kondisi air.',
      ),
      _BatasMangsa(
        DateTime(tahun, 12, 22),
        'Kapitu',
        'Musim penghujan',
        'Periode penghujan; kondisi drainase dan genangan '
            'perlu diperhatikan.',
      ),
    ];

    _BatasMangsa hasil = _BatasMangsa(
      DateTime(tahun, 12, 22),
      'Kapitu',
      'Musim penghujan',
      'Periode penghujan; kondisi drainase dan genangan '
          'perlu diperhatikan.',
    );

    for (final item in batas) {
      if (!tanggal.isBefore(item.mulai)) {
        hasil = item;
      }
    }

    return _DataMangsa(
      nama: hasil.nama,
      periode: hasil.periode,
      kegiatan: hasil.kegiatan,
    );
  }
}

class _BatasMangsa {
  final DateTime mulai;
  final String nama;
  final String periode;
  final String kegiatan;

  _BatasMangsa(this.mulai, this.nama, this.periode, this.kegiatan);
}

class _DataMangsa {
  final String nama;
  final String periode;
  final String kegiatan;

  _DataMangsa({
    required this.nama,
    required this.periode,
    required this.kegiatan,
  });
}

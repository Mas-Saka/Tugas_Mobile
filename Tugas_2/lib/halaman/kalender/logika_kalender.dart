class HasilWeton {
  final String hari;
  final String pasaran;
  final String weton;

  final int neptuHari;
  final int neptuPasaran;
  final int totalNeptu;

  final int tahunJawa;
  final String namaTahunJawa;

  HasilWeton({
    required this.hari,
    required this.pasaran,
    required this.weton,
    required this.neptuHari,
    required this.neptuPasaran,
    required this.totalNeptu,
    required this.tahunJawa,
    required this.namaTahunJawa,
  });
}

class HasilSaka {
  final int tahunSaka;
  final String sasih;
  final String wuku;
  final String pancawara;
  final String saptawara;

  HasilSaka({
    required this.tahunSaka,
    required this.sasih,
    required this.wuku,
    required this.pancawara,
    required this.saptawara,
  });
}

class LogikaKalender {
  // Patokan untuk menghitung siklus pasaran dan wuku.
  static final DateTime _patokanTanggal = DateTime(2000, 1, 1);

  // =========================
  // NAMA HARI MASEHI
  // =========================

  static const Map<int, String> _namaHariMap = {
    1: 'Senin',
    2: 'Selasa',
    3: 'Rabu',
    4: 'Kamis',
    5: 'Jumat',
    6: 'Sabtu',
    7: 'Minggu',
  };

  // =========================
  // NEPTU HARI
  // =========================

  static const Map<String, int> _neptuHariMap = {
    'Senin': 4,
    'Selasa': 3,
    'Rabu': 7,
    'Kamis': 8,
    'Jumat': 6,
    'Sabtu': 9,
    'Minggu': 5,
  };

  // =========================
  // PASARAN JAWA
  // =========================

  static const List<String> _daftarPasaran = [
    'Pahing',
    'Pon',
    'Wage',
    'Kliwon',
    'Legi',
  ];

  static const Map<String, int> _neptuPasaranMap = {
    'Legi': 5,
    'Pahing': 9,
    'Pon': 7,
    'Wage': 4,
    'Kliwon': 8,
  };

  // =========================
  // NAMA TAHUN JAWA
  // =========================
  //
  // Siklus windu:
  // Alip -> Ehe -> Jimawal -> Je ->
  // Dal -> Be -> Wawu -> Jimakir
  //

  static const List<String> _namaTahunJawa = [
    'Alip',
    'Ehe',
    'Jimawal',
    'Je',
    'Dal',
    'Be',
    'Wawu',
    'Jimakir',
  ];

  // =========================
  // WUKU BALI / JAWA
  // =========================

  static const List<String> _daftarWuku = [
    'Sinta',
    'Landep',
    'Ukir',
    'Kulantir',
    'Tolu',
    'Gumbreg',
    'Wariga',
    'Warigadean',
    'Julungwangi',
    'Sungsang',
    'Dungulan',
    'Kuningan',
    'Langkir',
    'Medangsia',
    'Pujut',
    'Pahang',
    'Krulut',
    'Merakih',
    'Tambir',
    'Medangkungan',
    'Matal',
    'Uye',
    'Menail',
    'Prangbakat',
    'Bala',
    'Ugu',
    'Wayang',
    'Kulawu',
    'Dukut',
    'Watugunung',
  ];

  // =========================
  // PANCAWARA BALI
  // =========================

  static const List<String> _daftarPancawara = [
    'Umanis',
    'Paing',
    'Pon',
    'Wage',
    'Kliwon',
  ];

  // =========================
  // SAPTAWARA BALI
  // =========================

  static const List<String> _daftarSaptawara = [
    'Redite',
    'Soma',
    'Anggara',
    'Buda',
    'Wraspati',
    'Sukra',
    'Saniscara',
  ];

  // =========================
  // SASIH BALI
  // =========================

  static const List<String> _daftarSasih = [
    'Caitra',
    'Waisaka',
    'Jyestha',
    'Asadha',
    'Srawana',
    'Bhadrawada',
    'Aswina',
    'Kartika',
    'Margasira',
    'Posya',
    'Magha',
    'Phalguna',
  ];

  // =========================
  // HITUNG WETON
  // =========================

  static HasilWeton hitungWeton(DateTime date) {
    // -------------------------
    // Hari Masehi
    // -------------------------

    String hari = _namaHariMap[date.weekday]!;

    // -------------------------
    // Pasaran
    // -------------------------

    int selisihHari = date.difference(_patokanTanggal).inDays;

    int indexPasaran =
        (selisihHari % _daftarPasaran.length + _daftarPasaran.length) %
        _daftarPasaran.length;

    String pasaran = _daftarPasaran[indexPasaran];

    // -------------------------
    // Neptu
    // -------------------------

    int neptuHari = _neptuHariMap[hari]!;
    int neptuPasaran = _neptuPasaranMap[pasaran]!;
    int totalNeptu = neptuHari + neptuPasaran;

    // -------------------------
    // Tahun Jawa
    // -------------------------

    Map<String, dynamic> tahunJawa = _hitungTahunJawa(date);

    int tahun = tahunJawa['tahun'];
    String namaTahun = tahunJawa['nama'];

    return HasilWeton(
      hari: hari,
      pasaran: pasaran,
      weton: '$hari $pasaran',
      neptuHari: neptuHari,
      neptuPasaran: neptuPasaran,
      totalNeptu: totalNeptu,
      tahunJawa: tahun,
      namaTahunJawa: namaTahun,
    );
  }

  // =========================
  // HITUNG TAHUN JAWA
  // =========================

  static Map<String, dynamic> _hitungTahunJawa(DateTime date) {
    /*
      Tahun Jawa berganti ketika masuk 1 Sura.

      Untuk periode yang sedang kita gunakan:
      1 Januari 2026 - 15 Juni 2026
          = 1959 Dal

      16 Juni 2026 - 5 Juni 2027
          = 1960 Be

      6 Juni 2027
          = 1961 Wawu
    */

    final tanggalAwal2026 = DateTime(2026, 1, 1);
    final satuSura1960 = DateTime(2026, 6, 16);
    final satuSura1961 = DateTime(2027, 6, 6);

    // 2026 sebelum 1 Sura
    if (!date.isBefore(tanggalAwal2026)) {
      if (date.isBefore(satuSura1960)) {
        return {'tahun': 1959, 'nama': 'Dal'};
      }

      // 1960 Be
      if (date.isBefore(satuSura1961)) {
        return {'tahun': 1960, 'nama': 'Be'};
      }

      // 1961 Wawu
      return {'tahun': 1961, 'nama': 'Wawu'};
    }

    // Untuk tanggal sebelum 2026,
    // gunakan pendekatan nomor tahun.
    int tahunJawa = date.year - 67;

    int indexNama = (tahunJawa - 1959) % 8;

    if (indexNama < 0) {
      indexNama += 8;
    }

    return {'tahun': tahunJawa, 'nama': _namaTahunJawa[indexNama]};
  }

  // =========================
  // HITUNG SAKA BALI
  // =========================

  static HasilSaka hitungSakaBali(DateTime date) {
    // -------------------------
    // Tahun Saka
    // -------------------------

    int tahunSaka = date.year - 78;

    // Nyepi biasanya sekitar bulan Maret.
    // Untuk perhitungan sederhana,
    // sebelum 21 Maret dianggap masih tahun Saka sebelumnya.
    final perkiraanNyepi = DateTime(date.year, 3, 21);

    if (date.isBefore(perkiraanNyepi)) {
      tahunSaka--;
    }

    // -------------------------
    // Sasih
    // -------------------------

    String sasih = _hitungSasih(date);

    // -------------------------
    // Wuku
    // -------------------------

    int selisihHari = date.difference(_patokanTanggal).inDays;

    int hariDalamSiklus = (selisihHari + 6) % 210;

    int indexWuku = hariDalamSiklus ~/ 7;

    String wuku = _daftarWuku[indexWuku];

    // -------------------------
    // Pancawara
    // -------------------------

    int indexPancawara = (selisihHari % 5 + 5) % 5;

    String pancawara = _daftarPancawara[indexPancawara];

    // -------------------------
    // Saptawara
    // -------------------------

    int indexSaptawara = date.weekday % 7;

    String saptawara = _daftarSaptawara[indexSaptawara];

    return HasilSaka(
      tahunSaka: tahunSaka,
      sasih: sasih,
      wuku: wuku,
      pancawara: pancawara,
      saptawara: saptawara,
    );
  }

  // =========================
  // HITUNG SASIH
  // =========================

  static String _hitungSasih(DateTime date) {
    int bulan = date.month;

    switch (bulan) {
      case 3:
        return 'Caitra';

      case 4:
        return 'Waisaka';

      case 5:
        return 'Jyestha';

      case 6:
        return 'Asadha';

      case 7:
        return 'Srawana';

      case 8:
        return 'Bhadrawada';

      case 9:
        return 'Aswina';

      case 10:
        return 'Kartika';

      case 11:
        return 'Margasira';

      case 12:
        return 'Posya';

      case 1:
        return 'Magha';

      case 2:
        return 'Phalguna';

      default:
        return 'Caitra';
    }
  }

  // =========================
  // FORMAT TANGGAL INDONESIA
  // =========================

  static String formatTanggalIndonesia(DateTime date) {
    const List<String> namaBulan = [
      'Januari',
      'Februari',
      'Maret',
      'April',
      'Mei',
      'Juni',
      'Juli',
      'Agustus',
      'September',
      'Oktober',
      'November',
      'Desember',
    ];

    return '${date.day} ${namaBulan[date.month - 1]} ${date.year}';
  }
}

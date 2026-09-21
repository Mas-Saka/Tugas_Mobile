import 'package:flutter/foundation.dart';

/// Class [HasilWeton] menampung data hasil perhitungan Weton Jawa.
class HasilWeton {
  final String hari;
  final String pasaran;
  final String weton;
  final int neptuHari;
  final int neptuPasaran;
  final int totalNeptu;

  HasilWeton({
    required this.hari,
    required this.pasaran,
    required this.weton,
    required this.neptuHari,
    required this.neptuPasaran,
    required this.totalNeptu,
  });
}

/// Class [HasilSaka] menampung data hasil perhitungan Kalender Saka Bali.
class HasilSaka {
  final int tahunSaka;
  final String sasih;
  final String wuku;

  HasilSaka({
    required this.tahunSaka,
    required this.sasih,
    required this.wuku,
  });
}

/// Class [LogikaKalender] berisi algoritma dan perhitungan sistem penanggalan
/// Weton Jawa dan Kalender Saka Bali.
class LogikaKalender {
  // Patokan Referensi Algoritma: 1 Januari 2000 = Sabtu Pahing
  static final DateTime _patokanTanggal = DateTime(2000, 1, 1);

  // 1. DAFTAR HARI MASEHI & NEPTU HARI
  // Nama-nama hari (1 = Senin, 7 = Minggu)
  static const Map<int, String> _namaHariMap = {
    1: 'Senin',
    2: 'Selasa',
    3: 'Rabu',
    4: 'Kamis',
    5: 'Jumat',
    6: 'Sabtu',
    7: 'Minggu',
  };

  // Nilai Neptu Hari Jawa:
  // Minggu: 5, Senin: 4, Selasa: 3, Rabu: 7, Kamis: 8, Jumat: 6, Sabtu: 9
  static const Map<int, int> _neptuHariMap = {
    1: 4, // Senin
    2: 3, // Selasa
    3: 7, // Rabu
    4: 8, // Kamis
    5: 6, // Jumat
    6: 9, // Sabtu
    7: 5, // Minggu
  };

  // 2. DAFTAR PASARAN JAWA & NEPTU PASARAN
  // Pada 1 Jan 2000 pasaran adalah Pahing (Index 0)
  // Urutan Pasaran: Pahing (0), Pon (1), Wage (2), Kliwon (3), Legi (4)
  static const List<String> _daftarPasaran = [
    'Pahing',
    'Pon',
    'Wage',
    'Kliwon',
    'Legi',
  ];

  // Nilai Neptu Pasaran Jawa:
  // Legi: 5, Pahing: 9, Pon: 7, Wage: 4, Kliwon: 8
  static const Map<String, int> _neptuPasaranMap = {
    'Legi': 5,
    'Pahing': 9,
    'Pon': 7,
    'Wage': 4,
    'Kliwon': 8,
  };

  /// ALGORITMA WETON JAWA
  /// Menghitung Hari, Pasaran, Weton, dan Neptu dari tanggal Masehi yang dipilih.
  static HasilWeton hitungWeton(DateTime date) {
    // Normalisasi tanggal ke 00:00:00 agar tidak terpengaruh perbedaan jam
    final target = DateTime(date.year, date.month, date.day);

    // Ambil Hari & Neptu Hari dari angka weekday Dart (1 = Senin, 7 = Minggu)
    final int weekday = target.weekday;
    final String namaHari = _namaHariMap[weekday] ?? 'Senin';
    final int neptuHari = _neptuHariMap[weekday] ?? 0;

    // Hitung selisih hari dari patokan 1 Januari 2000
    final int selisihHari = target.difference(_patokanTanggal).inDays;

    // Hitung index pasaran menggunakan fungsi modulo 5
    int pasaranIndex = selisihHari % 5;
    if (pasaranIndex < 0) {
      pasaranIndex += 5; // Penyesuaian jika selisih bernilai negatif (tanggal sebelum tahun 2000)
    }

    final String namaPasaran = _daftarPasaran[pasaranIndex];
    final int neptuPasaran = _neptuPasaranMap[namaPasaran] ?? 0;
    final int totalNeptu = neptuHari + neptuPasaran;

    return HasilWeton(
      hari: namaHari,
      pasaran: namaPasaran,
      weton: '$namaHari $namaPasaran',
      neptuHari: neptuHari,
      neptuPasaran: neptuPasaran,
      totalNeptu: totalNeptu,
    );
  }

  // 3. DAFTAR WUKU BALI (30 Wuku dalam siklus Pawukon 210 Hari)
  static const List<String> _daftarWuku = [
    'Sinta', 'Landep', 'Ukir', 'Kulantir', 'Tolu', 'Gumbreg',
    'Wariga', 'Warigadean', 'Julungwangi', 'Sungsang', 'Dungulan', 'Kuningan',
    'Langkir', 'Medangsia', 'Pujut', 'Pahang', 'Krulut', 'Merakih',
    'Tambir', 'Medangkungan', 'Matal', 'Uye', 'Menail', 'Prangbakat',
    'Bala', 'Ugu', 'Wayang', 'Kulawu', 'Dukut', 'Watugunung',
  ];

  // 4. DAFTAR SASIH BALI (12 Sasih)
  static const List<String> _daftarSasih = [
    'Kapitu', 'Kawulu', 'Kasanga', 'Kadasa', 'Jyestha', 'Sadha',
    'Kasa', 'Karo', 'Katiga', 'Kapat', 'Kalima', 'Kanem',
  ];

  /// ALGORITMA KALENDER SAKA BALI (Hitungan Sederhana)
  /// Menghitung Tahun Saka, Sasih, dan Wuku berdasarkan selisih tanggal Masehi.
  static HasilSaka hitungSakaBali(DateTime date) {
    final target = DateTime(date.year, date.month, date.day);

    // 1. Perhitungan Tahun Saka (Tahun Masehi - 78, atau -79 jika sebelum Nyepi pertengahan Maret)
    int tahunSaka = target.year - 78;
    if (target.month < 3 || (target.month == 3 && target.day < 21)) {
      tahunSaka = target.year - 79;
    }

    // 2. Perhitungan Sasih Bali berdasarkan bulan Masehi (Bulan 1 = Sasih Kapitu)
    final String sasih = _daftarSasih[(target.month - 1) % 12];

    // 3. Perhitungan Wuku Bali (Siklus Pawukon 210 Hari = 30 Wuku x 7 Hari)
    // Pada 1 Jan 2000 (Sabtu Pahing), bertepatan dengan Wuku Landep (Index 1) hari ke-6.
    final int selisihHari = target.difference(_patokanTanggal).inDays;
    const int offsetHariLandep = 6;
    int hariDalamSiklus = (selisihHari + offsetHariLandep + 7) % 210;
    if (hariDalamSiklus < 0) {
      hariDalamSiklus += 210;
    }

    final int indexWuku = (hariDalamSiklus / 7).floor() % 30;
    final String wuku = _daftarWuku[indexWuku];

    return HasilSaka(
      tahunSaka: tahunSaka,
      sasih: sasih,
      wuku: wuku,
    );
  }

  /// Helper untuk memformat tanggal Masehi ke Bahasa Indonesia
  static String formatTanggalIndonesia(DateTime date) {
    const listBulan = [
      'Januari', 'Februari', 'Maret', 'April', 'Mei', 'Juni',
      'Juli', 'Agustus', 'September', 'Oktober', 'November', 'Desember'
    ];
    return "${date.day} ${listBulan[date.month - 1]} ${date.year}";
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';

class DataTanamanAwal {
  static Future<void> isiData() async {
    final firestore = FirebaseFirestore.instance;

    // =========================
    // PADI
    // =========================
    await firestore.collection('tanaman').doc('padi').set({
      'nama': 'Padi',

      'umur_panen_min': 105,
      'umur_panen_max': 124,
      'umur_panen_referensi': 110,

      'urea_min': 325,
      'urea_max': 325,

      'sp36_min': 50,
      'sp36_max': 50,

      'kcl_min': 30,
      'kcl_max': 30,

      'satuan_pupuk': 'kg/ha',

      'sumber':
          'Kementerian Pertanian - Pengelolaan Hara Spesifik Lokasi (PHSL)',
    });

    // =========================
    // JAGUNG
    // =========================
    await firestore.collection('tanaman').doc('jagung').set({
      'nama': 'Jagung',

      'umur_panen_min': 90,
      'umur_panen_max': 105,
      'umur_panen_referensi': 100,

      'urea_min': 450,
      'urea_max': 450,

      'sp36_min': 100,
      'sp36_max': 150,

      'kcl_min': 50,
      'kcl_max': 100,

      'satuan_pupuk': 'kg/ha',

      'sumber': 'Kementerian Pertanian - Budidaya Jagung',
    });

    // =========================
    // KEDELAI
    // =========================
    await firestore.collection('tanaman').doc('kedelai').set({
      'nama': 'Kedelai',

      'umur_panen_min': 76,
      'umur_panen_max': 93,
      'umur_panen_referensi': 85,

      'urea_min': 75,
      'urea_max': 75,

      'sp36_min': 100,
      'sp36_max': 100,

      'kcl_min': 100,
      'kcl_max': 100,

      'satuan_pupuk': 'kg/ha',

      'sumber': 'Kementerian Pertanian - Teknologi Budidaya Kedelai',
    });

    // =========================
    // KACANG TANAH
    // =========================
    await firestore.collection('tanaman').doc('kacang_tanah').set({
      'nama': 'Kacang Tanah',

      'umur_panen_min': 90,
      'umur_panen_max': 110,
      'umur_panen_referensi': 100,

      'urea_min': 75,
      'urea_max': 75,

      'sp36_min': 100,
      'sp36_max': 100,

      'kcl_min': 100,
      'kcl_max': 100,

      'satuan_pupuk': 'kg/ha',

      'sumber': 'Kementerian Pertanian - Teknologi Budidaya Kacang Tanah',
    });

    // =========================
    // UBI KAYU
    // =========================
    await firestore.collection('tanaman').doc('ubi_kayu').set({
      'nama': 'Ubi Kayu',

      'umur_panen_min': 240,
      'umur_panen_max': 330,
      'umur_panen_referensi': 285,

      'urea_min': 200,
      'urea_max': 200,

      'sp36_min': 100,
      'sp36_max': 100,

      'kcl_min': 100,
      'kcl_max': 100,

      'satuan_pupuk': 'kg/ha',

      'sumber': 'Kementerian Pertanian - Pedoman Budi Daya Ubi Kayu',
    });

    // =========================
    // UBI JALAR
    // =========================
    await firestore.collection('tanaman').doc('ubi_jalar').set({
      'nama': 'Ubi Jalar',

      'umur_panen_min': 150,
      'umur_panen_max': 150,
      'umur_panen_referensi': 150,

      'urea_min': 100,
      'urea_max': 100,

      'sp36_min': 100,
      'sp36_max': 100,

      'kcl_min': 100,
      'kcl_max': 100,

      'satuan_pupuk': 'kg/ha',

      'sumber':
          'Kementerian Pertanian - Kajian Adaptasi dan Stabilitas '
          'Hasil Varietas Unggul Ubi Jalar',
    });

    // =========================
    // CABAI MERAH
    // =========================
    await firestore.collection('tanaman').doc('cabai_merah').set({
      'nama': 'Cabai Merah',

      'umur_panen_min': 75,
      'umur_panen_max': 85,
      'umur_panen_referensi': 80,

      'urea_min': 50,
      'urea_max': 100,

      'sp36_min': 100,
      'sp36_max': 200,

      'kcl_min': 75,
      'kcl_max': 150,

      'satuan_pupuk': 'kg/ha',

      'sumber': 'Kementerian Pertanian - Budidaya dan Pascapanen Cabai Merah',
    });
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';

class DataTanaman {
  final String id;
  final String nama;

  final int umurPanenMin;
  final int umurPanenMax;
  final int umurPanenReferensi;

  final double ureaMin;
  final double ureaMax;

  final double sp36Min;
  final double sp36Max;

  final double kclMin;
  final double kclMax;

  final String satuanPupuk;
  final String sumber;
  final String konteks;

  DataTanaman({
    required this.id,
    required this.nama,
    required this.umurPanenMin,
    required this.umurPanenMax,
    required this.umurPanenReferensi,
    required this.ureaMin,
    required this.ureaMax,
    required this.sp36Min,
    required this.sp36Max,
    required this.kclMin,
    required this.kclMax,
    required this.satuanPupuk,
    required this.sumber,
    required this.konteks,
  });

  factory DataTanaman.dariFirestore(String id, Map<String, dynamic> data) {
    return DataTanaman(
      id: id,
      nama: data['nama'] ?? '',

      umurPanenMin: (data['umur_panen_min'] ?? 0).toInt(),

      umurPanenMax: (data['umur_panen_max'] ?? 0).toInt(),

      umurPanenReferensi: (data['umur_panen_referensi'] ?? 0).toInt(),

      ureaMin: (data['urea_min'] ?? 0).toDouble(),

      ureaMax: (data['urea_max'] ?? 0).toDouble(),

      sp36Min: (data['sp36_min'] ?? 0).toDouble(),

      sp36Max: (data['sp36_max'] ?? 0).toDouble(),

      kclMin: (data['kcl_min'] ?? 0).toDouble(),

      kclMax: (data['kcl_max'] ?? 0).toDouble(),

      satuanPupuk: data['satuan_pupuk'] ?? 'kg/ha',

      sumber: data['sumber'] ?? '',

      konteks: data['konteks'] ?? '',
    );
  }
}

class LayananTanaman {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<DataTanaman>> ambilTanaman() async {
    final hasil = await _firestore.collection('tanaman').orderBy('nama').get();

    return hasil.docs.map((doc) {
      return DataTanaman.dariFirestore(doc.id, doc.data());
    }).toList();
  }
}

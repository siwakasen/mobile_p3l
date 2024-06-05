import 'package:mobile_p3l/src/data/models/pendapatanModel.dart';
import 'package:mobile_p3l/src/data/models/pengeluaranModel.dart';
import 'package:mobile_p3l/src/data/models/pengeluaranLainModel.dart';

class LaporanCashflow {
  int? total;
  List<Pendapatan>? pendapatan;
  List<Pengeluaran>? pengeluaran;
  List<PengeluaranLain>? pengeluaranLain;

  LaporanCashflow({this.total, this.pendapatan, this.pengeluaran, this.pengeluaranLain});

  factory LaporanCashflow.fromJson(Map<String, dynamic> json) {
    return LaporanCashflow(
        total: json['total'],
        pendapatan: (json['pendapatan'] as List)
            .map((e) => Pendapatan.fromJson(e))
            .toList(),
        pengeluaran: (json['pengeluaran'] as List)
            .map((e) => Pengeluaran.fromJson(e))
            .toList(),
        pengeluaranLain: (json['pengeluaran_lain'] as List)
            .map((e) => PengeluaranLain.fromJson(e))
            .toList());
  }

  Map<String, dynamic> toJson() {
    return {
      'total': total,
      'pendapatan': pendapatan?.map((e) => e.toJson()).toList(),
      'pengeluaran': pengeluaran?.map((e) => e.toJson()).toList(),
      'pengeluaran_lain': pengeluaranLain?.map((e) => e.toJson()).toList()
    };
  }
}

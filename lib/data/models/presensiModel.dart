// ignore_for_file: non_constant_identifier_names, file_names

import 'package:mobile_p3l/data/models/karyawanModel.dart';

class Presensi {
  final int id_presensi;
  final Karyawan karyawan;
  final String status;
  final String tanggal;

  Presensi({
    required this.id_presensi,
    required this.karyawan,
    required this.status,
    required this.tanggal
  });

  factory Presensi.fromJson(Map<String, dynamic> json) {
    return Presensi(
      id_presensi: json['id_presensi'],
      karyawan: Karyawan.fromJson(json['karyawan']),
      status: json['status'],
      tanggal: json['tanggal']
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id_presensi': id_presensi,
      'karyawan': karyawan.toJson(),
      'status': status,
      'tanggal': tanggal
    };
  }
}
// ignore_for_file: non_constant_identifier_names, file_names

import 'package:mobile_p3l/data/models/roleModel.dart';

class Karyawan {
  final int id_karyawan;
  final String nama_karyawan;
  final Role role;
  final String email;
  final String password;
  final String tanggal_masuk;
  final int bonus_gaji;

  Karyawan({
    required this.id_karyawan,
    required this.nama_karyawan,
    required this.role,
    required this.email,
    required this.password,
    required this.tanggal_masuk,
    required this.bonus_gaji
  });

  factory Karyawan.fromJson(Map<String, dynamic> json) {
    return Karyawan(
      id_karyawan: json['id_karyawan'],
      nama_karyawan: json['nama_karyawan'],
      role: Role.fromJson(json['role']),
      email: json['email'],
      password: json['password'],
      tanggal_masuk: json['tanggal_masuk'],
      bonus_gaji: json['bonus_gaji']
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id_karyawan': id_karyawan,
      'nama_karyawan': nama_karyawan,
      'role': role.toJson(),
      'email': email,
      'password': password,
      'tanggal_masuk': tanggal_masuk,
      'bonus_gaji': bonus_gaji
    };
  }
}
// ignore_for_file: non_constant_identifier_names, file_names

import 'package:mobile_p3l/src/data/models/kategoriModel.dart';

class Produk {
  final int id_produk;
  final int? id_penitip;
  final int id_resep;
  final String nama_produk;
  final String foto_produk;
  final String deskripsi_produk;
  final int harga_produk;
  final int stok_produk;
  final int status_produk;
  final Kategori kategori;

  Produk({
    required this.id_produk,
    required this.id_penitip,
    required this.id_resep,
    required this.nama_produk,
    required this.foto_produk,
    required this.deskripsi_produk,
    required this.harga_produk,
    required this.stok_produk,
    required this.status_produk,
    required this.kategori
  });

  factory Produk.fromJson(Map<String, dynamic> json) {
    return Produk(
      id_produk: json['id_produk'],
      id_penitip: json['id_penitip'],
      id_resep: json['id_resep'],
      nama_produk: json['nama_produk'],
      foto_produk: json['foto_produk'],
      deskripsi_produk: json['deskripsi_produk'],
      harga_produk: json['harga_produk'],
      stok_produk: json['stok_produk'],
      status_produk: json['status_produk'],
      kategori: Kategori.fromJson(json['kategori'])
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id_produk': id_produk,
      'id_penitip': id_penitip,
      'id_resep': id_resep,
      'nama_produk': nama_produk,
      'foto_produk': foto_produk,
      'deskripsi_produk': deskripsi_produk,
      'harga_produk': harga_produk,
      'stok_produk': stok_produk,
      'status_produk': status_produk,
      'kategori': kategori.toJson()
    };
  }
}
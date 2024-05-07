// ignore_for_file: non_constant_identifier_names, file_names

import 'package:mobile_p3l/src/data/models/hampersModel.dart';
import 'package:mobile_p3l/src/data/models/produkModel.dart';

class DetailOrder {
  final int? id_produk;
  final int? id_hampers;
  final int jumlah;
  final int subtotal;
  final Produk? produk;
  final Hampers? hampers;

  DetailOrder({
    this.id_produk,
    this.id_hampers,
    required this.jumlah,
    required this.subtotal,
    this.produk,
    this.hampers
  });

  factory DetailOrder.fromJson(Map<String, dynamic> json) {
    return DetailOrder(
      id_produk: json['id_produk'],
      id_hampers: json['id_hampers'],
      jumlah: json['jumlah'],
      subtotal: json['subtotal'],
      produk: json['produk'] != null ? Produk.fromJson(json['produk']) : null,
      hampers: json['hampers'] != null ? Hampers.fromJson(json['hampers']) : null
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id_produk': id_produk,
      'id_hampers': id_hampers,
      'jumlah': jumlah,
      'subtotal': subtotal,
      'produk': produk?.toJson(),
      'hampers': hampers?.toJson()
    };
  }
}
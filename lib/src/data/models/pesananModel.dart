// ignore_for_file: non_constant_identifier_names, file_names

import 'package:mobile_p3l/src/data/models/detailOrderModel.dart';

class Pesanan {
  int? id_pesanan;
  String? metode_pemesanan;
  String? metode_pengiriman;
  String? bukti_pembayaran;
  int? ongkir;
  int? total_harga;
  int? total_bayar;
  String? status_transaksi;
  String? tanggal_pesanan;
  String? tanggal_diambil;
  String? tanggal_pembayaran;
  String? alamat_pengiriman;
  int? tip;
  int? poin_dipakai;
  int? poin_didapat;
  List<DetailOrder>? detail_pesanan;

  Pesanan(
      {this.id_pesanan,
      this.metode_pemesanan,
      this.metode_pengiriman,
      this.bukti_pembayaran,
      this.ongkir,
      this.total_harga,
      this.total_bayar,
      this.status_transaksi,
      this.tanggal_pesanan,
      this.tanggal_diambil,
      this.tanggal_pembayaran,
      this.alamat_pengiriman,
      this.tip,
      this.poin_dipakai,
      this.poin_didapat,
      this.detail_pesanan});

  factory Pesanan.fromJson(Map<String, dynamic> json) {
    return Pesanan(
        id_pesanan: json['id_pesanan'],
        metode_pemesanan: json['metode_pemesanan'] ?? '',
        metode_pengiriman: json['metode_pengiriman'] ?? '',
        bukti_pembayaran: json['bukti_pembayaran'] ?? '',
        ongkir: json['ongkir'] ?? 0,
        total_harga: json['total_harga'] ?? 0,
        total_bayar: json['total_bayar'] ?? 0,
        status_transaksi: json['status_transaksi'],
        tanggal_pesanan: json['tanggal_pesanan'] ?? '',
        tanggal_diambil: json['tanggal_diambil'] ?? '',
        tanggal_pembayaran: json['tanggal_pembayaran'] ?? '',
        alamat_pengiriman: json['alamat_pengiriman'] ?? '',
        tip: json['tip'] ?? 0,
        poin_dipakai: json['poin_dipakai'] ?? 0,
        poin_didapat: json['poin_didapat'] ?? 0,
        detail_pesanan: (json['detail_pesanan'] as List)
            .map((e) => DetailOrder.fromJson(e))
            .toList());
  }

  Map<String, dynamic> toJson() {
    return {
      'id_pesanan': id_pesanan,
      'metode_pemesanan': metode_pemesanan,
      'metode_pengiriman': metode_pengiriman,
      'bukti_pembayaran': bukti_pembayaran,
      'ongkir': ongkir,
      'total_harga': total_harga,
      'total_bayar': total_bayar,
      'status_transaksi': status_transaksi,
      'tanggal_pesanan': tanggal_pesanan,
      'tanggal_diambil': tanggal_diambil,
      'tanggal_pembayaran': tanggal_pembayaran,
      'alamat_pengiriman': alamat_pengiriman,
      'tip': tip,
      'poin_dipakai': poin_dipakai,
      'poin_didapat': poin_didapat,
      'detail_pesanan': detail_pesanan
    };
  }
}

// ignore_for_file: non_constant_identifier_names, file_names

import 'package:mobile_p3l/src/data/models/detailOrderModel.dart';

class Pesanan {
  final int id_pesanan;
  final String metode_pemesanan;
  final String metode_pengiriman;
  final String bukti_pembayaran;
  final int ongkir;
  final int total_harga;
  final int total_bayar;
  final String status_transaksi;
  final String tanggal_pesanan;
  final String tanggal_diambil;
  final String tanggal_pembayaran;
  final String alamat_pengiriman;
  final int tip;
  final int poin_dipakai;
  final int poin_didapat;
  final List<DetailOrder> detail_pesanan;

  Pesanan({
    required this.id_pesanan,
    required this.metode_pemesanan,
    required this.metode_pengiriman,
    required this.bukti_pembayaran,
    required this.ongkir,
    required this.total_harga,
    required this.total_bayar,
    required this.status_transaksi,
    required this.tanggal_pesanan,
    required this.tanggal_diambil,
    required this.tanggal_pembayaran,
    required this.alamat_pengiriman,
    required this.tip,
    required this.poin_dipakai,
    required this.poin_didapat,
    required this.detail_pesanan
  });

  factory Pesanan.fromJson(Map<String, dynamic> json) {
    return Pesanan(
      id_pesanan: json['id_pesanan'],
      metode_pemesanan: json['metode_pemesanan'],
      metode_pengiriman: json['metode_pengiriman'],
      bukti_pembayaran: json['bukti_pembayaran'],
      ongkir: json['ongkir'],
      total_harga: json['total_harga'],
      total_bayar: json['total_bayar'],
      status_transaksi: json['status_transaksi'],
      tanggal_pesanan: json['tanggal_pesanan'],
      tanggal_diambil: json['tanggal_diambil'],
      tanggal_pembayaran: json['tanggal_pembayaran'],
      alamat_pengiriman: json['alamat_pengiriman'],
      tip: json['tip'] ?? 0,
      poin_dipakai: json['poin_dipakai'] ?? 0,
      poin_didapat: json['poin_didapat'],
      detail_pesanan: (json['detail_pesanan'] as List).map((e) => DetailOrder.fromJson(e)).toList()
    );
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
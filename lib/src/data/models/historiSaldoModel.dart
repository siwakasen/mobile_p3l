class HistoriSaldo {
  final int id_histori_saldo;
  final int id_user;
  final int nominal_saldo;
  final String keterangan_transaksi;
  final String tanggal_transaksi;
  HistoriSaldo({
    required this.id_histori_saldo,
    required this.id_user,
    required this.nominal_saldo,
    required this.keterangan_transaksi,
    required this.tanggal_transaksi,

  });

  factory HistoriSaldo.fromJson(Map<String, dynamic> json) {
    return HistoriSaldo(
      id_histori_saldo: json['id_histori_saldo'],
      id_user: json['id_user'],
      nominal_saldo: json['nominal_saldo'],
      keterangan_transaksi: json['keterangan_transaksi'],
      tanggal_transaksi: json['tanggal_transaksi']
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id_histori_saldo': id_histori_saldo,
      'id_user': id_user,
      'nominal_saldo': nominal_saldo,
      'keterangan_transaksi': keterangan_transaksi,
      'tanggal_transaksi': tanggal_transaksi
    };
  }
  
}

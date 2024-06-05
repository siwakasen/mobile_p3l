class PengeluaranLain{
  int? id_pengeluaran;
  String? nama_pengeluaran;
  int? nominal_pengeluaran;
  String? tanggal_pengeluaran;
  String? status_pengeluaran_lain;

  PengeluaranLain({this.id_pengeluaran, this.nama_pengeluaran, this.nominal_pengeluaran, this.tanggal_pengeluaran, this.status_pengeluaran_lain});

  factory PengeluaranLain.fromJson(Map<String, dynamic> json) => PengeluaranLain(
    id_pengeluaran: json['id_pengeluaran'],
    nama_pengeluaran: json['nama_pengeluaran'],
    nominal_pengeluaran: json['nominal_pengeluaran'],
    tanggal_pengeluaran: json['tanggal_pengeluaran'],
    status_pengeluaran_lain: json['status_pengeluaran_lain']
  );

  Map<String, dynamic> toJson() => {
    'id_pengeluaran': id_pengeluaran,
    'nama_pengeluaran': nama_pengeluaran,
    'nominal_pengeluaran': nominal_pengeluaran,
    'tanggal_pengeluaran': tanggal_pengeluaran,
    'status_pengeluaran_lain': status_pengeluaran_lain
  };
}

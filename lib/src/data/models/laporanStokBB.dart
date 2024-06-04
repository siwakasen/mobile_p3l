class LaporanBahanBaku {
  int? idBahanBaku;
  String? namaBahanBaku;
  int? stok;
  String? satuan;

  LaporanBahanBaku({
    this.idBahanBaku,
    this.namaBahanBaku,
    this.stok,
    this.satuan,
  });

  factory LaporanBahanBaku.fromJson(Map<String, dynamic> json) {
    return LaporanBahanBaku(
      idBahanBaku: json['id_bahan_baku'],
      namaBahanBaku: json['nama_bahan_baku'],
      stok: json['stok'],
      satuan: json['satuan'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id_bahan_baku': idBahanBaku,
      'nama_bahan_baku': namaBahanBaku,
      'stok': stok,
      'satuan': satuan,
    };
  }
}

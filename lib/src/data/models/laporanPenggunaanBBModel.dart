// ignore_for_file: file_names

class LaporanPenggunaanBB {
  final int id_bahan_baku;
  final String nama_bahan_baku;
  final String satuan;
  final int jumlah;

  LaporanPenggunaanBB({
    required this.id_bahan_baku,
    required this.nama_bahan_baku,
    required this.satuan,
    required this.jumlah,
  });

  factory LaporanPenggunaanBB.fromJson(Map<String, dynamic> json) {
    return LaporanPenggunaanBB(
      id_bahan_baku: json['id_bahan_baku'],
      nama_bahan_baku: json['nama_bahan_baku'],
      satuan: json['satuan'],
      jumlah: json['jumlah'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id_bahan_baku': id_bahan_baku,
      'nama_bahan_baku': nama_bahan_baku,
      'satuan': satuan,
      'jumlah': jumlah,
    };
  }
}
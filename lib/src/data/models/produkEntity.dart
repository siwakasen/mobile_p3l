class Produk {
  int? idProduk;
  int? idKategori;
  int? idPenitip;
  int? idResep;
  String? namaProduk;
  String? fotoProduk;
  String? deskripsiProduk;
  int? hargaProduk;
  int? stokProduk;
  int? statusProduk;
  LimitProdukHariIni? limitProdukHariIni;

  Produk({
    this.idProduk,
    this.idKategori,
    this.idPenitip,
    this.idResep,
    this.namaProduk,
    this.fotoProduk,
    this.deskripsiProduk,
    this.hargaProduk,
    this.stokProduk,
    this.statusProduk,
    this.limitProdukHariIni,
  });

  factory Produk.fromJson(Map<String, dynamic> json) => Produk(
        idProduk: json['id_produk'] as int?,
        idKategori: json['id_kategori'] as int?,
        idPenitip: json['id_penitip'] as int?,
        idResep: json['id_resep'] as int?,
        namaProduk: json['nama_produk'] as String?,
        fotoProduk: json['foto_produk'] as String?,
        deskripsiProduk: json['deskripsi_produk'] as String?,
        hargaProduk: json['harga_produk'] as int?,
        stokProduk: json['stok_produk'] as int?,
        statusProduk: json['status_produk'] as int?,
        limitProdukHariIni: json['limit_produk_hari_ini'] != null
            ? LimitProdukHariIni.fromJson(
                json['limit_produk_hari_ini'] as Map<String, dynamic>)
            : null,
      );

  Map<String, dynamic> toJson() => {
        'id_produk': idProduk,
        'id_kategori': idKategori,
        'id_penitip': idPenitip,
        'id_resep': idResep,
        'nama_produk': namaProduk,
        'foto_produk': fotoProduk,
        'deskripsi_produk': deskripsiProduk,
        'harga_produk': hargaProduk,
        'stok_produk': stokProduk,
        'status_produk': statusProduk,
        'limit_produk_hari_ini': limitProdukHariIni?.toJson(),
      };
}

class LimitProdukHariIni {
  int? idLimitProduk;
  int? idProduk;
  int? limit;
  DateTime? tanggal;

  LimitProdukHariIni({
    this.idLimitProduk,
    this.idProduk,
    this.limit,
    this.tanggal,
  });

  factory LimitProdukHariIni.fromJson(Map<String, dynamic> json) =>
      LimitProdukHariIni(
        idLimitProduk: json['id_limit_produk'] as int?,
        idProduk: json['id_produk'] as int?,
        limit: json['limit'] as int?,
        tanggal: json['tanggal'] != null
            ? DateTime.parse(json['tanggal'] as String)
            : null,
      );

  Map<String, dynamic> toJson() => {
        'id_limit_produk': idLimitProduk,
        'id_produk': idProduk,
        'limit': limit,
        'tanggal': tanggal?.toIso8601String(),
      };
}

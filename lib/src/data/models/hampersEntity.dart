class Hampers {
  int? idHampers;
  String? namaHampers;
  String? fotoHampers;
  String? deskripsiHampers;
  int? hargaHampers;
  int? statusHampers;
  int? idProduk;
  Detail? detail;

  Hampers({
    this.idHampers,
    this.namaHampers,
    this.fotoHampers,
    this.deskripsiHampers,
    this.hargaHampers,
    this.statusHampers,
    this.idProduk,
    this.detail,
  });

  factory Hampers.fromJson(Map<String, dynamic> json) => Hampers(
        idHampers: json["id_hampers"],
        namaHampers: json["nama_hampers"],
        fotoHampers: json["foto_hampers"],
        deskripsiHampers: json["deskripsi_hampers"],
        hargaHampers: json["harga_hampers"],
        statusHampers: json["status_hampers"],
        idProduk: json["id_produk"],
        detail: json["detail"] == null ? null : Detail.fromJson(json["detail"]),
      );

  Map<String, dynamic> toJson() => {
        "id_hampers": idHampers,
        "nama_hampers": namaHampers,
        "foto_hampers": fotoHampers,
        "deskripsi_hampers": deskripsiHampers,
        "harga_hampers": hargaHampers,
        "status_hampers": statusHampers,
        "detail": detail?.toJson(),
      };
}

class Detail {
  List<HamperProduk>? produk;
  List<BahanBaku>? bahanBaku;

  Detail({
    this.produk,
    this.bahanBaku,
  });

  factory Detail.fromJson(Map<String, dynamic> json) => Detail(
        produk: json["produk"] == null
            ? []
            : List<HamperProduk>.from(
                json["produk"]!.map((x) => HamperProduk.fromJson(x))),
        bahanBaku: json["bahan_baku"] == null
            ? []
            : List<BahanBaku>.from(
                json["bahan_baku"]!.map((x) => BahanBaku.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "produk": produk == null
            ? []
            : List<dynamic>.from(produk!.map((x) => x.toJson())),
        "bahan_baku": bahanBaku == null
            ? []
            : List<dynamic>.from(bahanBaku!.map((x) => x.toJson())),
      };
}

class BahanBaku {
  int? idBahanBaku;
  String? namaBahanBaku;
  int? stok;
  String? satuan;

  BahanBaku({
    this.idBahanBaku,
    this.namaBahanBaku,
    this.stok,
    this.satuan,
  });

  factory BahanBaku.fromJson(Map<String, dynamic> json) => BahanBaku(
        idBahanBaku: json["id_bahan_baku"],
        namaBahanBaku: json["nama_bahan_baku"],
        stok: json["stok"],
        satuan: json["satuan"],
      );

  Map<String, dynamic> toJson() => {
        "id_bahan_baku": idBahanBaku,
        "nama_bahan_baku": namaBahanBaku,
        "stok": stok,
        "satuan": satuan,
      };
}

class HamperProduk {
  int? idProduk;
  int? idKategori;
  dynamic idPenitip;
  int? idResep;
  String? namaProduk;
  String? fotoProduk;
  String? deskripsiProduk;
  int? hargaProduk;
  int? stokProduk;
  int? statusProduk;

  HamperProduk({
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
  });

  factory HamperProduk.fromJson(Map<String, dynamic> json) => HamperProduk(
        idProduk: json["id_produk"],
        idKategori: json["id_kategori"],
        idPenitip: json["id_penitip"],
        idResep: json["id_resep"],
        namaProduk: json["nama_produk"],
        fotoProduk: json["foto_produk"],
        deskripsiProduk: json["deskripsi_produk"],
        hargaProduk: json["harga_produk"],
        stokProduk: json["stok_produk"],
        statusProduk: json["status_produk"],
      );

  Map<String, dynamic> toJson() => {
        "id_produk": idProduk,
        "id_kategori": idKategori,
        "id_penitip": idPenitip,
        "id_resep": idResep,
        "nama_produk": namaProduk,
        "foto_produk": fotoProduk,
        "deskripsi_produk": deskripsiProduk,
        "harga_produk": hargaProduk,
        "stok_produk": stokProduk,
        "status_produk": statusProduk,
      };
}

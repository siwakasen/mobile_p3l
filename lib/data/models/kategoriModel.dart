// ignore_for_file: non_constant_identifier_names, file_names

class Kategori {
  final int id_kategori;
  final String nama_kategori;

  Kategori({
    required this.id_kategori,
    required this.nama_kategori
  });

  factory Kategori.fromJson(Map<String, dynamic> json) {
    return Kategori(
      id_kategori: json['id_kategori'],
      nama_kategori: json['nama_kategori']
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id_kategori': id_kategori,
      'nama_kategori': nama_kategori
    };
  }
}
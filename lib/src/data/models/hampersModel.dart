// ignore_for_file: non_constant_identifier_names, file_names

class Hampers {
  final int id_hampers;
  final String nama_hampers;
  final String foto_hampers;
  final String deskripsi_hampers;
  final int harga_hampers;

  Hampers({
    required this.id_hampers,
    required this.nama_hampers,
    required this.foto_hampers,
    required this.deskripsi_hampers,
    required this.harga_hampers
  });

  factory Hampers.fromJson(Map<String, dynamic> json) {
    return Hampers(
      id_hampers: json['id_hampers'],
      nama_hampers: json['nama_hampers'],
      foto_hampers: json['foto_hampers'],
      deskripsi_hampers: json['deskripsi_hampers'],
      harga_hampers: json['harga_hampers']
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id_hampers': id_hampers,
      'nama_hampers': nama_hampers,
      'foto_hampers': foto_hampers,
      'deskripsi_hampers': deskripsi_hampers,
      'harga_hampers': harga_hampers
    };
  }
}
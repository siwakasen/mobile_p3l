// ignore_for_file: non_constant_identifier_names, file_names

class Role {
  final int id_role;
  final String nama_role;
  final int nominal_gaji;

  Role({
    required this.id_role,
    required this.nama_role,
    required this.nominal_gaji
  });

  factory Role.fromJson(Map<String, dynamic> json) {
    return Role(
      id_role: json['id_role'],
      nama_role: json['nama_role'],
      nominal_gaji: json['nominal_gaji']
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id_role': id_role,
      'nama_role': nama_role,
      'nominal_gaji': nominal_gaji
    };
  }
}
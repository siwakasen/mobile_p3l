class Pengeluaran {
  final int? gaji;
  final int? penitip;
  final int? bahan_baku;

  Pengeluaran({
    this.gaji,
    this.penitip,
    this.bahan_baku,
  });
  factory Pengeluaran.fromJson(Map<String, dynamic> json) => Pengeluaran(
        gaji: json['gaji'],
        penitip: json['penitip'],
        bahan_baku: json['bahan_baku'],
      );
  Map<String, dynamic> toJson() => {
        'gaji': gaji,
        'penitip': penitip,
        'bahan_baku': bahan_baku,
      };
}

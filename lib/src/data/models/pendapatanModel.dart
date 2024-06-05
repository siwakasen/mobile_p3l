class Pendapatan{
  final int? penjualan;
  final int? tip;

  Pendapatan({
    this.penjualan,
    this.tip,
  });

  factory Pendapatan.fromJson(Map<String, dynamic> json) => Pendapatan(
    penjualan: json['penjualan'],
    tip: json['tip'],
  );

  Map<String, dynamic> toJson() => {
    'penjualan': penjualan,
    'tip': tip,
  };
}
